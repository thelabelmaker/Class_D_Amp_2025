library work;

library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
USE ieee.MATH_REAL.all;


package addr_lookup is 
    constant A1_addr : std_logic_vector(7 downto 0) := x"01";
    constant A2_addr : std_logic_vector(7 downto 0) := x"02";
    constant A3_addr : std_logic_vector(7 downto 0) := x"03";

    constant B1_addr : std_logic_vector(7 downto 0) := x"0A";
    constant B2_addr : std_logic_vector(7 downto 0) := x"0B";
    constant B3_addr : std_logic_vector(7 downto 0) := x"0C";

    constant C1_addr : std_logic_vector(7 downto 0) := x"11";
    constant C2_addr : std_logic_vector(7 downto 0) := x"12";
    constant C3_addr : std_logic_vector(7 downto 0) := x"13";

    constant D12_addr : std_logic_vector(7 downto 0) := x"D0";
    
    constant E21_addr : std_logic_vector(7 downto 0) := x"E0";
end package addr_lookup;