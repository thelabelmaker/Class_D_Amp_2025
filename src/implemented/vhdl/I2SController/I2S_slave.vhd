-------------------------------------------------------------------------------
--
--  I2S_slave.vhd
--
--  
--  Revision History:
--    20 Apr 25  Ethan Labelson     inital revision of i2s_master
--    22 Apr 25  Ethan Labelson     working i2s in simulation
--    14 May 25  Ethan Labelson     adjust for ESP32 (working audio out!)
--    09 Jun 25  Ethan Labelson     changed over to I2S_slave with external adc
--    19 Jun 25  Ethan Labelson     updated comments and docs
-------------------------------------------------------------------------------

library ieee; --  import standard libs
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

library work; --  import I2S info
    use work.I2S_constants.all;

    --  design references for I2S implementation
    --  https://www.nxp.com/docs/en/user-manual/UM11732.pdf
    --  manual provides suggested hardware block diagram for an i2s receiver.
    --  this design loosely follows those guidelines.


--  entity declaration for i2s_interconnect 
    --  inputs:
    --      WS          :   audio frame clock; word select choose L/R
    --      BCLK        :   audio bit clock; data bits sync with bck 
    --      MCLK        :   global clock signal
    --      DI          :   data bit; serial data in from i2s
    --      RST         :   system reset

    --  outputs:
    --      LDR         :   data ready bit; indicates left data ready   
    --      RDR         :   data ready bit; indicates right data ready
    --      DO_L        :   signed i2s data; left data in from i2s
    --      DO_R        :   signed i2s data; right data in from i2s
entity I2S_slave is
    port (
        --  master clock line
        MCLK : in  std_logic;
        --  bit clock for I2S bus (genertaed from MCLK)
        BCLK : in  std_logic;
        --  word select (select left or right audio)
        WS   : in  std_logic;

        --  data input from audio receiver
        DI   : in  std_logic;

        --  full length data outputs
        DO_L : out std_logic_vector((AUD_B - 1) downto 0);
        DO_R : out std_logic_vector((AUD_B - 1) downto 0);

        --  left data ready
        LDR  : out std_logic;

        --  right data ready
        RDR  : out std_logic;

        --  reset signal
        RST  : in  std_logic);
end entity;

architecture DataFlow of I2S_slave is

    --  store audio data while being shifted in
    signal d_temp : unsigned(DO_L'range);

    signal d_temp_l : unsigned(DO_L'range);
    signal d_temp_r : unsigned(DO_L'range);

    --  select left or right to save data on WS change
    signal wsd : std_logic;

    --  indecate change in WS
    signal wsp : std_logic;

    --  delayed bit clock for I2S data input
    signal bcd : std_logic;
    --  this should not be needed as doing rising edge detection on bck should
    --  be sufficent for reading I2S data in. howevever, the xilinx/vivado only
    --  allows certian pins to accept clock input (something about how clock is
    --  routed on the chip). i am out of such pins so i do edge detection
    --  manually synchronised with I3S system clock line.

    --  current counter index to write data
    signal cnt : unsigned(natural(log2(real(AUD_B - 1))) downto 0);

    --  constant for reseting the bit counter every audio frame
    constant CNT_MAX : unsigned(cnt'range) := to_unsigned(AUD_B - 1, cnt'length);

    --  decrement counter
    constant DEC_ONE : unsigned(cnt'range) := to_unsigned(1, cnt'length);

    --  zero constant for comparison
    constant ZERO : unsigned(cnt'range) := to_unsigned(0, cnt'length);

    --  index the audio storage buffer to track which bit is being read
    signal ind : integer range 0 to AUD_B - 1;

begin

    --  cast cnt to an integer
    ind <= to_integer(cnt);

    --  detect change in WS
    wsp <= wsd xor WS;

    process (MCLK)
    begin
        --  everyting sync with mclk
        if rising_edge(MCLK) then
            --  delay bit clock
            bcd <= bclk;
            --  find rising edge of bit clk
            if bcd = '0' and bclk = '1' then
                --  delay WS
                wsd <= WS;
                --  on falling edge of WS
                if (wsd = '0' and wsp = '1') then
                    --  parallel load temp data buffer to left channel
                    d_temp_l <= d_temp;
                    --  change output to new frame
                    DO_L <= std_logic_vector(d_temp_l);
                    --  left channel ready to be read
                    LDR <= '1';
                    --  right channel no longer ready (now receiving data)
                    RDR <= '0';
                end if;
                --  on rising edge of ws
                if (wsd = '1' and wsp = '1') then
                    --  parallel load temp data buffer to right channel
                    d_temp_r <= d_temp;
                    --  change output to new frame
                    DO_R <= std_logic_vector(d_temp_r);
                    --  right channel ready to be read
                    RDR <= '1';
                    --  left channel no longer ready (now receiving data)
                    LDR <= '0';
                end if;
                --  note that the data is delayed an additonal frame by moving
                --  it through the d_temp_l and d_temp_r variables. this is not
                --  really needed but helps with timing and dosent hurt
                --  anything.  

                --  if there is a change in WS
                if wsp = '1' then
                    --  reset the counter
                    cnt <= CNT_MAX;
                    --  if counter not already zero
                elsif not (cnt = ZERO) then
                    --  decrement the counter
                    cnt <= cnt - DEC_ONE;
                    --  othersise cnt already zero so
                else
                    --  hold cnt at zero
                    cnt <= ZERO;
                end if;

                --  load incoming data bit into temp buffer
                d_temp(ind) <= DI;
            end if;
        end if;
    end process;
end architecture;
