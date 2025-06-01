----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 11:36:57 PM
-- Design Name: 
-- Module Name: audio_interconnect - Behavioral
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
    use IEEE.STD_LOGIC_1164.all;

    -- Uncomment the following library declaration if using
    -- arithmetic functions with Signed or Unsigned values
    --use IEEE.NUMERIC_STD.ALL;

library work;
    use work.I2S_constants.all;

    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;

entity audio_interconnect is
    port (

        AUD_IN_L  : in  std_logic_vector((AUD_B - 1) downto 0);
        AUD_IN_R  : in  std_logic_vector((AUD_B - 1) downto 0);

        AUD_HPF_R : out STD_LOGIC;
        AUD_HPF_L : out STD_LOGIC;
        AUD_LPF_R : out STD_LOGIC;
        AUD_LPF_L : out STD_LOGIC;

        L_READ    : in  std_logic;
        R_READ    : in  std_logic;

        CLK       : in  STD_LOGIC;
        RST       : in  STD_LOGIC);
end entity;

architecture Behavioral of audio_interconnect is
    component I2S_interconnect is
        port (CLK   : in  STD_LOGIC;
              RST   : in  STD_LOGIC;
              DI    : in  STD_LOGIC;
              BCK   : out STD_LOGIC;
              WS    : out STD_LOGIC;
              L_RDY : out STD_LOGIC;
              R_RDY : out STD_LOGIC;
              DO_L  : out STD_LOGIC_VECTOR((AUD_B - 1) downto 0);
              DO_R  : out STD_LOGIC_VECTOR((AUD_B - 1) downto 0));
    end component;

    component crossover_interconnect is
        port (AUD_IN_L : in  std_logic_vector((AUD_B - 1) downto 0);
              AUD_IN_R : in  std_logic_vector((AUD_B - 1) downto 0);
              HPF_L    : out std_logic_vector((AUD_B - 1) downto 0);
              HPF_R    : out std_logic_vector((AUD_B - 1) downto 0);
              LPF_L    : out std_logic_vector((AUD_B - 1) downto 0);
              LPF_R    : out std_logic_vector((AUD_B - 1) downto 0);
              CLK      : in  STD_LOGIC;
              RST      : in  STD_LOGIC;
              L_RDY    : out STD_LOGIC;
              R_RDY    : out STD_LOGIC;
              L_READ   : in  STD_LOGIC;
              R_READ   : in  STD_LOGIC);
    end component;

    component Quantizer_Interconnect is
        port (L_READ : in  STD_LOGIC;
              R_READ : in  STD_LOGIC;
              DI_L   : in  STD_LOGIC_VECTOR((AUD_B - 1) downto 0);
              DI_R   : in  STD_LOGIC_VECTOR((AUD_B - 1) downto 0);
              CLK    : in  STD_LOGIC;
              RST    : in  STD_LOGIC;
              EN_L   : out STD_LOGIC_VECTOR((PWM_B - 1) downto 0);
              EN_R   : out STD_LOGIC_VECTOR((PWM_B - 1) downto 0));
    end component;

    signal hpf_l : std_logic_vector((AUD_B - 1) downto 0);
    signal hpf_r : std_logic_vector((AUD_B - 1) downto 0);
    signal lpf_l : std_logic_vector((AUD_B - 1) downto 0);
    signal lpf_r : std_logic_vector((AUD_B - 1) downto 0);

    signal co_l_rdy : std_logic;
    signal co_r_rdy : std_logic;

begin

    filters: crossover_interconnect
        port map (
            AUD_IN_L => AUD_IN_L,
            AUD_IN_R => AUD_IN_R,
            HPF_L    => HPF_L,
            HPF_R    => HPF_R,
            LPF_L    => LPF_L,
            LPF_R    => LPF_R,
            CLK      => CLK,
            RST      => RST,
            L_RDY    => co_l_rdy,
            R_RDY    => co_r_rdy,
            L_READ   => L_READ,
            R_READ   => R_READ
        );

    quantizer_hpf: Quantizer_Interconnect
        port map (
            L_READ => co_r_rdy,
            R_READ => co_l_rdy,
            DI_L   => hpf_l,
            DI_R   => hpf_r,
            CLK    => CLK,
            RST    => RST,
            EN_L   => AUD_HPF_L,
            EN_R   => AUD_HPF_R
        );

    quantizer_lpf: Quantizer_Interconnect
        port map (
            L_READ => co_r_rdy,
            R_READ => co_l_rdy,
            DI_L   => lpf_l,
            DI_R   => lpf_r,
            CLK    => CLK,
            RST    => RST,
            EN_L   => AUD_LPF_L,
            EN_R   => AUD_LPF_R
        );

end architecture;
