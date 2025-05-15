----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 08:37:27 AM
-- Design Name: 
-- Module Name: PWM_output - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.I2S_constants.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM_output is
    Port ( SCLK : in STD_LOGIC;
           DCLK : in STD_LOGIC;
           DIN  : in STD_LOGIC_VECTOR ((PWM_B-1) downto 0);
           EN   : out STD_LOGIC;
           RST  : in STD_LOGIC);
end PWM_output;

architecture Behavioral of PWM_output is

    signal cntr :   unsigned((PWM_B-1) downto 0);
    signal dsync:   unsigned((PWM_B-1) downto 0);
    signal DCLKD:   std_logic;
    signal DCLKP:   std_logic;

begin
    DCLKP   <=  DCLK xor DCLKD;
    process(SCLK) begin
        if RST='0' then 
            cntr    <=  (others => '0');
        else 
            if rising_edge(SCLK) then
                DCLKD   <=  DCLK;
                if (DCLK and DCLKP) = '1' then
                    dsync   <=  unsigned(signed(DIN) + to_signed(2**(PWM_B-1), DIN'length));
                    cntr    <=  (others => '0');
                else
                    cntr <= cntr + 1;
                    if cntr < dsync(dsync'high downto (dsync'high-cntr'length+1)) then 
                        EN  <=  '1';
                    else 
                        EN  <=  '0';
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
