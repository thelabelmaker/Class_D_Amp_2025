----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2025 02:30:50 AM
-- Design Name: 
-- Module Name: I2S_master - Behavioral
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library WORK;
USE WORK.I2S_constants.all;


--  design references
--  https://www.nxp.com/docs/en/user-manual/UM11732.pdf

entity I2S_master is
    Port ( 
        --  master clock line for I2S bus
        MCLK : in STD_LOGIC;         
        --  bit clock for I2S bus (genertaed from MCLK)
        BCLK : out STD_LOGIC;
        --  word select (select left or right audio)
        WS : out STD_LOGIC;
        DI : in STD_LOGIC;

        DO_L : out STD_LOGIC_VECTOR ((16-1) downto 0);
        DO_R : out STD_LOGIC_VECTOR ((16-1) downto 0));

        RST :   in  STD_LOGIC;  --  reset signal
end I2S_master;

architecture DataFlow of I2S_master is

    --  store audio data while being shifted in
    signal temp_d   :   UNSIGNED(DO_L'range);

    --  divider for system clock to generate other clks
    signal sclk_div :   UNSIGNED((WS_B-1) downto 0)

    --  select left or right to save data on WS change
    signal  wsd :   STD_LOGIC;

    --  indecate change in WS
    signal  wsp :   STD_LOGIC;
    
    --  current counter index to write data
    signal  cnt :   UNSIGNED(3 downto 0);

    --  to zero counter
    constant    CNT_ZERO    :   UNSIGNED(cnt'range):=to_unsigned(0, cnt'length);

    signal  ind :   INTEGER range 0 to 15;

    begin

    process SCLK begin
        if rising_edge(SCLK) then
            sclk_div    <=  sclk_div + 1;
            BCLK        <=  sclk_div(DIV_B-1);
            WS          <=  sclk_div(sclk_sclk'high)
        end if;
    end process;
    
    process BCLK begin
        if rising_edge(BCLK) then
            if(not wsd and wsp) then 
                DO_L <= d_temp;
            end if;
            
            if(wsd and wsp) then
                DO_R <= d_temp;
            end if;        

            if wsp = '0' then 
                cnt <=  CNT_ZERO;
            else
                cnt <=  cnt + to_unsinged(1, cnt'length);
            end if;
            
            d_temp(ind) <=  DI;
            
        end if;
    end process;
end DataFlow;
