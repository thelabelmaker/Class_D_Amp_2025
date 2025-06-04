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
use work.I2S_constants.all;
use work.filter_constants.all;
use work.crossover_coef.all;

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
    port (AUD_IN_L : in  STD_LOGIC_VECTOR((AUD_B-1) downto 0);
          AUD_IN_R : in  STD_LOGIC_VECTOR((AUD_B-1) downto 0);
          HPF_L    : out STD_LOGIC_VECTOR((AUD_B-1) downto 0);
          HPF_R    : out STD_LOGIC_VECTOR((AUD_B-1) downto 0);
          LPF_L    : out STD_LOGIC_VECTOR((AUD_B-1) downto 0);
          LPF_R    : out STD_LOGIC_VECTOR((AUD_B-1) downto 0);
          CLK      : in  STD_LOGIC;
          RST      : in  STD_LOGIC;
          L_RDY    : out STD_LOGIC;
          R_RDY    : out STD_LOGIC;
          L_READ   : in  STD_LOGIC;
          R_READ   : in  STD_LOGIC);
end entity;

architecture Behavioral of crossover_interconnect is
    component biquad is
        generic (
            xbits : integer := 16
        );
        port (
            X    : in  std_logic_vector((xbits - 1) downto 0);
            Y    : out std_logic_vector((xbits - 1) downto 0);
            coef : in  biquad_coef;
            clk  : in  std_logic;
            rst  : in  std_logic
        );
    end component;
    
    signal AUD_HPF_MID_X_L: std_logic_vector(AUD_IN_L'range);
    signal AUD_HPF_MID_X_R: std_logic_vector(AUD_IN_R'range);

    signal AUD_LPF_MID_X_L: std_logic_vector(AUD_IN_L'range);
    signal AUD_LPF_MID_X_R: std_logic_vector(AUD_IN_R'range);

    signal AUD_IN_L_SYNC: std_logic_vector(AUD_IN_L'range);
    signal AUD_IN_R_SYNC: std_logic_vector(AUD_IN_R'range);

    signal ldrdyd: std_logic;
    signal rdrdyd : std_logic;
    
begin
    biquad_l_1_hpf : biquad
    generic map (
        xbits => AUD_IN_L'length
    )
    port map (
        X    => AUD_IN_L_SYNC,
        Y    => AUD_HPF_MID_X_L,
        coef => hpf_crossover_coef_arr(0),
        clk  => clk,
        rst  => rst
    );

    biquad_l_2_hpf : biquad
    generic map (
        xbits => AUD_IN_L'length
    )
    port map (
        X    => AUD_HPF_MID_X_L,
        Y    => HPF_L,
        coef => hpf_crossover_coef_arr(1),
        clk  => clk,
        rst  => rst
    );

    biquad_r_1_hpf : biquad
    generic map (
        xbits => AUD_IN_R'length
    )
    port map (
        X    => AUD_IN_R_SYNC,
        Y    => AUD_HPF_MID_X_R,
        coef => hpf_crossover_coef_arr(0),
        clk  => clk,
        rst  => rst
    );

    biquad_r_2_hpf : biquad
    generic map (
        xbits => AUD_IN_R'length
    )
    port map (
        X    => AUD_HPF_MID_X_R,
        Y    => HPF_R,
        coef => hpf_crossover_coef_arr(1),
        clk  => clk,
        rst  => rst
    );



    biquad_l_1_lpf : biquad
    generic map (
        xbits => AUD_IN_L'length
    )
    port map (
        X    => AUD_IN_L_SYNC,
        Y    => AUD_LPF_MID_X_L,
        coef => lpf_crossover_coef_arr(0),
        clk  => clk,
        rst  => rst
    );

    biquad_l_2_lpf : biquad
    generic map (
        xbits => AUD_IN_L'length
    )
    port map (
        X    => AUD_LPF_MID_X_L,
        Y    => LPF_L,
        coef => lpf_crossover_coef_arr(1),
        clk  => clk,
        rst  => rst
    );

    biquad_r_1_lpf : biquad
    generic map (
        xbits => AUD_IN_R'length
    )
    port map (
        X    => AUD_IN_R_SYNC,
        Y    => AUD_LPF_MID_X_R,
        coef => lpf_crossover_coef_arr(0),
        clk  => clk,
        rst  => rst
    );

    biquad_r_2_lpf : biquad
    generic map (
        xbits => AUD_IN_R'length
    )
    port map (
        X    => AUD_LPF_MID_X_R,
        Y    => LPF_R,
        coef => lpf_crossover_coef_arr(1),
        clk  => clk,
        rst  => rst
    );

    process(CLK) begin
        if rising_edge(CLK) then
            ldrdyd <= L_RDY;
            rdrdyd <= R_RDY;
            if rdrdyd and R_RDY then
                AUD_IN_R_SYNC <= AUD_IN_R;
            else
                AUD_IN_R_SYNC <= AUD_IN_R_SYNC;
            end if; 
            
            if ldrdyd and L_RDY then
                AUD_IN_L_SYNC <= AUD_IN_L;
            else
                AUD_IN_L_SYNC <= AUD_IN_L_SYNC;
            end if; 
        end if;
    end process;

end architecture;
