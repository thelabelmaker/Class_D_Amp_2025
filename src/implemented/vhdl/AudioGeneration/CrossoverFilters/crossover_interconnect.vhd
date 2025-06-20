-------------------------------------------------------------------------------
--
--  crossover_interconnect.vhd
--  
--  this file wires together the biquad filters used for the crossover and deals
--  with the clock domain transfers from the i2s input to the filter domain. it
--  ensrues that any data coming in or going out is synced with the master clock
--  and coordinates the filters to run at the correct sample rate.
--  
--  Revision History:
--    31 May 25  Ethan Labelson     inital revision
--    31 May 25  Ethan Labelson     file just wires, placeholder
--    02 Jun 
-------------------------------------------------------------------------------

library work; --  import external filter info
    use work.I2S_constants.all;
    use work.filter_constants.all;
    use work.crossover_coef.all;

library ieee; --  import needed standard libs
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

--  entity declaration for crossover_interconnect 
    --  inputs:
    --      AUD_IN_L    :   signed opperand; left channel audio in
    --      AUD_IN_R    :   signed opperand; right channel audio in   
    --      CLK         :   global clock signal
    --      RST         :   system reset
    --      L_READ      :   read signal; left data in can be read
    --      R_READ      :   read signal; right data in can be read
    --      
    --  outputs:
    --      HPF_L       :   signed result; left high pass result   
    --      HPF_R       :   signed result; right high pass result
    --      LPF_L       :   signed result; left low pass result
    --      LPF_R       :   signed result; right low pass result
    --      L_RDY       :   data ready signal; left data out ready
    --      R_RDY       :   data ready signal; right data out ready

entity crossover_interconnect is
    port (
        --  left channel audio in
        AUD_IN_L : in  std_logic_vector((AUD_B - 1) downto 0);
        --  right channel audio in
        AUD_IN_R : in  std_logic_vector((AUD_B - 1) downto 0);

        --  left channel high pass audio out
        HPF_L    : out std_logic_vector((CO_B - 1) downto 0);
        --  right channel high pass audio out
        HPF_R    : out std_logic_vector((CO_B - 1) downto 0);
        --  left channel low pass audio out
        LPF_L    : out std_logic_vector((CO_B - 1) downto 0);
        --  right channel low pass audio out
        LPF_R    : out std_logic_vector((CO_B - 1) downto 0);

        CLK      : in  std_logic; --  global system clock
        RST      : in  std_logic; --  system reset
        L_RDY    : out std_logic; --  left channel data out ready
        R_RDY    : out std_logic; --  right channel data out ready
        L_READ   : in  std_logic; --  can read left channel data in
        R_READ   : in  std_logic  --  can read right channel data in
    );
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

    --  filter "clock" signals to run filters at 192 kHz
    --  seperate signals for left and right to keep in sync with incoming data
    signal filt_clk_l : std_logic;
    signal filt_clk_r : std_logic;

    --  crossover uses 2x biquad elemenmts, need to connect with intermediates 
    --  signals to connect HPF biquads together
    signal AUD_HPF_MID_X_L : std_logic_vector((CO_B - 1) downto 0);
    signal AUD_HPF_MID_X_R : std_logic_vector((CO_B - 1) downto 0);

    --  signals to connect LPF biquads together
    signal AUD_LPF_MID_X_L : std_logic_vector((CO_B - 1) downto 0);
    signal AUD_LPF_MID_X_R : std_logic_vector((CO_B - 1) downto 0);

    signal AUD_IN_L_HOLD : std_logic_vector((CO_B - 1) downto 0);
    signal AUD_IN_R_HOLD : std_logic_vector((CO_B - 1) downto 0);

    --  async (direct filter ouput) for LPF left and right
    signal LPF_R_A : std_logic_vector((CO_B - 1) downto 0);
    signal LPF_L_A : std_logic_vector((CO_B - 1) downto 0);

    --  async (direct filter ouput) for HPF left and right
    signal HPF_R_A : std_logic_vector((CO_B - 1) downto 0);
    signal HPF_L_A : std_logic_vector((CO_B - 1) downto 0);

    --  synchronised (with main clk) for LPF outputs
    signal LPF_R_S : std_logic_vector((CO_B - 1) downto 0);
    signal LPF_L_S : std_logic_vector((CO_B - 1) downto 0);

    --  synchronised (with main clk) for HPF outputs
    signal HPF_R_S : std_logic_vector((CO_B - 1) downto 0);
    signal HPF_L_S : std_logic_vector((CO_B - 1) downto 0);

    --  delayed data ready to be read signals (used to sync inputs)
    --  for left channel
    signal ldrdyd : std_logic;
    --  for right channel
    signal rdrdyd : std_logic;

begin
    --  connect all of the biquads together
    --  this would have been cleaner with a for generate loop but this setup is
    --  not super complex and this makes it easier to connect things togher
    --  without fancy indexing. if I had more time I would have liked to have
    --  made a more generalized generation loop to tweak the filters from the
    --  filter coefficents/constants file.

    --  first HPF biquad (left)
    --      take audio data in from left channel
    --      output audio to intermediate variable
    biquad_l_1_hpf: biquad
        generic map (
            xbits => AUD_IN_L_HOLD'length
        )
        port map (
            X    => AUD_IN_L_HOLD,
            Y    => AUD_HPF_MID_X_L,
            coef => hpf_crossover_coef_arr(0),
            clk  => filt_clk_l,
            rst  => rst
        );

    --  second HPF biquad (left)
    --      take audio data in from intermediate
    --      output audio to async output variable
    biquad_l_2_hpf: biquad
        generic map (
            xbits => AUD_IN_L_HOLD'length
        )
        port map (
            X    => AUD_HPF_MID_X_L,
            Y    => HPF_L_A,
            coef => hpf_crossover_coef_arr(1),
            clk  => filt_clk_l,
            rst  => rst
        );

    --  first HPF biquad (right)
    --      take audio data in from right channel
    --      output audio to intermediate variable
    biquad_r_1_hpf: biquad
        generic map (
            xbits => AUD_IN_R_HOLD'length
        )
        port map (
            X    => AUD_IN_R_HOLD,
            Y    => AUD_HPF_MID_X_R,
            coef => hpf_crossover_coef_arr(0),
            clk  => filt_clk_r,
            rst  => rst
        );

    --  second HPF biquad (right)
    --      take audio data in from intermediate
    --      output audio to async output variable
    biquad_r_2_hpf: biquad
        generic map (
            xbits => AUD_IN_R_HOLD'length
        )
        port map (
            X    => AUD_HPF_MID_X_R,
            Y    => HPF_R_A,
            coef => hpf_crossover_coef_arr(1),
            clk  => filt_clk_r,
            rst  => rst
        );

    --  first LPF biquad (left)
    --      take audio data in from left channel
    --      output audio to intermediate variable
    biquad_l_1_lpf: biquad
        generic map (
            xbits => AUD_IN_L_HOLD'length
        )
        port map (
            X    => AUD_IN_L_HOLD,
            Y    => AUD_LPF_MID_X_L,
            coef => lpf_crossover_coef_arr(0),
            clk  => filt_clk_l,
            rst  => rst
        );

    --  second LPF biquad (left)
    --      take audio data in from intermediate
    --      output audio to async output variable
    biquad_l_2_lpf: biquad
        generic map (
            xbits => AUD_IN_L_HOLD'length
        )
        port map (
            X    => AUD_LPF_MID_X_L,
            Y    => LPF_L_A,
            coef => lpf_crossover_coef_arr(1),
            clk  => filt_clk_l,
            rst  => rst
        );

    --  first LPF biquad (right)
    --      take audio data in from right channel
    --      output audio to intermediate variable
    biquad_r_1_lpf: biquad
        generic map (
            xbits => AUD_IN_R_HOLD'length
        )
        port map (
            X    => AUD_IN_R_HOLD,
            Y    => AUD_LPF_MID_X_R,
            coef => lpf_crossover_coef_arr(0),
            clk  => filt_clk_r,
            rst  => rst
        );

    --  second LPF biquad (right)
    --      take audio data in from intermediate
    --      output audio to async output variable
    biquad_r_2_lpf: biquad
        generic map (
            xbits => AUD_IN_R_HOLD'length
        )
        port map (
            X    => AUD_LPF_MID_X_R,
            Y    => LPF_R_A,
            coef => lpf_crossover_coef_arr(1),
            clk  => filt_clk_r,
            rst  => rst
        );

    process (CLK)
    begin
        if rising_edge(CLK) then
            --  delay the input read signal
            ldrdyd <= L_READ;
            rdrdyd <= R_READ;

            --  if there is rising edge of input read right
            if rdrdyd = '0' and R_READ = '1' then
                --  capture a new input sample. use only the CO_B MSBs.
                AUD_IN_R_HOLD <= AUD_IN_R(AUD_IN_R'high downto AUD_IN_R'high - CO_B + 1);

                --  clock the filters. left channel gets a rising edge when
                --  right data is being read.
                filt_clk_l <= '1';
                filt_clk_r <= '0';

                --  capture the filter outputs of the right channel. 
                HPF_R_S <= HPF_R_A;
                LPF_R_S <= LPF_R_A;
                --  clocking the filters like this is not ideal, but the read
                --  signals are based off of the incoming audio sample clock.
                --  by creating a rising edge for the left channel when reading
                --  a new sample on the right, this optimizes the filter timing
                --  as the left and right read signals are out of phase.
            else
                --  hold the input data
                AUD_IN_R_HOLD <= AUD_IN_R_HOLD;
            end if;

            --  if there is rising edge of input read left
            if ldrdyd = '0' and L_READ = '1' then
                --  capture a new input sample. use only the CO_B MSBs.
                AUD_IN_L_HOLD <= AUD_IN_L(AUD_IN_L'high downto AUD_IN_L'high - CO_B + 1);

                --  clock the filters. right channel gets a rising edge when
                --  left data is being read.
                filt_clk_r <= '1';
                filt_clk_l <= '0';

                --  capture the filter outputs of the left channel. 
                LPF_L_S <= LPF_L_A;
                HPF_L_S <= HPF_L_A;
                --  clocking the filters like this is not ideal, but the read
                --  signals are based off of the incoming audio sample clock.
                --  by creating a rising edge for the left channel when reading
                --  a new sample on the right, this optimizes the filter timing
                --  as the left and right read signals are out of phase.
            else
                --  hold the input data
                AUD_IN_L_HOLD <= AUD_IN_L_HOLD;
            end if;

            --  put the outputs through an extra DFF to make sure they are fully
            --  synced and can be read by the next processing stage.
            HPF_L <= HPF_L_S;
            HPF_R <= HPF_R_S;
            LPF_L <= LPF_L_S;
            LPF_R <= LPF_R_S;

        end if;
    end process;
end architecture;
