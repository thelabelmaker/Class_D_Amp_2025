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
          update : in  std_logic;
          addr   : in  std_logic_vector(7 downto 0);
          cval   : in  std_logic_vector(31 downto 0);
          CLK    : in  STD_LOGIC;
          RST    : in  STD_LOGIC;
          EN_L   : out STD_LOGIC;
          EN_R   : out STD_LOGIC);
end entity;

architecture Behavioral of Quantizer_Interconnect is



    component SigmaDelta is
        generic (nbits : integer := 8; outb : integer := 8);
        port (
            X      : in     std_logic_vector((nbits - 1) downto 0);
            Y      : buffer std_logic := '1';
            clk    : in     std_logic;
            update : in     std_logic;
            addr   : in     std_logic_vector(7 downto 0);
            cval   : in     std_logic_vector(31 downto 0);
            dclk   : in     std_logic
        );
    end component;

    component PWM_output is
        port (SCLK  : in  STD_LOGIC;
              DCLK  : in  STD_LOGIC;
              SDCLK : out std_logic;
              DIN   : in  std_logic;
              EN    : out STD_LOGIC;
              RST   : in  STD_LOGIC);
    end component;
    
      component faster_clk_wrapper is
  port (
    CLK_24p576 : in STD_LOGIC;
    RST : in STD_LOGIC;
    SDCK : out STD_LOGIC
  );
  end component;


    signal SDCLK_L : std_logic;
    signal SDCLK_R : std_logic;

    signal SDCK    : std_logic;
    signal QUANT_L : std_logic;
    signal QUANT_R : std_logic;

begin
--pll: faster_clk_wrapper
--        port map (
--             CLK_24p576 => CLK,
--             SDCK     => SDCK,
--             RST     => RST
--         );
    SDCK <= CLK;
    quantizer_l: SigmaDelta
        generic map (AUD_B, PWM_B)
        port map (
            X      => DI_L,
            Y      => QUANT_L,
            clk    => SDCK,
            update => update,
            addr   => addr,
            cval   => cval,
            dclk   => L_READ
        );

    quantizer_r: SigmaDelta
        generic map (AUD_B, PWM_B)
        port map (
            X      => DI_R,
            Y      => QUANT_R,
            clk    => SDCK,
            update => update,
            addr   => addr,
            cval   => cval,
            dclk   => R_READ
        );

    --QUANT_L <= DI_L(DI_L'high downto DI_L'length-PWM_B);
    --QUANT_R <= DI_R(DI_L'high downto DI_L'length-PWM_B);
    pwm_output_l: PWM_output
        port map (
            SCLK  => SDCK,
            DCLK  => L_READ,
            DIN   => QUANT_L,
            EN    => EN_L,
            RST   => RST
        );

    pwm_output_r: PWM_output
        port map (
            SCLK  => SDCK,
            DCLK  => R_READ,
            DIN   => QUANT_R,
            EN    => EN_R,
            RST   => RST
        );

end architecture;
