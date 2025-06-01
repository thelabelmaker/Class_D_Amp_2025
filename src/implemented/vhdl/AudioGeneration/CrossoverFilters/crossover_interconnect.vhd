----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 11:39:25 PM
-- Design Name: 
-- Module Name: crossover - Behavioral
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

library IEEE;
    use IEEE.STD_LOGIC_1164.all;

    -- Uncomment the following library declaration if using
    -- arithmetic functions with Signed or Unsigned values
    --use IEEE.NUMERIC_STD.ALL;

    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;

entity crossover_interconnect is
    port (AUD_IN_L : in  STD_LOGIC;
          AUD_IN_R : in  STD_LOGIC;
          HPF_L    : out STD_LOGIC;
          HPF_R    : out STD_LOGIC;
          LPF_L    : out STD_LOGIC;
          LPF_R    : out STD_LOGIC;
          CLK      : in  STD_LOGIC;
          RST      : in  STD_LOGIC;
          L_RDY    : out STD_LOGIC;
          R_RDY    : out STD_LOGIC;
          L_READ   : in  STD_LOGIC;
          R_READ   : in  STD_LOGIC);
end entity;

architecture Behavioral of crossover_interconnect is

begin
    HPF_L <= AUD_IN_L;
    HPF_R <= AUD_IN_R;

    LPF_L <= AUD_IN_L;
    LPF_R <= AUD_IN_R;

    L_RDY <= L_READ;
    R_RDY <= R_READ;

end architecture;
