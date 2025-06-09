----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 11:36:57 PM
-- Design Name: 
-- Module Name: top_interconnect - Behavioral
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
    use IEEE.NUMERIC_STD.all;

library work;
    use work.I2S_constants.all;

    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;

entity top_interconnect is
    port (SD            : in    STD_LOGIC;
          WS            : in   STD_LOGIC;
          BCK           : in   STD_LOGIC;
          --MCLK          : in   STD_LOGIC;
          SDA           : inout STD_LOGIC;
          SCL           : in    STD_LOGIC;

          AUD_HPF_R_POS : out   STD_LOGIC;
          AUD_HPF_L_POS : out   STD_LOGIC;
          AUD_LPF_R_POS : out   STD_LOGIC;
          AUD_LPF_L_POS : out   STD_LOGIC;

          AUD_HPF_R_NEG : out   STD_LOGIC;
          AUD_HPF_L_NEG : out   STD_LOGIC;
          AUD_LPF_R_NEG : out   STD_LOGIC;
          AUD_LPF_L_NEG : out   STD_LOGIC;

          --CLK_100       : in    STD_LOGIC;
          CLK           : in    std_logic;
          RST           : in    STD_LOGIC;
          STATUS_LED    : out   std_logic_vector(7 downto 0));
          --mod_mode      : in    std_logic);
end entity;

architecture Behavioral of top_interconnect is
    component I2S_interconnect is
        port (CLK   : in  STD_LOGIC;
              RST   : in  STD_LOGIC;
              DI    : in  STD_LOGIC;
              BCK   : in STD_LOGIC;
              WS    : in STD_LOGIC;
              L_RDY : out STD_LOGIC;
              R_RDY : out STD_LOGIC;
              DO_L  : out STD_LOGIC_VECTOR((AUD_B - 1) downto 0);
              DO_R  : out STD_LOGIC_VECTOR((AUD_B - 1) downto 0));
    end component;

    component audio_interconnect is
        port (

            AUD_IN_L  : in  std_logic_vector((AUD_B - 1) downto 0);
            AUD_IN_R  : in  std_logic_vector((AUD_B - 1) downto 0);
            AUD_HPF_R : out STD_LOGIC;
            AUD_HPF_L : out STD_LOGIC;
            AUD_LPF_R : out STD_LOGIC;
            AUD_LPF_L : out STD_LOGIC;

            L_READ    : in  std_logic;
            R_READ    : in  std_logic;

            update    : in  std_logic;
            addr      : in  std_logic_vector(7 downto 0);
            cval      : in  std_logic_vector(31 downto 0);

            CLK       : in  STD_LOGIC;
            RST       : in  STD_LOGIC);
    end component;

--    component I2C_interconnect is
--        port (
--            SDA    : inout std_logic;
--            SCL    : in   std_logic;
--            dout   : out   std_logic_vector(31 downto 0);
--            addr   : out   std_logic_vector(7 downto 0);
--            update : out   std_logic;

--            clk    : in    std_logic;
--            rst    : in    std_logic
--        );

--    end component;

--    component CLK_SOLO_wrapper is
--        port (
--            CLK     : out STD_LOGIC;
--            CLK_100 : in  STD_LOGIC;
--            RST     : in  STD_LOGIC
--        );
--    end component;

    --signal CLK       : std_logic;
    signal i2s_l_rdy : std_logic;
    signal i2s_r_rdy : std_logic;

    signal i2s_dr : std_logic_vector((AUD_B - 1) downto 0);
    signal i2s_dl : std_logic_vector((AUD_B - 1) downto 0);

    signal in_l_pos : std_logic_vector((AUD_B - 1) downto 0);
    signal in_r_pos : std_logic_vector((AUD_B - 1) downto 0);
    signal in_l_neg : std_logic_vector((AUD_B - 1) downto 0);
    signal in_r_neg : std_logic_vector((AUD_B - 1) downto 0);

    signal hpf_r_pos : std_logic;
    signal hpf_l_pos : std_logic;
    signal hpf_r_neg : std_logic;
    signal hpf_l_neg : std_logic;
    signal lpf_r_pos : std_logic;
    signal lpf_l_pos : std_logic;
    signal lpf_r_neg : std_logic;
    signal lpf_l_neg : std_logic;

    signal hpf_r_pos_xd : std_logic;
    signal hpf_l_pos_xd : std_logic;
    signal lpf_r_pos_xd : std_logic;
    signal lpf_l_pos_xd : std_logic;

    signal lpf_r_neg_ad : std_logic;
    signal lpf_l_neg_ad : std_logic;
    signal hpf_r_neg_ad : std_logic;
    signal hpf_l_neg_ad : std_logic;

    signal lpf_r_neg_bd : std_logic;
    signal lpf_l_neg_bd : std_logic;
    signal hpf_r_neg_bd : std_logic;
    signal hpf_l_neg_bd : std_logic;

    signal update : std_logic;
    signal i2c_do : std_logic_vector(31 downto 0);
    signal i2c_ao : std_logic_vector(7 downto 0);

    -- 0 for AD modulation, 1 for BD
    constant mod_mode : std_logic := '0';

begin

    -- pll: CLK_SOLO_wrapper
    --     port map (
    --         CLK_100 => CLK_100,
    --         CLK     => CLK,
    --         RST     => RST
    --     );

    i2s_controller: I2S_interconnect
        port map (
            CLK   => CLK,
            RST   => RST,
            DI    => SD,
            BCK   => BCK,
            WS    => WS,
            L_RDY => i2s_l_rdy,
            R_RDY => i2s_r_rdy,
            DO_L  => i2s_dl,
            DO_R  => i2s_dr
        );

    in_l_pos <= i2s_dl;
    in_r_pos <= i2s_dr;

    in_l_neg <= std_logic_vector(resize(- 1 * signed(i2s_dl), AUD_B));
    in_r_neg <= std_logic_vector(resize(- 1 * signed(i2s_dr), AUD_B));

--    i2c_mgr: I2C_interconnect
--        port map (
--            SDA    => SDA,
--            SCL    => SCL,
--            dout   => i2c_do,
--            addr   => i2c_ao,
--            update => update,
--            clk    => clk,
--            rst    => rst
--        );

    audio_pos: audio_interconnect
        port map (
            AUD_IN_L  => in_l_pos,
            AUD_IN_R  => in_r_pos,
            AUD_HPF_R => hpf_r_pos_xd,
            AUD_HPF_L => hpf_l_pos_xd,
            AUD_LPF_R => lpf_r_pos_xd,
            AUD_LPF_L => lpf_l_pos_xd,
            L_READ    => i2s_l_rdy,
            R_READ    => i2s_r_rdy,
            update    => update,
            addr      => i2c_ao,
            cval      => i2c_do,
            CLK       => CLK,
            RST       => RST
        );

    audio_neg: audio_interconnect
        port map (
            AUD_IN_L  => in_l_neg,
            AUD_IN_R  => in_r_neg,
            AUD_HPF_R => hpf_r_neg_bd,
            AUD_HPF_L => hpf_l_neg_bd,
            AUD_LPF_R => lpf_r_neg_bd,
            AUD_LPF_L => lpf_l_neg_bd,
            L_READ    => i2s_l_rdy,
            R_READ    => i2s_r_rdy,
            update    => update,
            addr      => i2c_ao,
            cval      => i2c_do,
            CLK       => CLK,
            RST       => RST
        );

    hpf_r_neg_ad <= not hpf_r_pos_xd;
    hpf_l_neg_ad <= not hpf_l_pos_xd;
    lpf_r_neg_ad <= not lpf_r_pos_xd;
    lpf_l_neg_ad <= not lpf_l_pos_xd;

    led_loop : for l in STATUS_LED'range generate
        STATUS_LED(l) <= '1' when resize(unsigned(abs(signed(I2S_DL(I2S_DL'high downto 1)) + signed(I2S_DR(I2S_DR'high downto 1)))), STATUS_LED'length) > to_unsigned(2**(STATUS_LED'length) - 2**(l) - 1, STATUS_LED'length) else '0';
    end generate;

    process (CLK)
    begin
        if rising_edge(CLK) then

            hpf_l_pos <= hpf_l_pos_xd;
            hpf_r_pos <= hpf_l_pos_xd;
            lpf_l_pos <= hpf_l_pos_xd;
            lpf_r_pos <= hpf_l_pos_xd;

            if mod_mode = '1' then
                hpf_l_neg <= hpf_l_neg_bd;
                hpf_r_neg <= hpf_r_neg_bd;
                lpf_l_neg <= lpf_l_neg_bd;
                lpf_r_neg <= lpf_r_neg_bd;
            else
                hpf_l_neg <= hpf_l_neg_ad;
                hpf_r_neg <= hpf_r_neg_ad;
                lpf_l_neg <= lpf_l_neg_ad;
                lpf_r_neg <= lpf_r_neg_ad;
            end if;

            AUD_HPF_L_NEG <= hpf_l_neg;
            AUD_HPF_R_NEG <= hpf_r_neg;

            AUD_HPF_L_POS <= hpf_l_pos;
            AUD_HPF_R_POS <= hpf_r_pos;

            AUD_LPF_L_NEG <= lpf_l_neg;
            AUD_LPF_R_NEG <= lpf_r_neg;

            AUD_LPF_L_POS <= lpf_l_pos;
            AUD_LPF_R_POS <= lpf_r_pos;

        end if;
    end process;

end architecture;
