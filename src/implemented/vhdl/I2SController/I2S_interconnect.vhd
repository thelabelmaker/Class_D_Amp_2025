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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.I2S_master;
use work.I2S_CLK_MGR;
use work.PWM_output;
use work.I2S_constants;


entity I2S_interconnect is
    Port ( CLK  : in STD_LOGIC;
           RST  : in STD_LOGIC;
           DI   : in STD_LOGIC;
           BCK  : out STD_LOGIC;
           WS   : out STD_LOGIC;
           L_RDY    : out STD_LOGIC;
           R_RDY    : out STD_LOGIC;
           DO_L     : out STD_LOGIC_VECTOR((AUD_B-1) downto 0);
           DO_R     : out STD_LOGIC_VECTOR((AUD_B-1) downto 0));
end I2S_interconnect;

architecture Behavioral of I2S_interconnect is

component I2S_master is
    Port ( 
        --  bit clock for I2S bus (genertaed from MCLK)
        BCLK : in STD_LOGIC;
        
        --  word select (select left or right audio)
        WS : in STD_LOGIC;
        DI : in STD_LOGIC;

        DO_L : out STD_LOGIC_VECTOR ((AUD_B-1) downto 0);
        DO_R : out STD_LOGIC_VECTOR ((AUD_B-1) downto 0);

        RST :   in  STD_LOGIC);  --  reset signal
end component;

component I2S_CLK_MGR is
    Port ( 
        SYSCLK   : in STD_LOGIC;
        WS       : out STD_LOGIC;
        BCLK     : out STD_LOGIC;
        FSYNC_L  : out STD_LOGIC;
        FSYNC_R  : out STD_LOGIC;
        RST      : in STD_LOGIC);
end component;

component SigmaDelta is generic(nbits : integer := 8);
    port(
        X   :   in      std_logic_vector((nbits-1) downto 0);
        Y   :   buffer  std_logic_vector;
        clk :   in      std_logic
    );
end component;

signal bit_clk  : std_logic;
signal ws_clk   : std_logic;
signal l_sync   : std_logic;
signal r_sync   : std_logic;
--signal I2S_O_L  : std_logic_vector(AUD_B-1 downto 0);
--signal I2S_O_R  : std_logic_vector(AUD_B-1 downto 0);


begin

    WS      <=  ws_clk;
    BCK     <=  bit_clk;
    
    L_RDY   <=  l_sync;
    R_RDY   <=  r_sync;
    
    clk_mgr : I2S_CLK_MGR port map(
        SYSCLK  => CLK,
        WS      => ws_clk,
        BCLK    => bit_clk,
        FSYNC_L => l_sync,
        FSYNC_R => r_sync,
        RST     => RST
    );
    
    control : I2S_master port map(
        BCLK    => bit_clk,
        WS      => ws_clk,
        DI      => DI, 
        DO_L    => DO_L,
        DO_R    => DO_R,
        RST     => RST
    );                              
                              
end Behavioral;
