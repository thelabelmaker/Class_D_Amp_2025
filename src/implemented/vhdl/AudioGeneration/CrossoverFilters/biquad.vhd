-------------------------------------------------------------------------------
--
--  biquad.vhd
--
--  this file has an implementation of a biquad. the biquad is a common 2nd
--  order iir filter for dsp. this biquad is configurable using the biquad
--  coefficents in the constants files.
--  
--  Revision History:
--    03 Jun 25  Ethan Labelson     inital revision
--    04 Jun 25  Ethan Labelson     basic working setup (complex systolic array)
--    07 Jun 25  Ethan Labelson     removed fancy systolic array for simplicity 
--    11 Jun 25  Ethan Labelson     bit shifts figured out
--    19 Jun 25  Ethan Labelson     updated comments and cleaned code
-------------------------------------------------------------------------------

library work; --  import needed crossover info 
    use work.filter_constants.all;
    use work.crossover_coef.all;

library ieee; --  import needed standard libs
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    --  entity declaration for biquad 
    --  inputs:
    --      X       :   signed opperand; sample data input to the filter
    --      coef    :   signed opperand; coefficents to use for filter
    --      clk     :   192 kHz clock signal
    --      rst     :   system reset
    --
    --  outputs:
    --      Y       :   signed result; current filter output
    --
entity biquad is
    generic (
        xbits : integer := 16
    );
    port (
        --  filter data input
        X    : in  std_logic_vector((xbits - 1) downto 0);
        --  filter data output
        Y    : out std_logic_vector((xbits - 1) downto 0);
        --  coefficent array
        coef : in  biquad_coef;
        --  filter clock
        clk  : in  std_logic;
        --  reset
        rst  : in  std_logic
    );
end entity;

architecture DataFlow of biquad is
    --  set ybits so that operation wont overflow (round later after final sum)
    constant ybits : integer := X'length + cbits;
    type Y_arr is array (3 downto - 3) of signed(ybits - 1 downto 0);
    --  each opperations input should have same length as input data
    type X_arr is array (3 downto - 3) of signed(X'range);

    --  create array for inputs of each opperation (pe=proscessing element)
    signal pe_in : X_arr;
    --  create array for outputs of each opperation
    signal pe_out : Y_arr;

    --  Y0 is final accumulator for the filter. use 48 bits to fit dsp slice.
    signal Y0 : signed(47 downto 0);
begin

    --  Y0 gets final sum of constants mult by inputs
    Y0 <= resize(pe_out(- 2), 48) + resize(pe_out(- 1), 48) + resize(pe_out(0), 48) + resize(pe_out(1), 48) + resize(pe_out(2), 48);

    --  cast output to std_logic_vector
    Y <= std_logic_vector(pe_in(1)) when rst <= '1' else (others => '0');

    --  input 0 loaded with filter input
    pe_in(0)    <= signed(X);
    
    --  compute the fiter multiplications; pe_in * coef
    pe_out(- 2) <= coef(2, 1) * pe_in(- 2);
    pe_out(- 1) <= coef(1, 1) * pe_in(- 1);
    pe_out(0)   <= coef(0, 1) * pe_in(0);
    pe_out(1)   <= coef(1, 0) * pe_in(1);
    pe_out(2)   <= coef(2, 0) * pe_in(2);

    process (clk)
    begin
        if rising_edge(clk) then
            --  apply delay of to input arrays for x; pe(-n) => x*z^-n
            pe_in(- 1) <= pe_in(0);
            pe_in(- 2) <= pe_in(- 1);
            --  constants stored in Q1.(cbits - 1). need right shift of
            --  (cbits-2) bits to kill underflow from the multiplication.
            pe_in(1) <= resize(shift_right(Y0, cbits - 2), X'length);
            --  apply delay to input array for y; pe(n) => y*y^-n
            pe_in(2) <= pe_in(1);

        end if;
    end process;

end architecture;
