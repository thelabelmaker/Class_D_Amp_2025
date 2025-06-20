-------------------------------------------------------------------------------
--
--  top_interconnect.vhd
--  
--  this file links together the whole project. its mostly wires. the only logic
--  that happens here is the status leds and ad/bd mux.
--  
--  Revision History:
--    31 May 25  Ethan Labelson     inital revision
--    01 Jun 25  Ethan Labelson     attempt to add the i2c to the file
--    02 Jun 25  Ethan Labelson     modified to work with 1 bit sigma delta
--    19 Jun 25  Ethan Labelson     updated comments and cleaned code
--------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library work;
    use work.I2S_constants.all;

--  entity declaration for quantizer_interconnect 
    --  inputs:
    --      SD          :   data bit; serial data in from i2s
    --      WS          :   audio frame clock; word select choose L/R   
    --      BCK         :   audio bit clock; data bits sync with bck
    --      RST         :   system reset
    --      CLK         :   global clock signal
    --      
    --  outputs:
    --      AUD_*       :   audio enable bits; each audio channel has one   
    --      STATUS_LED  :   pwm enable bit; right pwm power stange enable
entity top_interconnect is
    port (
        SD              : in    std_logic; --  i2s data in
        WS              : in    std_logic; --  i2s word select
        BCK             : in    std_logic; --  i2s bit clk

        SDA             : inout std_logic; --  i2c SDA
        SCL             : in    std_logic; --  i2c SCL

        --  audio right channel, high pass, positive terminal, single ended
        AUD_HPF_R_POS   : out   std_logic;
        --  audio left channel, high pass, positive terminal, single ended
        AUD_HPF_L_POS   : out   std_logic;
        --  audio right channel, low pass, positive terminal, single ended
        AUD_LPF_R_POS   : out   std_logic;
        --  audio left channel, low pass, positive terminal, single ended
        AUD_LPF_L_POS   : out   std_logic;

        --  audio right channel, high pass, negitive terminal, single ended
        AUD_HPF_R_NEG   : out   std_logic;
        --  audio left channel, high pass, negitive terminal, single ended
        AUD_HPF_L_NEG   : out   std_logic;
        --  audio right channel, low pass, negitive terminal, single ended
        AUD_LPF_R_NEG   : out   std_logic;
        --  audio left channel, low pass, negitive terminal, single ended
        AUD_LPF_L_NEG   : out   std_logic;

        --  audio right channel, high pass, positive terminal, lvds pair
        AUD_HPF_R_POS_P : out   std_logic;
        AUD_HPF_R_POS_N : out   std_logic;
        --  audio left channel, high pass, positive terminal, lvds pair
        AUD_HPF_L_POS_P : out   std_logic;
        AUD_HPF_L_POS_N : out   std_logic;

        --  audio right channel, low pass, positive terminal, lvds pair
        AUD_LPF_R_POS_P : out   std_logic;
        AUD_LPF_R_POS_N : out   std_logic;

        --  audio left channel, low pass, positive terminal, lvds pair
        AUD_LPF_L_POS_P : out   std_logic;
        AUD_LPF_L_POS_N : out   std_logic;

        --  audio right channel, high pass, negitive terminal, lvds pair
        AUD_HPF_R_NEG_P : out   std_logic;
        AUD_HPF_R_NEG_N : out   std_logic;

        --  audio left channel, high pass, negitive terminal, lvds pair
        AUD_HPF_L_NEG_P : out   std_logic;
        AUD_HPF_L_NEG_N : out   std_logic;

        --  audio right channel, low pass, negitive terminal, lvds pair
        AUD_LPF_R_NEG_P : out   std_logic;
        AUD_LPF_R_NEG_N : out   std_logic;

        --  audio left channel, low pass, negitive terminal, lvds pair
        AUD_LPF_L_NEG_P : out   std_logic;
        AUD_LPF_L_NEG_N : out   std_logic;

        --  system clock line
        CLK             : in    std_logic;
        --  system reset signal
        RST             : in    std_logic;
        --  status LEDs (on board)
        STATUS_LED      : out   std_logic_vector(7 downto 0));
end entity;

architecture Behavioral of top_interconnect is
    --  define i2s manager
    component I2S_interconnect is
        port (
            CLK   : in  std_logic;
            RST   : in  std_logic;
            DI    : in  std_logic;
            BCK   : in  std_logic;
            WS    : in  std_logic;
            L_RDY : out std_logic;
            R_RDY : out std_logic;
            DO_L  : out std_logic_vector((AUD_B - 1) downto 0);
            DO_R  : out std_logic_vector((AUD_B - 1) downto 0));
    end component;

    --  define audio processing
    component audio_interconnect is
        port (

            AUD_IN_L  : in  std_logic_vector((AUD_B - 1) downto 0);
            AUD_IN_R  : in  std_logic_vector((AUD_B - 1) downto 0);
            AUD_HPF_R : out std_logic;
            AUD_HPF_L : out std_logic;
            AUD_LPF_R : out std_logic;
            AUD_LPF_L : out std_logic;

            L_READ    : in  std_logic;
            R_READ    : in  std_logic;

            update    : in  std_logic;
            addr      : in  std_logic_vector(7 downto 0);
            cval      : in  std_logic_vector(31 downto 0);

            CLK       : in  std_logic;
            RST       : in  std_logic);
    end component;

    --  ready signals from filters
    signal i2s_l_rdy : std_logic;
    signal i2s_r_rdy : std_logic;

    --  i2s data ready signals
    signal i2s_dr : std_logic_vector((AUD_B - 1) downto 0);
    signal i2s_dl : std_logic_vector((AUD_B - 1) downto 0);

    --  intermediate for audio inputs
    signal in_l_pos : std_logic_vector((AUD_B - 1) downto 0);
    signal in_r_pos : std_logic_vector((AUD_B - 1) downto 0);
    signal in_l_neg : std_logic_vector((AUD_B - 1) downto 0);
    signal in_r_neg : std_logic_vector((AUD_B - 1) downto 0);

    --  intermediates for audio outputs before buffer
    signal hpf_r_pos : std_logic;
    signal hpf_l_pos : std_logic;
    signal hpf_r_neg : std_logic;
    signal hpf_l_neg : std_logic;
    signal lpf_r_pos : std_logic;
    signal lpf_l_pos : std_logic;
    signal lpf_r_neg : std_logic;
    signal lpf_l_neg : std_logic;

    --  positive outputs of audio processing
    signal hpf_r_pos_xd : std_logic;
    signal hpf_l_pos_xd : std_logic;
    signal lpf_r_pos_xd : std_logic;
    signal lpf_l_pos_xd : std_logic;

    --  ad negative outputs of audio processing before ad/bd mux
    signal lpf_r_neg_ad : std_logic;
    signal lpf_l_neg_ad : std_logic;
    signal hpf_r_neg_ad : std_logic;
    signal hpf_l_neg_ad : std_logic;

    --  bd negative outputs of audio processing before ad/bd mux
    signal lpf_r_neg_bd : std_logic;
    signal lpf_l_neg_bd : std_logic;
    signal hpf_r_neg_bd : std_logic;
    signal hpf_l_neg_bd : std_logic;

    --  depreciated because i didn't end up using i2c
    --  signals would be fore i2c data and adress for modifying the sigma delta
    --  and/or filter coefficents live.
    --  signals i2c update
    signal update : std_logic;
    --  i2c data out
    signal i2c_do : std_logic_vector(31 downto 0);
    --  i2c "address" out. address determins which parameter to change on update
    signal i2c_ao : std_logic_vector(7 downto 0);

    -- 0 for AD modulation, 1 for BD
    constant mod_mode : std_logic := '1';

begin

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

    --  send i2s data directly into positive audio input
    in_l_pos <= i2s_dl;
    in_r_pos <= i2s_dr;

    --  negate i2s data before sending into negative audio input (for bd)
    in_l_neg <= std_logic_vector(resize(- 1 * signed(i2s_dl), AUD_B));
    in_r_neg <= std_logic_vector(resize(- 1 * signed(i2s_dr), AUD_B));

    --  run audio processing on non negated data
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

        --  run audio processing on negated data
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


    --  for ad modulation negate process output
    hpf_r_neg_ad <= not hpf_r_pos_xd;
    hpf_l_neg_ad <= not hpf_l_pos_xd;
    lpf_r_neg_ad <= not lpf_r_pos_xd;
    lpf_l_neg_ad <= not lpf_l_pos_xd;


    --  
    led_loop: for l in STATUS_LED'range generate
        STATUS_LED(l) <= '1' when resize(unsigned(abs(signed(I2S_DL(I2S_DL'high downto 1)) + signed(I2S_DR(I2S_DR'high downto 1)))), STATUS_LED'length) > to_unsigned(2 ** (STATUS_LED'length) - 2 ** (l) - 1, STATUS_LED'length) else '0';
    end generate;

    process (CLK)
    begin
        if rising_edge(CLK) then
            --  put positive signals through buffer DFF
            hpf_l_pos <= hpf_l_pos_xd;
            hpf_r_pos <= hpf_r_pos_xd;
            lpf_l_pos <= lpf_l_pos_xd;
            lpf_r_pos <= lpf_r_pos_xd;

            
            if mod_mode = '1' then
                --  if doing bd modulation, use BD versions
                hpf_l_neg <= hpf_l_neg_bd;
                hpf_r_neg <= hpf_r_neg_bd;
                lpf_l_neg <= lpf_l_neg_bd;
                lpf_r_neg <= lpf_r_neg_bd;
            else
                --  if doing ad modulation, use AD versions
                hpf_l_neg <= hpf_l_neg_ad;
                hpf_r_neg <= hpf_r_neg_ad;
                lpf_l_neg <= lpf_l_neg_ad;
                lpf_r_neg <= lpf_r_neg_ad;
            end if;

            --  output "lvds" differential pairs 
            --  doing manually bc vivado being annoying
            AUD_HPF_L_NEG_P <= hpf_l_neg;
            AUD_HPF_L_NEG_N <= not hpf_l_neg;

            AUD_HPF_R_NEG_P <= hpf_r_neg;
            AUD_HPF_R_NEG_N <= not hpf_r_neg;

            AUD_HPF_L_POS_P <= hpf_l_pos;
            AUD_HPF_L_POS_N <= not hpf_l_pos;

            AUD_HPF_R_POS_P <= hpf_r_pos;
            AUD_HPF_R_POS_N <= not hpf_r_pos;

            AUD_LPF_L_NEG_P <= lpf_l_neg;
            AUD_LPF_L_NEG_N <= not lpf_l_neg;

            AUD_LPF_R_NEG_P <= lpf_r_neg;
            AUD_LPF_R_NEG_N <= not lpf_r_neg;

            AUD_LPF_L_POS_P <= lpf_l_pos;
            AUD_LPF_L_POS_N <= not lpf_l_pos;

            AUD_LPF_R_POS_P <= lpf_r_pos;
            AUD_LPF_R_POS_N <= not lpf_r_pos;


            --  another output buffer for all audio signals
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
