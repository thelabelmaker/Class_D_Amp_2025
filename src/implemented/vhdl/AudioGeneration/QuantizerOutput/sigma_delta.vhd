
library ieee;
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
            --S   <=  S + E;
        end if;
    end process;
end architecture;

library work;
    use work.addr_lookup.all;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

entity SigmaDelta is
    generic (nbits : integer := 16; outb : integer := 5);
    port (
        --  raw audio input
        X      : in     std_logic_vector((nbits - 1) downto 0);

        --  quantized output
        Y      : buffer std_logic;

        --  global clock input
        clk    : in     std_logic;

        update : in     std_logic;
        addr   : in     std_logic_vector(7 downto 0);
        cval   : in     std_logic_vector(31 downto 0);

        dclk   : in     std_logic
    );
end entity;

architecture DataFlow of SigmaDelta is

    --  extra bits to use with integrators
    constant ebits : integer := 32;

    --  total bits for integrators
    constant ibits : integer := X'length + ebits;

    constant cscale : real := 2.0 ** (X'length - 1);

    type param_arr  is array(1 to 5) of signed((ibits-1) downto 0);

    type mult_arr   is array(1 to 5) of signed((2*ibits-1) downto 0);
    -- coefficents for 5 bit modulator, 16x OSR
    constant A : param_arr := 
            (   to_signed(integer(cscale*real(-0.125/2)), ibits), 
                to_signed(integer(cscale*real(-0.25/2)), ibits),
                to_signed(integer(cscale*real(-0.5/2)), ibits),
                to_signed(integer(cscale*real(-0.5)), ibits),
                to_signed(integer(cscale*real(-0.0)), ibits)
            );

    constant B : param_arr := 
            (   to_signed(integer(cscale*real(0.125/2)), ibits),
                to_signed(integer(cscale*real(0.25/2)), ibits),
                to_signed(integer(cscale*real(0.5/2)), ibits),
                to_signed(integer(cscale*real(0.5)), ibits),
                to_signed(integer(cscale*real(1.0)), ibits)
            );
            
    constant C : param_arr := 
            (   to_signed(integer(cscale*real(0.0625)), ibits), 
                to_signed(integer(cscale*real(0.125)), ibits),
                to_signed(integer(cscale*real(0.5)), ibits),
                to_signed(integer(cscale*real(1.0)), ibits),
                to_signed(integer(cscale*real(0)), ibits)
            );

    constant D21    : signed((ibits-1) downto 0) := 
        to_signed(integer(cscale*real(-0.0625/2)), ibits);

    constant D42    : signed((ibits-1) downto 0) := 
        to_signed(integer(cscale*real(-0.0625/4)), ibits);

    --  error from difference
    signal      E		:	param_arr;
    signal      El      :   mult_arr;
    signal      S		:	param_arr;

    --  sum of integrations
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

    padBHX <= (others => Xs(Xs'high));
    padBHY <= (others => Yp(Yp'high));
    --  sign extend the inputs so integrators dont overflow
    --Xe(Xe'high downto X'high+1) <=  (others => Xs(X'high));
    --Xe(X'high downto 0)         <=  Xs;
    Xe <= padBHX & Xs;

    --  if the 1-bit output is 1, set Ye to most positive value
    --  if the 1-bit output is 0, set Ye to most negitive value
    -- Ye(Ye'high downto X'length)         <=  (others => Yp(Yp'high));
    -- Ye(X'high downto X'high-Y'high)     <=  Yp(Yp'high downto (Yp'length-Y'length));
    -- Ye(X'high-Y'length downto 0)        <=  (others => '0');

    --Ye  <=  resize(Yp(Yp'high downto (Yp'high-Y'high)), ibits);

    -- Ye(Ye'high downto X'length)         <=  (others => Y(Y'high));
    -- Ye(X'high downto X'high-Y'high)     <=  signed(Y(Y'high downto Y'high-Y'high));
    -- Ye(X'high-Y'length downto 0)        <=  (others => not Y(Y'high));

    --  map components together
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
    
    -- E1 <= resize((Xe*B(1) + Ye*A(1)) sra (X'length-1), ibits);
    -- E2 <= resize((Xe*B(2) + Ye*A(2) + S1*C(1)) sra (X'length-1), ibits);
    -- Yp <= resize((Xe*B(3) + Ye*A(3) + S2*C(2) + S1*D13) sra ((X'length-1)),
    --         ibits);
    El(1) <= Xe*B(1) + Ye*A(1) + S2d*D21;
    El(2) <= Xe*B(2) + Ye*A(2) + S(1)*C(1);
    El(3) <= Xe*B(3) + Ye*A(3) + S(2)*C(2) + S4d*D42;
    El(4) <= Xe*B(4) + Ye*A(4) + S(3)*C(3);
    Ypl   <= Xe*B(5) + Ye*A(5) + S(4)*C(4);
    --E1  <= E1l(E1l'high) & E1l(E1l'high-ebits-1 downto X'length);
    --E2  <= E2l(E2l'high) & E2l(E2l'high-ebits-1 downto X'length);

    flow: for ind in El'range generate
        E(ind)  <= resize(shift_right(El(ind), X'high), ibits);
    end generate;

    Yp  <= resize(shift_right(Ypl, X'high), ibits);

    --Yp  <= Ypl(Ypl'high) & Ypl(Ypl'high-ebits-1 downto X'length);
    process (clk)
    begin
        if rising_edge(clk) then
            Ye(Ye'high downto X'high) <= (others => Yp(Yp'high));
            Ye(X'high - 1 downto 0) <= (others => not Yp(Yp'high));

            --  quantization of the output
            --  if MSB of S is 1, result negitive, output low
            --  if MSB of S is 0, result positive, output high
            --Y   <=  std_logic_vector(Yp((ibits-1) downto (ibits-Y'length)));
            Y <= Yp(Yp'high);

            --  Y   <=  std_logic_vector(Yp((Yp'high-X'length) downto
            --  (Yp'length-X'length-Y'length)));
            --Y   <=  std_logic_vector(resize(Yp, Y'length));
            S4d <= S(4);
            S2d <= S(2);

            dclkd <= dclk;
            dclkp <= dclkd xor dclk;
--            if dclkp = '1' and dclkd = '0' then
            Xs <= signed(X);
--            end if;
        end if;
    end process;

    -- process (update)
    -- begin
    --     if rising_edge(update) then
    --         case (addr) is
    --             when A1_addr =>
    --                 A(1) <= resize(signed(cval), ibits);
    --             when A2_addr =>
    --                 A(2) <= resize(signed(cval), ibits);
    --             when A3_addr =>
    --                 A(3) <= resize(signed(cval), ibits);
    --             when B1_addr =>
    --                 B(1) <= resize(signed(cval), ibits);
    --             when B2_addr =>
    --                 B(2) <= resize(signed(cval), ibits);
    --             when B3_addr =>
    --                 B(3) <= resize(signed(cval), ibits);
    --             when C1_addr =>
    --                 C(1) <= resize(signed(cval), ibits);
    --             when C2_addr =>
    --                 C(2) <= resize(signed(cval), ibits);
    --             when C3_addr =>
    --                 C(3) <= resize(signed(cval), ibits);
    --             when D12_addr =>
    --                 D13 <= resize(signed(cval), ibits);
    --             when E21_addr =>
    --                 E21 <= resize(signed(cval), ibits);
    --             when others =>

    --         end case;
    --     end if;
    -- end process;
end architecture;
