library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sigma is generic(nbits : integer := 8);
    port(
        E   :   in      signed((nbits-1) downto 0);

        S   :   buffer  signed((nbits-1) downto 0);

        clk :   in      std_logic
    );
end sigma;

architecture DataFlow of sigma is 
    signal  Sd  :  signed(S'range) :=  to_signed(0, S'length);
    begin
    
    
    S <=  E + Sd;
    process(clk) begin
        if rising_edge(clk) then
            Sd  <=  S;
        end if;
    end process;
end DataFlow;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity delta is generic(nbits : integer := 8);
    port(
        X   :   in  signed((nbits-1) downto 0);
        Y   :   in  signed((nbits-1) downto 0);

        E   :   out signed((nbits-1) downto 0);

        clk :   in  std_logic
    );
end delta;

architecture DataFlow of delta is 
    signal  Yt  :   signed(Y'range) :=  to_signed(0, Y'length);
    
    begin
    
    E   <=  X - Yt;

    process(clk) begin
        if rising_edge(clk) then
            Yt  <=  Y;
        end if;
    end process;
end DataFlow;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.I2S_constants.all;

entity SigmaDelta is generic(nbits : integer := 8);
    port(
        X   :   in      std_logic_vector((nbits-1) downto 0);

        Y   :   buffer  std_logic_vector((PWM_B-1) downto 0);

        clk :   in      std_logic
    );
end SigmaDelta;

architecture DataFlow of SigmaDelta is 
    constant    L   :   integer 
                    :=  1;

    constant    ebits   :   integer := X'length;
    
    constant    ibits   :   integer
                        :=  X'length + ebits;

    type    t_int   is  array(0 to L) of signed((ibits - 1) downto 0);

    signal  E_arr   :   t_int;
    signal  S_arr   :   t_int;

    signal  padB    :   signed((ebits-1) downto 0);

    signal  Ye      :   signed((ibits-1) downto 0);
    signal  Yo      :   signed((ibits-1) downto 0);

    component delta 
        generic(nbits : integer);
        port(
            X   :   in  signed((nbits-1) downto 0);
            Y   :   in  signed((nbits-1) downto 0);

            E   :   out signed((nbits-1) downto 0);

            clk :   in  std_logic;
            
            rdy :   out std_logic
        );
    end component;

    component sigma 
        generic(nbits : integer);
        port(
            E   :   in      signed((nbits-1) downto 0);

            S   :   buffer  signed((nbits-1) downto 0);

            clk :   in      std_logic
        );
    end component;
    
    begin
    
    

    Ye(Ye'high downto X'high+1)   <=  (others => not Y(Y'high));
    Ye(X'high downto X'high-Y'high)  <=  signed(Y);
    Ye((Y'high-1) downto 0)     <=  (others => '0');
    
    
    Levels : for  l in 1 to L generate
        int_l   :   sigma generic map(nbits => ibits)
                    port map(
                        E_arr(l), S_arr(l), clk
                    );
        del_l   :   delta generic map(nbits => ibits)
                    port map(
                        S_arr(l-1), Ye, E_arr(l), clk
                    );
    end generate;
    Yo  <=  S_arr(S_arr'high);
    process(clk) begin
        Y   <=  std_logic_vector(Yo(Yo'high downto (Yo'high-Y'high)));    
        padB        <=  (others => X(X'high));
        S_arr(0)    <=  padB & signed(X);
        
    end process;

end DataFlow;
