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
use IEEE.math_real.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library work;
USE work.I2S_constants.all;


--  design references
--  https://www.nxp.com/docs/en/user-manual/UM11732.pdf

entity I2S_slave is
    Port ( 
        --  master clock line
        MCLK : in STD_LOGIC;
        --  bit clock for I2S bus (genertaed from MCLK)
        BCLK : in STD_LOGIC;
        --  word select (select left or right audio)
        WS : in STD_LOGIC;
        DI : in STD_LOGIC;

        DO_L : out STD_LOGIC_VECTOR ((AUD_B-1) downto 0);
        DO_R : out STD_LOGIC_VECTOR ((AUD_B-1) downto 0);
        
        --  left data ready
        LDR  : out STD_LOGIC;
        
        --  right data ready
        RDR  : out STD_LOGIC;

        RST :   in  STD_LOGIC);  --  reset signal
end I2S_slave;

architecture DataFlow of I2S_slave is

    --  store audio data while being shifted in
    signal d_temp    :   UNSIGNED(DO_L'range);

    signal d_temp_l  :   UNSIGNED(DO_L'range);
    signal d_temp_r  :   UNSIGNED(DO_L'range);

    

    --  select left or right to save data on WS change
    signal  wsd :   STD_LOGIC;
    
    --  output data left ready
    --signal  wsl :   STD_LOGIC;
    
    --  output data right ready
    --signal wsr :    STD_LOGIC;

    --  indecate change in WS
    signal  wsp :   STD_LOGIC;
    
    signal bcd  :   STD_LOGIC;
    
    --  current counter index to write data
    signal  cnt :   UNSIGNED(natural(log2(real(AUD_B-1))) downto 0);

    --  to zero counter
    constant    CNT_MAX     :   UNSIGNED(cnt'range):=to_unsigned(AUD_B-1, cnt'length);
    constant    DEC_ONE     :   UNSIGNED(cnt'range):=to_unsigned(1, cnt'length);
    constant    ZERO        :   UNSIGNED(cnt'range):=to_unsigned(0, cnt'length);


    signal  ind :   INTEGER range 0 to AUD_B-1;

    begin
    
    ind <=  to_integer(cnt);
    wsp <= wsd xor WS;
    
    process(MCLK) begin
        if rising_edge(MCLK) then
            bcd <= bclk;
            if bcd = '0' and bclk = '1' then
                wsd <=  WS;              
                if(wsd='0' and wsp='1') then 
                    d_temp_l <= d_temp;
                    DO_L <= std_logic_vector(d_temp_l);
                    LDR <=  '1';
                    RDR <=  '0';
                end if;
                
                if(wsd='1' and wsp='1') then
                    d_temp_r <= d_temp;
                    DO_R <= std_logic_vector(d_temp_r);
                    RDR <=  '1';
                    LDR <=  '0';
                end if;        
    
                if wsp = '1' then 
                    cnt <=  CNT_MAX;
                elsif not(cnt = ZERO) then 
                    cnt <=  cnt - DEC_ONE;
                else
                    cnt <=  ZERO;
                end if;
                
                d_temp(ind) <=  DI;
            end if;
        end if;
    end process;
end DataFlow;
