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
           SDCLK: out std_logic;
           DIN  : in std_logic;
           EN   : out STD_LOGIC;
           RST  : in STD_LOGIC);
end PWM_output;

architecture Behavioral of PWM_output is

    signal cntr :   unsigned((PWM_B-1) downto 0) := (others => '0');
    signal dsync:   unsigned((PWM_B-1) downto 0);
    signal dacc: unsigned((PWM_B-1) downto 0);
    constant CMAX: unsigned((PWM_B-1) downto 0) := (others => '1');
    signal dclkd:   std_logic;
    signal dclkp:   std_logic;
    
    

begin
    process(SCLK) begin
        
        if RST='0' then 
            cntr    <=  (others => '0');
            dacc    <=  (others => '0');
        else 
            if rising_edge(SCLK) then
                SDCLK    <=  cntr(cntr'high);
                if cntr = CMAX then
                    dsync   <=  dacc;
                    dacc(dacc'high downto 1)    <=  (others => '0');
                    dacc(0) <=  DIN;
                elsif DIN = '0' then
                    dacc <= dacc + 1;
                else
                    dacc <= dacc;    
                end if;
                    
                if cntr < dsync(dsync'high downto (dsync'high-cntr'length+1)) then 
                    EN  <=  '1';
                else 
                    EN  <=  '0';
                end if;
                cntr <= cntr + 1;
            end if;
        end if;
    end process;

end Behavioral;
