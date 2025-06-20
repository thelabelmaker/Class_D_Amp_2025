--------------------------------------------------------------------------------
--
--  sigma_delta.vhd
--
--  this file contains the implementation for a 4th order sigma-delta converter.
--  the file has 2 entites. the SigmaDelta entity connects together the
--  integral aand error stages 
--
--  Entities:
--      1. sigma        :   integrator 
--      2. SigmaDelta   :   sigma-delta converter
--  
--  Revision History:
--      26 Feb 25  Ethan Labelson     inital revision 
--      27 Feb 25  Ethan Labelson     update feedback timing
--      28 Feb 25  Ethan Labelson     testing with 2 integrators
--      01 Mar 25  Ethan Labelson     remove 2nd integrator for fitting
--      03 Mar 25  Ethan Labelson     updated comments
--      14 May 25  Ethan Labelson     modified to fit with 119c project
--      ** May 25  Ethan Labelson     many slight tweaks, playing with shifts
--      ** May 25  Ethan Labelson     playing with coefficents all of May
--      02 Jun 25  Ethan Labelson     moved to single bit ouput
--      19 Jun 25  Ethan Labelson     updated docs and comments
--------------------------------------------------------------------------------

library ieee; --  import needed standard libs
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    --  entity declaration for sigma (integrator)
    --  inputs:
    --      E       :   signed opperand; error form difference operation
    --      S       :   signed buffer; current sum (delayed)
    --      clk     :   global clock signal
    --
    --  outputs:
    --      S       :   signed buffer; current sum (delayed)
    --

entity sigma is
    generic (nbits : integer := 8);
    port (
        --  error to integrate
        E   : in     signed((nbits - 1) downto 0);

        --  current sum
        S   : buffer signed((nbits - 1) downto 0) := (others => '0');

        --  global clock input
        clk : in     std_logic
    );
end entity;

architecture DataFlow of sigma is
    signal Sd : signed(S'range) := (others => '0');

begin
    S <= E + Sd; --  preform addition opperation

    process (clk)
    begin
        --  every clock cycle, add error to value currently in DFF
        --  adds input to delayed sum: S = E + (z^-1)S
        if rising_edge(clk) then
            Sd <= S;
        end if;
    end process;
end architecture;

library work;
--    use work.addr_lookup.all;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

    --  entity declaration for SigmaDelta
    --  inputs:
    --      X       :   signed opperand; error form difference operation
    --      clk     :   global clock signal
    --
    --  outputs:
    --      Y       :   signed buffer; current sum (delayed)
    --
    --  unused inputs:     
    --  these exist in the entity but arent currently used, although i used them
    --  in the past and think i may want to use them again sometime.
    --      update  :   std_logic; indicate an update from i2c interface
    --      addr    :   std_logic_vector address; which coef i2c is accessing
    --      cval    :   std_logic_vector (signed) coef; coef input from i2c rec
    --      dclk    :   std_logic data clock; can help sync incoming data
    --

entity SigmaDelta is
    generic (nbits : integer := 16; outb : integer := 5);
    port (
        --  raw audio input
        X      : in     std_logic_vector((nbits - 1) downto 0);

        --  quantized output
        Y      : buffer std_logic;

        --  global clock input
        clk    : in     std_logic;

        --  signals for changing params via i2c. currently unused.
        update : in     std_logic;
        addr   : in     std_logic_vector(7 downto 0);
        cval   : in     std_logic_vector(31 downto 0);

        --  data clock input
        dclk   : in     std_logic
    );
end entity;

architecture DataFlow of SigmaDelta is

    --  extra bits to use with integrators
    constant ebits : integer := 32;

    --  total bits for integrators
    constant ibits : integer := X'length + ebits;

    --  scale factor for 
    constant cscale : real := 2.0 ** (X'length - 1);

    type param_arr  is array(1 to 5) of signed((ibits-1) downto 0);

    type mult_arr   is array(1 to 5) of signed((2*ibits-1) downto 0);

    --  coefficents for 5 bit modulator, 16x OSR
    --  A controls the scale on the feedback from the output, A(n) => stage n
    constant A : param_arr := 
            (   to_signed(integer(cscale*real(-0.125/2)), ibits), 
                to_signed(integer(cscale*real(-0.25/2)), ibits),
                to_signed(integer(cscale*real(-0.5/2)), ibits),
                to_signed(integer(cscale*real(-0.5)), ibits),
                to_signed(integer(cscale*real(-0.0)), ibits)
            );

    --  B controls the gain on the input signal
    constant B : param_arr := 
            (   to_signed(integer(cscale*real(0.125/2)), ibits),
                to_signed(integer(cscale*real(0.25/2)), ibits),
                to_signed(integer(cscale*real(0.5/2)), ibits),
                to_signed(integer(cscale*real(0.5)), ibits),
                to_signed(integer(cscale*real(1.0)), ibits)
            );
    --  C controls the gain between stages 
    constant C : param_arr := 
            (   to_signed(integer(cscale*real(0.0625)), ibits), 
                to_signed(integer(cscale*real(0.125)), ibits),
                to_signed(integer(cscale*real(0.5)), ibits),
                to_signed(integer(cscale*real(1.0)), ibits),
                to_signed(integer(cscale*real(0)), ibits)
            );

    --  internal feedback within the modulator (helps stability)
    --  feedback from stage 2 to stage 1
    constant D21    : signed((ibits-1) downto 0) := 
        to_signed(integer(cscale*real(-0.0625/2)), ibits);

    --  feddback from stage 4 to stage 2
    constant D42    : signed((ibits-1) downto 0) := 
        to_signed(integer(cscale*real(-0.0625/4)), ibits);

    --  error from difference
    signal      E		:	param_arr;
    --  error non truncated
    signal      El      :   mult_arr;

    --  sums from integrator
    signal      S		:	param_arr;

    --  delayed sum of integrations
    signal      S2d      :	signed((ibits-1) downto 0)  :=  (others => '0');
    signal      S4d     :	signed((ibits-1) downto 0)  :=  (others => '0');

    --  padding bits to sign extend inputs
    signal padBHX : signed((ibits - 1) downto X'length) := (others => '0');

    --  padding bits to sign extend result
    signal padBHY : signed((ibits - 1) downto X'high) := (others => '0');

    --  padding bits to sign extend result
    constant padBLY : signed((X'high - 1) downto 0) := (others => '0');

    --  sign extended feedback signal
    signal Ye  : signed((ibits - 1) downto 0)     := (others => '0');
    signal Yp  : signed((ibits - 1) downto 0)     := (others => '0');
    signal Ypl : signed((2 * ibits - 1) downto 0) := (others => '0');

    --  sign extended input
    signal Xe : signed((ibits - 1) downto 0) := (others => '0');

    signal dclkd : std_logic;
    signal dclkp : std_logic;

    signal Xs : signed(x'range) := (others => '0');

    component delta
        generic (nbits : integer);
        port (
            --  input to difference
            X   : in  signed((nbits - 1) downto 0);

            --  feedback from output of quantizer
            Y   : in  signed((nbits - 1) downto 0);

            --  difference output
            E   : out signed((nbits - 1) downto 0);

            --  global clk
            clk : in  std_logic
        );
    end component;

    component sigma
        generic (nbits : integer); --  current sum 
        port (
            --  error to integrate
            E   : in     signed((nbits - 1) downto 0);

            --  current sum 
            S   : buffer signed((nbits - 1) downto 0);

            --  global clock
            clk : in     std_logic
        );
    end component;

begin

    --  sign extend the inputs so integrators dont overflow
    padBHX <= (others => Xs(Xs'high));
    padBHY <= (others => Yp(Yp'high));
    Xe <= padBHX & Xs;

    

    --  map components together, 4 integrator stanges total
    int_1   :   sigma generic map(nbits => ibits)
                port map(
                    E(1), S(1), clk
                );

    int_2   :   sigma generic map(nbits => ibits)
                port map(
                    E(2), S(2), clk
                );
    
    int_3   :   sigma generic map(nbits => ibits)
                port map(
                    E(3), S(3), clk
                );

    int_4   :   sigma generic map(nbits => ibits)
                port map(
                    E(4), S(4), clk
                );

    --  accumulate error for each stage in array
    El(1) <= Xe*B(1) + Ye*A(1) + S2d*D21;
    El(2) <= Xe*B(2) + Ye*A(2) + S(1)*C(1);
    El(3) <= Xe*B(3) + Ye*A(3) + S(2)*C(2) + S4d*D42;
    El(4) <= Xe*B(4) + Ye*A(4) + S(3)*C(3);
    Ypl   <= Xe*B(5) + Ye*A(5) + S(4)*C(4);

    --  loop through extended error array; shift out underflow and resize
    flow: for ind in El'range generate
        E(ind)  <= resize(shift_right(El(ind), X'high), ibits);
    end generate;

    Yp  <= resize(shift_right(Ypl, X'high), ibits);

    process (clk)
    begin
        if rising_edge(clk) then
            --  if the 1-bit output is 1, set Ye to most positive value
            --  if the 1-bit output is 0, set Ye to most negitive value
            Ye(Ye'high downto X'high) <= (others => Yp(Yp'high));
            Ye(X'high - 1 downto 0) <= (others => not Yp(Yp'high));

            --  quantization of the output
            --  if MSB of S is 1, result negitive, output high
            --  if MSB of S is 0, result positive, output low
            --  as im writing my comments i am realizing that this can flip the
            --  polarity of the audio, but the way i have it written in the pwm
            --  output file corrects it so it works right.
            Y <= Yp(Yp'high);

            --  store the sums from stages 2 and 4 for use with feedback
            S4d <= S(4);
            S2d <= S(2);

            --  can use data clock if needed, i was originally using one to keep
            --  my data input synced, however i later moved to doing the sync in
            --  the crossover interconnect. now no need to use data clock.
            --  variables still remain from previous version (and may want to
            --  use again at some point)
            dclkd <= dclk;
            dclkp <= dclkd xor dclk;

            --  buffer inputs 
            Xs <= signed(X);
        end if;
    end process;
end architecture;
