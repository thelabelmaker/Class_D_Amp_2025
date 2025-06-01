----------------------------------------------------------------------------
--
--  Sigma-Delta Quantizer
--
--  This file contains the implementation for a sigma-delta converter. There
--  are 3 different entities, one for the difference, one for the integerator,
--  and one that ties the two together. The output is a one bit quantized value.
--  All entitites are synchronus with rising edge of the clock.
--
--  Entities:
--      1. sigma        :   integrator 
--      2. delta        :   difference
--      3. SigmaDelta   :   sigma-delta converter
--  
--  Revision History:
--      02/26/25   Ethan Labelson    inital revision 
--      02/27/25   Ethan Labelson    update feedback timing
--      02/28/25   Ethan Labelson    testing with 2 integrators
--      03/01/25   Ethan Labelson    remove 2nd integrator for fitting
--      03/03/25   Ethan Labelson    updated comments
----------------------------------------------------------------------------


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

entity sigma is generic(nbits : integer := 8);
    port(
        --  error to integrate
        E   :   in      signed((nbits-1) downto 0);

        --  current sum 
        S   :   buffer  signed((nbits-1) downto 0)  :=  (others => '0');

        --  global clock input
        clk :   in      std_logic
    );
end sigma;

architecture DataFlow of sigma is 
    signal  Sd  :   signed(S'range) := (others => '0');

    begin
    S <=  E + Sd;    --  preform addition opperation
    process(clk) begin
        --  every clock cycle, add error to value currently in DFF
        --  adds input to delayed sum: S = E + (z^-1)S
        if rising_edge(clk) then
            Sd   <=  S;
            --S   <=  S + E;
        end if;
    end process;
end DataFlow;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  entity declaration for delta (difference)
--  inputs:
--      X       :   signed opperand; raw digital input
--      Y       :   signed buffer; feedback from output of quantizer
--      clk     :   global clock signal
--
--  outputs:
--      E       :   signed buffer; current difference (error)
--

entity delta is generic(nbits : integer := 8);
    port(
        --  input to difference
        X   :   in  signed((nbits-1) downto 0);

        --  feedback from output of quantizer
        Y   :   in  signed((nbits-1) downto 0);

        --  difference output
        E   :   out signed((nbits-1) downto 0);

        --  global clock input
        clk :   in  std_logic
    );
end delta;

architecture DataFlow of delta is    
    begin
    --  error is difference of X and Y
    E   <=  X - Y;
end DataFlow;




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SigmaDelta is generic(nbits : integer := 8);
    port(
        --  raw audio input
        X   :   in      std_logic_vector((nbits-1) downto 0);

        --  quantized output
        Y   :   buffer  std_logic   :=  '0';

        --  global clock input
        clk :   in      std_logic;

        dclk    :   in  std_logic
    );
end SigmaDelta;

architecture DataFlow of SigmaDelta is 

    --  extra bits to use with integrators
    constant    ebits   :   integer := X'length;
    
    --  total bits for integrators
    constant    ibits   :   integer
                        :=  X'length + ebits;

    --  error from difference
    signal      E		:	signed((ibits-1) downto 0)  :=  (others => '0');

    --  sum of integrations
    signal      S       :	signed((ibits-1) downto 0)  :=  (others => '0');

    --  padding bits to sign extend inputs
    constant    padB    :   signed((ebits-1) downto 0)	:=	(others => '0');

    --  sign extended feedback signal
    signal      Ye      :   signed((ibits-1) downto 0)  :=	(others => '0');

    --  sign extended input
    signal	    Xe		:	signed((ibits-1) downto 0)  :=	(others => '0');


    signal      dclkd   :   std_logic;
    signal      dclkp   :   std_logic;

    signal      Xs      :   signed(x'range) :=	(others => '0');


    component delta 
        generic(nbits : integer);
        port(
            --  input to difference
            X   :   in  signed((nbits-1) downto 0);

            --  feedback from output of quantizer
            Y   :   in  signed((nbits-1) downto 0);

            --  difference output
            E   :   out signed((nbits-1) downto 0);

            --  global clk
            clk :   in  std_logic
        );
    end component;

    component sigma 
        generic(nbits : integer);--  current sum 
        port(
            --  error to integrate
            E   :   in      signed((nbits-1) downto 0);

            --  current sum 
            S   :   buffer  signed((nbits-1) downto 0);

            --  global clock
            clk :   in      std_logic
        );
    end component;
    
    begin
    
    --  sign extend the inputs so integrators dont overflow
    Xe(Xe'high downto X'high+1) <=  (others => Xs(X'high));
    Xe(X'high downto 0)         <=  Xs;

    --  if the 1-bit output is 1, set Ye to most positive value
    --  if the 1-bit output is 0, set Ye to most negitive value
    Ye(Ye'high downto X'high)   <=  (others => S(S'high));
    Ye(X'high-1 downto 0)       <=  (others => not S(S'high));

    --  map components together
    int_l   :   sigma generic map(nbits => ibits)
                port map(
                    E, S, clk
                );
    del_l   :   delta generic map(nbits => ibits)
                port map(
                    Xe, Ye, E, clk
                );

    process(clk) begin
        if rising_edge(clk) then
            --  quantization of the output
            --  if MSB of S is 1, result negitive, output low
            --  if MSB of S is 0, result positive, output high
            Y   <=  not S(S'high);

            dclkd   <=  dclk;
            dclkp   <=  dclkd xor dclk;
            if (dclk and dclkp) then
                Xs  <=  signed(X);
            end if; 
        
        end if;
    end process;

    
end DataFlow;