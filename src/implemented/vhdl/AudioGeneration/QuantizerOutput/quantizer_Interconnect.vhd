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
    use IEEE.STD_LOGIC_1164.all;

    -- Uncomment the following library declaration if using
    -- arithmetic functions with Signed or Unsigned values
    --use IEEE.NUMERIC_STD.ALL;

    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;

entity Quantizer_Interconnect is
    port (L_READ : in  STD_LOGIC;
          R_READ : in  STD_LOGIC;
          DI_L   : in  STD_LOGIC_VECTOR((AUD_B - 1) downto 0);
          DI_R   : in  STD_LOGIC_VECTOR((AUD_B - 1) downto 0);
          CLK    : in  STD_LOGIC;
          RST    : in  STD_LOGIC;
          EN_L   : out STD_LOGIC_VECTOR((PWM_B - 1) downto 0);
          EN_R   : out STD_LOGIC_VECTOR((PWM_B - 1) downto 0));
end entity;

architecture Behavioral of Quantizer_Interconnect is

    component SigmaDelta is
        generic (nbits : integer := 8; outb : integer := 8);
        port (
            X    : in     std_logic_vector((nbits - 1) downto 0);
            Y    : buffer std_logic_vector((outb - 1) downto 0) := (others => '1');
            clk  : in     std_logic;
            dclk : in     std_logic
        );
    end component;

    component PWM_output is
        port (SCLK  : in  STD_LOGIC;
              DCLK  : in  STD_LOGIC;
              SDCLK : out std_logic;
              DIN   : in  std_logic_vector((PWM_B - 1) downto 0);
              EN    : out STD_LOGIC;
              RST   : in  STD_LOGIC);
    end component;

    signal SDCLK_L : std_logic;
    signal SDCLK_R : std_logic;

    signal QUANT_L : std_logic_vector((PWM_B - 1) downto 0);
    signal QUANT_R : std_logic_vector((PWM_B - 1) downto 0);

begin
    quantizer_l: SigmaDelta
        generic map (AUD_B, PWM_B)
        port map (
            X    => DI_L,
            Y    => QUANT_L,
            clk  => SDCLK_L,
            dclk => L_READ
        );

    quantizer_r: SigmaDelta
        generic map (AUD_B, PWM_B)
        port map (
            X    => DI_R,
            Y    => QUANT_R,
            clk  => SDCLK_R,
            dclk => R_READ
        );

    pwm_output_l: PWM_output
        port map (
            SCLK  => CLK,
            DCLK  => L_READ,
            SDCLK => SDCLK_L,
            DIN   => QUANT_L,
            EN    => EN_L,
            RST   => RST
        );

    pwm_output_r: PWM_output
        port map (
            SCLK  => CLK,
            DCLK  => R_READ,
            SDCLK => SDCLK_R,
            DIN   => QUANT_R,
            EN    => EN_R,
            RST   => RST
        );

end architecture;
