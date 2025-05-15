----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 06:18:36 PM
-- Design Name: 
-- Module Name: Quantizer_Interconnect - Behavioral
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
library work;
use work.I2S_constants.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Quantizer_Interconnect is
    Port ( L_READ : in STD_LOGIC;
           R_READ : in STD_LOGIC;
           DI_L : in STD_LOGIC_VECTOR ((AUD_B-1) downto 0);
           DI_R : in STD_LOGIC_VECTOR ((AUD_B-1) downto 0);
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           L_RDY : out STD_LOGIC;
           R_RDY : out STD_LOGIC;
           DO_L : buffer STD_LOGIC_VECTOR ((PWM_B-1) downto 0);
           DO_R : buffer STD_LOGIC_VECTOR ((PWM_B-1) downto 0));
end Quantizer_Interconnect;

architecture Behavioral of Quantizer_Interconnect is

component SigmaDelta is generic(nbits : integer := 8);
    port(
        X   :   in      std_logic_vector((nbits-1) downto 0);
        Y   :   buffer  std_logic_vector;
        clk :   in      std_logic;
        rdy :   out     std_logic
    );
end component;

begin
--    quantizer_l : SigmaDelta    generic map(AUD_B)
--                                port map(
--        X       =>  DI_L,
--        Y       =>  DO_L,
--        clk     =>  L_READ,
--        rdy     =>  L_RDY
        
--    );
    
--    quantizer_r : SigmaDelta    generic map(AUD_B)
--                                port map(
--        X       =>  DI_R,
--        Y       =>  DO_R,
--        clk     =>  R_READ,
--        rdy     =>  R_RDY
        
--    );
    DO_L    <=  DI_L(DI_L'high downto (DI_L'high-DO_L'high));
    DO_R    <=  DI_R(DI_R'high downto (DI_R'high-DO_R'high));
    L_RDY   <=  L_READ;
    R_RDY   <=  R_READ;

end Behavioral;
