


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity SMA_Decimator is generic (   inbits  : integer := 16;
                                    outbits : integer := 16);
    port(
        X   :   in  std_logic_vector((inbits-1) downto 0);
        Y   :   out std_logic_vector((outbits-1) downto 0);
        clk :   std_logic
    );
end SMA_Decimator;

architecture DataFlow of SMA_Decimator is
    constant n_avg  :   integer :=  64;
    
    type memory is array((n_avg-1) downto 0) of signed(X'range);
    signal samples  :   memory;


    signal X_s  :   signed(X'range);

    --constant ebits  :   integer :=  integer(log2(n_avg));
    constant ebits  :   integer :=  n_avg;
    signal sum  :   signed((X'high + ebits) downto 0);

    begin

    process(clk) begin
        if rising_edge(clk) then
            for s in samples'high downto 1 loop
                samples(s)  <=  samples(s-1);
            end loop;
            samples(samples'low)    <=  X_s;  
            X_s <=  signed(X);
            Y   <=  std_logic_vector(sum(sum'high downto sum'high-4));
        end if;
    end process;

    process(all) 
        variable s_temp :   signed(sum'range):=	(others => '0');
    begin

        s_temp :=  (others =>  '0');
        for s in samples'range loop
            if samples(s) = to_signed(0, X'length) then 
                s_temp :=  s_temp + to_signed(-1, s_temp'length);
            else 
                s_temp :=  s_temp + to_signed(1, s_temp'length);
            end if;
        end loop;
        sum <=  s_temp;
    end process;

end DataFlow;