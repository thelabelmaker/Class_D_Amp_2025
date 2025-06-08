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
    use IEEE.NUMERIC_STD.ALL;

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

    signal sclk_div :   unsigned((WS_B) downto 0);
    signal sclk_div_s :   unsigned((WS_B) downto 0);
    signal filt_clk :   std_logic;
    
    signal AUD_HPF_MID_X_L: std_logic_vector(AUD_IN_L'range);
    signal AUD_HPF_MID_X_R: std_logic_vector(AUD_IN_R'range);

    signal AUD_LPF_MID_X_L: std_logic_vector(AUD_IN_L'range);
    signal AUD_LPF_MID_X_R: std_logic_vector(AUD_IN_R'range);

    signal AUD_IN_L_SYNC: std_logic_vector(AUD_IN_L'range);
    signal AUD_IN_R_SYNC: std_logic_vector(AUD_IN_R'range);

    signal AUD_IN_L_HOLD: std_logic_vector(AUD_IN_L'range);
    signal AUD_IN_R_HOLD: std_logic_vector(AUD_IN_R'range);

    signal LPF_R_A : std_logic_vector(AUD_IN_R'range);
    signal LPF_L_A : std_logic_vector(AUD_IN_R'range);

    signal HPF_R_A : std_logic_vector(AUD_IN_R'range);
    signal HPF_L_A : std_logic_vector(AUD_IN_R'range);

    signal LPF_R_S : std_logic_vector(AUD_IN_R'range);
    signal LPF_L_S : std_logic_vector(AUD_IN_R'range);

    signal HPF_R_S : std_logic_vector(AUD_IN_R'range);
    signal HPF_L_S : std_logic_vector(AUD_IN_R'range);

    signal ldrdyd: std_logic;
    signal rdrdyd : std_logic;
    
    --  0 = crossover filter disabled, 1 = enabled
    constant filt_en: std_logic := '0';
begin
    biquad_l_1_hpf : biquad
    generic map (
        xbits => AUD_IN_L'length
    )
    port map (
        X    => AUD_IN_L_SYNC,
        Y    => AUD_HPF_MID_X_L,
        coef => hpf_crossover_coef_arr(0),
        clk  => filt_clk,
        rst  => rst
    );

    biquad_l_2_hpf : biquad
    generic map (
        xbits => AUD_IN_L'length
    )
    port map (
        X    => AUD_HPF_MID_X_L,
        Y    => HPF_L_A,
        coef => hpf_crossover_coef_arr(1),
        clk  => filt_clk,
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
        clk  => filt_clk,
        rst  => rst
    );

    biquad_r_2_hpf : biquad
    generic map (
        xbits => AUD_IN_R'length
    )
    port map (
        X    => AUD_HPF_MID_X_R,
        Y    => HPF_R_A,
        coef => hpf_crossover_coef_arr(1),
        clk  => filt_clk,
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
        clk  => filt_clk,
        rst  => rst
    );

    biquad_l_2_lpf : biquad
    generic map (
        xbits => AUD_IN_L'length
    )
    port map (
        X    => AUD_LPF_MID_X_L,
        Y    => LPF_L_A,
        coef => lpf_crossover_coef_arr(1),
        clk  => filt_clk,
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
        clk  => filt_clk,
        rst  => rst
    );

    biquad_r_2_lpf : biquad
    generic map (
        xbits => AUD_IN_R'length
    )
    port map (
        X    => AUD_LPF_MID_X_R,
        Y    => LPF_R_A,
        coef => lpf_crossover_coef_arr(1),
        clk  => filt_clk,
        rst  => rst
    );

    sclk_div <= sclk_div_s when RST = '1' else (others => '0');
    filt_clk <= sclk_div(sclk_div'high);

    process(CLK) begin
        if rising_edge(CLK) then
            sclk_div_s <=   sclk_div + 1;
            ldrdyd <= L_READ;
            rdrdyd <= R_READ;
            L_RDY <=    sclk_div_s(sclk_div_s'high) xnor sclk_div_s(sclk_div_s'high-1);
            R_RDY <=    sclk_div_s(sclk_div_s'high) xnor sclk_div_s(sclk_div_s'high-1);
            if rdrdyd='0' and R_READ='1' then
                AUD_IN_R_HOLD <= AUD_IN_R;
            else
                AUD_IN_R_HOLD <= AUD_IN_R_HOLD;
            end if; 
            
            if ldrdyd='0' and L_READ='1' then
                AUD_IN_L_HOLD <= AUD_IN_L;
            else
                AUD_IN_L_HOLD <= AUD_IN_L_HOLD;
            end if; 
            HPF_L   <=  HPF_L_S;
            HPF_R   <=  HPF_R_S;
            LPF_L   <=  LPF_L_S;
            LPF_R   <=  LPF_R_S;
        end if;
    end process;

    process(filt_clk) begin
        if rising_edge(filt_clk) then
            AUD_IN_L_SYNC   <=  AUD_IN_L_HOLD;
            AUD_IN_R_SYNC   <=  AUD_IN_R_HOLD;
            if filt_en = '1' then
                HPF_L_S   <=  HPF_L_A;
                HPF_R_S   <=  HPF_R_A;
                LPF_L_S   <=  LPF_L_A;
                LPF_R_S   <=  LPF_R_A;
            else
                HPF_L_S   <=  AUD_IN_L_SYNC;
                HPF_R_S   <=  AUD_IN_R_SYNC;
                LPF_L_S   <=  AUD_IN_L_SYNC;
                LPF_R_S   <=  AUD_IN_R_SYNC;
            end if;
        end if;
    end process;

end architecture;
