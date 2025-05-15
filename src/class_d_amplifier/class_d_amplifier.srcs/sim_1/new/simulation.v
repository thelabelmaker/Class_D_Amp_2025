----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2025 05:57:16 PM
-- Design Name: 
-- Module Name: sim_test - Behavioral
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

library work;
use work.I2S_interconnect;
use work.PWM_output;

use IEEE.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim_test is
end sim_test;

architecture Behavioral of sim_test is


component I2S_interconnect is
    Port ( CLK  : in STD_LOGIC;
           RST  : in STD_LOGIC;
           DI   : in STD_LOGIC;
           BCK  : out STD_LOGIC;
           WS   : out STD_LOGIC;
           L_RDY    : out STD_LOGIC;
           R_RDY    : out STD_LOGIC;
           DO_L     : out STD_LOGIC_VECTOR(15 downto 0);
           DO_R     : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component PWM_output is 
    Port ( SCLK : in STD_LOGIC;
           DCLK : in STD_LOGIC;
           DIN : in STD_LOGIC_VECTOR (15 downto 0);
           EN : out STD_LOGIC;
           RST : in STD_LOGIC);
end component;


signal  clk :   STD_LOGIC;
signal  bclk:   STD_LOGIC;
signal  WS  :   STD_LOGIC;
signal  DI  :   STD_LOGIC;
signal  pwm :   STD_LOGIC;
signal  rst :   STD_LOGIC;
signal pwclk:   STD_LOGIC;
signal sl   :   STD_LOGIC;
signal sr   :   STD_LOGIC;

signal  DL  :   std_logic_vector(15 downto 0);
signal  DR  :   std_logic_vector(15 downto 0);

signal  DLI :   std_logic_vector(15 downto 0);
signal  DRI :   std_logic_vector(15 downto 0);

signal ENL  :   STD_LOGIC;
signal ENR  :   STD_LOGIC;

begin

    MGR : I2S_interconnect port map(
        CLK => clk,
        BCK => bclk,
        WS  => WS,
        DI  => DI, 
        RST =>  rst,
        L_RDY   => sl,
        R_RDY   => sr,
        DO_L    => DL,
        DO_R    => DR
    );
    
    PWL : PWM_output port map(
        SCLK => clk,
        DCLK => WS,
        DIN => DL,
        EN => ENL,
        RST => rst
    );
    
    PWR : PWM_output port map(
        SCLK => clk,
        DCLK => WS,
        DIN => DR,
        EN => ENR,
        RST => rst
    );
    
    
    process
    begin
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait for 100 ns;
    rst <= '1';
    wait until rising_edge(WS);
    wait until falling_edge(bclk);
    for k in -32000 to 32000 loop 
        DLI <= std_logic_vector(to_signed(k, DLI'length));
        for b in DLI'high downto 0 loop
            wait until falling_edge(bclk);
            DI  <=  DLI(b);
        end loop;
        DI <=   DLI(0);
        DRI <= std_logic_vector(to_signed(-1*k, DRI'length));
        for b in DLI'high downto 0 loop
            wait until falling_edge(bclk);
            DI  <=  DRI(b);
        end loop;
    end loop;
    
    wait for 1000 ms;
    end process;
    
    CLOCK_CLK : process
    begin
        -- this process generates a clock with a 32MHz frequency and 50% duty 
        -- cycle stop the clock when end of simulation is reached
        clk <= '0';
        wait for 15.625 ns;
        clk <= '1';
        wait for 15.625 ns;
    end process;

end Behavioral;
