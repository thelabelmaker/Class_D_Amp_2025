-------------------------------------------------------------------------------
--
--  i2s_interconnect.vhd
--
--  this file contains the interconnect for the i2s interface. it acts as a
--  wrapper so that i dont need to modify my top level entity if i change things
--  in my i2s code or configuration.
--  
--  Revision History:
--    29 Apr 25  Ethan Labelson     inital revision
--    29 Apr 25  Ethan Labelson     add "interconnect" to clean integration 
--    14 May 25  Ethan Labelson     adjust for ESP32 (working audio out!)
--    09 Jun 25  Ethan Labelson     update to fit i2s slave receiver
--    19 Jun 25  Ethan Labelson     updated comments and docs
-------------------------------------------------------------------------------

library ieee; --  import needed standard libs
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library work; --  import i2s info
    use work.I2S_constants.all;
    use work.I2S_slave;

--  entity declaration for i2s_interconnect 
    --  inputs:
    --      WS          :   audio frame clock; word select choose L/R
    --      BCK         :   audio bit clock; data bits sync with bck 
    --      CLK         :   global clock signal
    --      DI          :   data bit; serial data in from i2s
    --      RST         :   system reset

    --  outputs:
    --      L_RDY       :   data ready bit; indicates left data ready   
    --      R_RDY       :   data ready bit; indicates right data ready
    --      DO_L        :   signed i2s data; left data in from i2s
    --      DO_R        :   signed i2s data; right data in from i2s
    
entity I2S_interconnect is
    port (
        --  global clock
        CLK   : in  std_logic;
        --  reset 
        RST   : in  std_logic;
        --  i2s data in 
        DI    : in  std_logic;
        --  bit clock
        BCK   : in  std_logic;
        --  LR-clk
        WS    : in  std_logic;
        --  left data output ready 
        L_RDY : out std_logic;
        --  right data output ready
        R_RDY : out std_logic;
        --  left audio data output
        DO_L  : out std_logic_vector((AUD_B - 1) downto 0);
        --  right audio data output
        DO_R  : out std_logic_vector((AUD_B - 1) downto 0));
end entity;

architecture Behavioral of I2S_interconnect is

    component I2S_slave is
        port (
            MCLK : in  std_logic;
            --  bit clock for I2S bus (genertaed from MCLK)
            BCLK : in  std_logic;

            --  word select (select left or right audio)
            WS   : in  std_logic;
            DI   : in  std_logic;

            --  data output from i2s
            DO_L : out std_logic_vector((AUD_B - 1) downto 0);
            DO_R : out std_logic_vector((AUD_B - 1) downto 0);

            --  left data ready
            LDR  : out std_logic;

            --  right data ready
            RDR  : out std_logic;

            RST  : in  std_logic); --  reset signal
    end component;

begin
    control: I2S_slave
        port map (
            MCLK => CLK,
            BCLK => BCK,
            WS   => WS,
            DI   => DI,
            DO_L => DO_L,
            DO_R => DO_R,
            LDR  => L_RDY,
            RDR  => R_RDY,
            RST  => RST
        );
end architecture;
