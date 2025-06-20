-------------------------------------------------------------------------------
--
--  audio_interconnect.vhd
--  
--  this file connects together all of the audio manipulation components. it
--  attaches the crossover to the quantizer, and makes sure all the high pass,
--  low pass, left and right audio ends up going to the correct place.
--  
--  Revision History:
--    31 May 25  Ethan Labelson     inital revision
--    01 Jun 25  Ethan Labelson     project restructured more logically
--    02 Jun 25  Ethan Labelson     touch up restructure
--    19 Jun 25  Ethan Labelson     updated comments and docs
-------------------------------------------------------------------------------



library ieee;
    use ieee.std_logic_1164.all;

library work;
    use work.I2S_constants.all;

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
    --      AUD_HPF_L   :   signed result; left high pass result   
    --      AUD_HPF_R   :   signed result; right high pass result
    --      AUD_LPF_L   :   signed result; left low pass result
    --      AUD_LPF_R   :   signed result; right low pass result

entity audio_interconnect is
    port (
        --  left audio input
        AUD_IN_L  : in  std_logic_vector((AUD_B - 1) downto 0);
        --  right audio input
        AUD_IN_R  : in  std_logic_vector((AUD_B - 1) downto 0);

        --  high pass right audio output
        AUD_HPF_R : out std_logic;
        --  high pass left audio output
        AUD_HPF_L : out std_logic;
        --  low pass right audio output
        AUD_LPF_R : out std_logic;
        --  low pass left audio output
        AUD_LPF_L : out std_logic;

        --  signals for changing params via i2c. currently unused
        update    : in  std_logic;
        addr      : in  std_logic_vector(7 downto 0);
        cval      : in  std_logic_vector(31 downto 0);

        --  signals indicating data can be read
        L_READ    : in  std_logic;
        R_READ    : in  std_logic;

        --  global clock
        CLK       : in  std_logic;
        --  system reset
        RST       : in  std_logic);
end entity;

architecture Behavioral of audio_interconnect is
    --  declare all submodules for use
    --  crossover for running hpf and lpf
    component crossover_interconnect is
        port (
            AUD_IN_L : in  std_logic_vector((AUD_B - 1) downto 0);
            AUD_IN_R : in  std_logic_vector((AUD_B - 1) downto 0);
            HPF_L    : out std_logic_vector((CO_B - 1) downto 0);
            HPF_R    : out std_logic_vector((CO_B - 1) downto 0);
            LPF_L    : out std_logic_vector((CO_B - 1) downto 0);
            LPF_R    : out std_logic_vector((CO_B - 1) downto 0);
            CLK      : in  std_logic;
            RST      : in  std_logic;
            L_RDY    : out std_logic;
            R_RDY    : out std_logic;
            L_READ   : in  std_logic;
            R_READ   : in  std_logic);
    end component;

    --  quantizer for doing sigma delta and pwm
    component quantizer_interconnect is
        port (
            L_READ : in  std_logic;
            R_READ : in  std_logic;
            DI_L   : in  std_logic_vector((CO_B - 1) downto 0);
            DI_R   : in  std_logic_vector((CO_B - 1) downto 0);
            update : in  std_logic;
            addr   : in  std_logic_vector(7 downto 0);
            cval   : in  std_logic_vector(31 downto 0);
            CLK    : in  std_logic;
            RST    : in  std_logic;
            EN_L   : out std_logic;
            EN_R   : out std_logic);
    end component;

    --  signals to wire things together
    signal hpf_l : std_logic_vector((CO_B - 1) downto 0);
    signal hpf_r : std_logic_vector((CO_B - 1) downto 0);
    signal lpf_l : std_logic_vector((CO_B - 1) downto 0);
    signal lpf_r : std_logic_vector((CO_B - 1) downto 0);

    signal co_l_rdy : std_logic;
    signal co_r_rdy : std_logic;

begin

    --  wire together the crossover
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

    --  pipe crossover into quantizer for hpf
    quantizer_hpf: quantizer_interconnect
        port map (
            L_READ => co_r_rdy,
            R_READ => co_l_rdy,
            DI_L   => hpf_l,
            DI_R   => hpf_r,
            update => update,
            addr   => addr,
            cval   => cval,
            CLK    => CLK,
            RST    => RST,
            EN_L   => AUD_HPF_L,
            EN_R   => AUD_HPF_R
        );

    --  pipe crossover into quantizer for lpf
    quantizer_lpf: quantizer_interconnect
        port map (
            L_READ => co_r_rdy,
            R_READ => co_l_rdy,
            DI_L   => lpf_l,
            DI_R   => lpf_r,
            update => update,
            addr   => addr,
            cval   => cval,
            CLK    => CLK,
            RST    => RST,
            EN_L   => AUD_LPF_L,
            EN_R   => AUD_LPF_R
        );

end architecture;
