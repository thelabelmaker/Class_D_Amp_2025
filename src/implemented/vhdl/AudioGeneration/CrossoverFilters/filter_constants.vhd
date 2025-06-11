library work;
library IEEE;
    use IEEE.STD_LOGIC_1164.all;
    use ieee.numeric_std.all;

package filter_constants is

    --  array of biquad coefficents
    --  0 to 2 for b0, b1, b2, a0 (0), a1, a2 coefs
    --  0 to 1 for a and b: a = 0, b = 1
    constant cbits : integer := 18;
    type biquad_coef is array (2 downto 0, 1 downto 0) of signed(cbits-1 downto 0);

end package;
