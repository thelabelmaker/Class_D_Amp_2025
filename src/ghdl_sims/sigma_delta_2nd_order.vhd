
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
use ieee.math_real.all;

entity SigmaDeltaSim is generic(nbits : integer := 8; outb : integer := 8);
    port(
        --  raw audio input
        X   :   in      std_logic_vector((nbits-1) downto 0);

        --  quantized output
        Y   :   buffer  std_logic_vector((outb-1) downto 0) :=  (others => '1');

        --  global clock input
        clk :   in      std_logic;

        dclk    :   in  std_logic
    );
end SigmaDeltaSim;

architecture DataFlow of SigmaDeltaSim is 

    --  extra bits to use with integrators
    constant    ebits   :   integer := 16;
    
    --  total bits for integrators
    constant    ibits   :   integer
                        :=  X'length + ebits;

    constant    cscale  :   real
                        :=  2.0**(X'length-1);

    type const_arr  is array(1 to 3) of signed((ibits-1) downto 0);

    -- coefficents for 5 bit modulator, 16x OSR
    constant A : const_arr := 
            (   to_signed(integer(cscale*real(-0.73770)), ibits), 
                to_signed(integer(cscale*real(-1.17110)), ibits),
                to_signed(integer(cscale*real(0.0)), ibits)
            );

    constant B : const_arr := 
            (   to_signed(integer(cscale*real(0.73770)), ibits),
                to_signed(integer(cscale*real(0.0)), ibits),
                to_signed(integer(cscale*real(0.0)), ibits)
            );
            
    constant C : const_arr := 
            (   to_signed(integer(cscale*real(0.91610)), ibits), 
                to_signed(integer(cscale*real(1.0000)), ibits),
                to_signed(integer(cscale*real(0)), ibits)
            );

    constant D13    : signed((ibits-1) downto 0) := 
        to_signed(integer(cscale*real(0.000)), ibits);
    
    constant E21    : signed((ibits-1) downto 0) := 
        to_signed(integer(cscale*real(-0.01570)), ibits);

    --  3 bit modulator, 64x OSR
    -- constant A : const_arr := 
    --         (   to_signed(integer(cscale*real(-1.6258)), ibits), 
    --             to_signed(integer(cscale*real(0)), ibits),
    --             to_signed(integer(cscale*real(0)), ibits)
    --         );

    -- constant B : const_arr := 
    --         (   to_signed(integer(cscale*real(1.62580)), ibits), 
    --             to_signed(integer(cscale*real(0.0)), ibits),
    --             to_signed(integer(cscale*real(0.0)), ibits)
    --         );
            
    -- constant C : const_arr := 
    --         (   to_signed(integer(cscale*real(0.98180)), ibits), 
    --             to_signed(integer(cscale*real(1.0000)), ibits),
    --             to_signed(integer(cscale*real(1)), ibits)
    --         );

    -- constant D13    : signed((ibits-1) downto 0) := 
    --     to_signed(integer(cscale*real(1.27850)), ibits);
    
    -- constant E21    : signed((ibits-1) downto 0) := 
    --     to_signed(integer(cscale*real(-0.0010)), ibits);

    --  error from difference
    signal      E1		:	signed((2*ibits-1) downto 0)  :=  (others => '0');
    signal      E2		:	signed((2*ibits-1) downto 0)  :=  (others => '0');

    --  sum of integrations
    signal      S1      :	signed((ibits-1) downto 0)  :=  (others => '0');
    signal      S2      :	signed((ibits-1) downto 0)  :=  (others => '0');
    signal      S2d     :	signed((ibits-1) downto 0)  :=  (others => '0');

    signal      X1		:	signed((ibits-1) downto 0)  :=  (others => '0');
    signal      X2		:	signed((ibits-1) downto 0)  :=  (others => '0');    

    --  padding bits to sign extend inputs
    signal      padBHX  :   signed((ibits-1) downto X'length)	:=	(others => '0');

    --  padding bits to sign extend result
    signal      padBHY  :   signed((ibits-1) downto X'length)	:=	(others => '0');

    --  padding bits to sign extend result
    constant    padBLY  :   signed((X'length - Y'length-1) downto 0)	:=	(others => '0');

    --  sign extended feedback signal
    signal      Ye      :   signed((ibits-1) downto 0)  :=	(others => '0');
    signal      Yp		:	signed((2*ibits-1) downto 0)  :=  (others => '0');
    
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
    
    padBHX  <=  (others => Xs(Xs'high));
    padBHY  <=  (others => Yp(Yp'high));
    --  sign extend the inputs so integrators dont overflow
    --Xe(Xe'high downto X'high+1) <=  (others => Xs(X'high));
    --Xe(X'high downto 0)         <=  Xs;
    Xe  <=  padBHX & Xs;


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
                    E1(E1'high) & E1(E1'high-ebits-1 downto X'length), S1, clk
                );

    int_2   :   sigma generic map(nbits => ibits)
                port map(
                    E2(E2'high) & E2(E2'high-ebits-1 downto X'length), S2, clk
                );

    -- E1 <= resize((Xe*B(1) + Ye*A(1)) sra (X'length-1), ibits);
    -- E2 <= resize((Xe*B(2) + Ye*A(2) + S1*C(1)) sra (X'length-1), ibits);
    -- Yp <= resize((Xe*B(3) + Ye*A(3) + S2*C(2) + S1*D13) sra ((X'length-1)),
    --         ibits);

    E1 <= (Xe*B(1) + Ye*A(1) + E21*S2d);
    E2 <= (Xe*B(2) + Ye*A(2) + S1*C(1));
    Yp <= (Xe*B(3) + Ye*A(3) + S2*C(2) + S1*D13);

    process(clk) begin
        if rising_edge(clk) then
            Ye  <=  (padBHY & Yp((ibits-1) downto (ibits-Y'length)) & padBLY);
            --  quantization of the output
            --  if MSB of S is 1, result negitive, output low
            --  if MSB of S is 0, result positive, output high
            Y   <=  std_logic_vector(Yp((ibits-1) downto (ibits-Y'length)));
            --  Y   <=  std_logic_vector(Yp((Yp'high-X'length) downto
            --  (Yp'length-X'length-Y'length)));
            --Y   <=  std_logic_vector(resize(Yp, Y'length));
            S2d <=  S2;
            
            


            dclkd   <=  dclk;
            dclkp   <=  dclkd xor dclk;
            if dclkp='1' and dclkd='0' then
                Xs  <=  signed(X);
            end if; 
        
        end if;
    end process;

    
end DataFlow;