--  
library work;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity filter_pe is
    generic (
        coefbits : integer := 16;
        xbits    : integer := 24;
        ybits    : integer := 48
    );
    port (
        X : in  signed((xbits - 1) downto 0);
        Xd : out  signed((xbits - 1) downto 0);
        Y : out signed((ybits - 1) downto 0);
        coef : in signed((coefbits - 1) downto 0);
        clk : in std_logic;
        rst : in std_logic
    );
end entity;

    architecture DataFlow of filter_pe is 
        signal Y_r : signed(Y'range);

    begin
        Y_r  <=  signed(resize(unsigned(X*coef), Y'length));
        Y <= Y_r when rst='1' else (others => '0');
        process (clk) is
        begin
            if rising_edge(clk) then 
                Xd  <= X;
            end if;
        end process;
    end DataFlow;
