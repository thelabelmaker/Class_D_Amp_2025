-------------------------------------------------------------------------------
--
--  filter_constants.vhd
--  
--  this file contains some useful filter constants. i hoped to expand my
--  filters a bit more but did not have the time. this file is kinda bare at the
--  moment, but if i add more filters it will be nice to have more of the common
--  constants centeralized here.
--  
--  Revision History:
--    03 Jun 25  Ethan Labelson     inital revision
--    10 Jun 25  Ethan Labelson     updated bits for consts
--    19 Jun 25  Ethan Labelson     updated docs and comments
-------------------------------------------------------------------------------


library work;   --  import external filter info
    use work.filter_constants.all;


library ieee;   --  import needed standard libs
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

--  package filter_constants
    --      filter_constants defines constants related to the filters.
    --      the file contains information and constants which are used by all
    --      onboard filters. the file seems a bit silly now but I was hoping to
    --      build out a more robust series of filters (maybe CIC or FIR
    --      interp/decimation). having centeralized constants here would help
    --      modify filters as needed without searching through many files.
package filter_constants is

    --  define number of bits for filter constants
    constant cbits : integer := 18;
    --  define data structure for filter coefs
    type biquad_coef is array (2 downto 0, 1 downto 0) of signed(cbits-1 downto 0);
    --  if i had more time i would make this a more general data structure and
    --  create general arrays for all my filters to standardize implementation

end package;
