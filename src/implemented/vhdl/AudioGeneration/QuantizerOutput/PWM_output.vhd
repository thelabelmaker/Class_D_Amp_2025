-------------------------------------------------------------------------------
--
--  pwm_output.vhd
--
--  this file contains the pwm output stage. the output stage takes the sigma
--  delta bitstream and turns it into a pwm value which can be output to the
--  power stages of the amp. 
--  
--  Revision History:
--    22 Apr 25  Ethan Labelson     inital revision
--    02 Jun 25  Ethan Labelson     moved to 1 bit quantization
--    19 Jun 25  Ethan Labelson     updated comments and cleaned code
-------------------------------------------------------------------------------

library ieee; --  import needed standard libs
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library work; --  import needed constatns
    use work.I2S_constants.all;

    --  entity declaration for pwm_output
    --  inputs:
    --      DIN     :   data in bit; high bit of sigma delta result
    --      SCLK    :   global clock signal
    --      RST     :   system reset
    --
    --  outputs:
    --      EN      :   enable bit; pwm output to power stage
    --
    --  unused i/o:     
    --  these exist in the entity but arent currently used, although i used them
    --  in the past and think i may want to use them again sometime.
    --      sdclk   :   std_logic sigma delta clock; used to clk sd (previously)
    --      dclk    :   std_logic data clock; can help sync incoming data

entity PWM_output is
    port (
        SCLK  : in  std_logic;
        DCLK  : in  std_logic;
        SDCLK : out std_logic;
        DIN   : in  std_logic;
        EN    : out std_logic;
        RST   : in  std_logic);
end entity;

architecture Behavioral of PWM_output is

    --  counter 
    signal cntr  : unsigned((ACC_B - 1) downto 0) := (others => '0');
    --  synchroinised data 
    signal dsync : unsigned((PWM_B - 1) downto 0);
    --  sum of sigma delta inputs
    signal dacc  : unsigned((ACC_B - 1) downto 0);
    --  max count
    constant CMAX : unsigned((ACC_B - 1) downto 0) := (others => '1');
    --  data clocks to help with data sync
    signal dclkd : std_logic;
    signal dclkp : std_logic;

begin
    process (SCLK)
    begin
        --  reset counter
        if RST = '0' then
            cntr <= (others => '0');
            dacc <= (others => '0');
        else
            if rising_edge(SCLK) then
                --  sdclk counter divider (from older version)
                SDCLK <= cntr(cntr'high);
                --  if counter overflowing
                if cntr = CMAX then
                    --  load the current sum into the pwm data input
                    dsync <= dacc(dacc'high downto (ACC_B - PWM_B));
                    --  reset data accumulation
                    dacc(dacc'high downto 0) <= (others => '0');
                    --  low bit of dacc set to data input 
                    dacc(0) <= DIN;
                --  if input low, add 1 to dacc
                elsif DIN = '0' then
                    dacc <= dacc + 1;
                --  otherwise hold the value
                else
                    dacc <= dacc;
                end if;

                --  output 1 if counter is less than data value
                if cntr(cntr'high downto (ACC_B - PWM_B)) < dsync then
                    EN <= '1';
                else
                    EN <= '0';
                end if;
                --  always increment counter
                cntr <= cntr + 1;
            end if;
        end if;
    end process;

end architecture;
