----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 11:04:14 AM
-- Design Name: 
-- Module Name: I2S_interconnect - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
--  import libs
library work;
    use work.I2S_constants.all;

library IEEE;
    use IEEE.STD_LOGIC_1164.all;
    use IEEE.NUMERIC_STD.all;

    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;

library work;
    use work.I2S_slave;
    use work.I2S_CLK_MGR;
    use work.PWM_output;
    use work.I2S_constants;

entity I2S_interconnect is
    port (CLK   : in  STD_LOGIC;
          RST   : in  STD_LOGIC;
          DI    : in  STD_LOGIC;
          BCK   : in  STD_LOGIC;
          WS    : in  STD_LOGIC;
          L_RDY : out STD_LOGIC;
          R_RDY : out STD_LOGIC;
          DO_L  : out STD_LOGIC_VECTOR((AUD_B - 1) downto 0);
          DO_R  : out STD_LOGIC_VECTOR((AUD_B - 1) downto 0));
end entity;

architecture Behavioral of I2S_interconnect is

    component I2S_slave is
        port (
            MCLK : in STD_LOGIC;
            --  bit clock for I2S bus (genertaed from MCLK)
            BCLK : in  STD_LOGIC;

            --  word select (select left or right audio)
            WS   : in  STD_LOGIC;
            DI   : in  STD_LOGIC;

            DO_L : out STD_LOGIC_VECTOR((AUD_B - 1) downto 0);
            DO_R : out STD_LOGIC_VECTOR((AUD_B - 1) downto 0);

            --  left data ready
            LDR  : out STD_LOGIC;

            --  right data ready
            RDR  : out STD_LOGIC;

            RST  : in  STD_LOGIC); --  reset signal
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
