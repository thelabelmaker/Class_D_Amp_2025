----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 08:38:45 AM
-- Design Name: 
-- Module Name: CLK_MGR - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.I2S_constants.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use ieee.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity I2S_CLK_MGR is
    Port ( SYSCLK   : in std_logic;
           WS       : out std_logic;
           BCLK     : out std_logic;
           FSYNC_L  : out std_logic;
           FSYNC_R  : out std_logic;
           RST      : in std_logic);
end I2S_CLK_MGR;

architecture Behavioral of I2S_CLK_MGR is
    --  divider for system clock to generate other clks
    signal sclk_div :   unsigned((WS_B) downto 0);
    --  data valid pulse (data can be read by PWM)
    signal d_val_p  :   std_logic;
    constant WS_DIV :   integer :=  sclk_div'high;
    constant B_DIV  :   integer :=  DIV_B-1;
    
begin

    --  wait for bit under WS to go high
    --  ensure bit 2 below is zero
    --  signal goes high half way through WS hold
    --  signal goes low in advance of WS change
    d_val_p     <=  sclk_div(WS_DIV-1) and not sclk_div(WS_DIV-2);

    process(SYSCLK) begin
        if RST = '0' then
            sclk_div    <=  (others => '0');
        else
            if rising_edge(SYSCLK) then
                sclk_div    <=  sclk_div + 1;
                BCLK        <=  sclk_div(B_DIV);
                WS          <=  sclk_div(WS_DIV);
                --  data loaded into left on rising edge of WS
                --  when WS is high and data valid, can read data
                FSYNC_L     <=  sclk_div(WS_DIV) and d_val_p;
                
                --  data loaded into right on falling edge of WS
                --  when WS is low and data valid, can read data
                FSYNC_R     <=  not sclk_div(WS_DIV) and d_val_p;
                
            end if;         
        end if;
    end process;

end Behavioral;
