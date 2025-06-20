-------------------------------------------------------------------------------
--
--  quantizer_interconnect.vhd
--  
--  this file links together the sigma delta and pwm output stages. it is just
--  wiring the components together but makes it so my top level entity dosent
--  change if i need to change my quantization scheme.
--  
--  Revision History:
--    14 May 25  Ethan Labelson     inital revision
--    02 Jun 25  Ethan Labelson     modified to work with 1 bit sigma delta
--    19 Jun 25  Ethan Labelson     updated comments and cleaned code
-------------------------------------------------------------------------------


library work;
    use work.I2S_constants.all;

library ieee;
    use ieee.std_logic_1164.all;

    --  entity declaration for quantizer_interconnect 
    --  inputs:
    --      DI_L        :   signed opperand; left channel audio in
    --      DI_R        :   signed opperand; right channel audio in   
    --      CLK         :   global clock signal
    --      RST         :   
    --      L_READ      :   read signal; left data in can be read
    --      R_READ      :   read signal; right data in can be read
    --      
    --  outputs:
    --      EN_L        :   pwm enable bit; left pwm power stange enable   
    --      EN_R        :   pwm enable bit; right pwm power stange enable

entity quantizer_interconnect is
    port (
        L_READ : in  std_logic; --  can read left channel data in
        R_READ : in  std_logic; --  can read right channel data in
        --  left channel audio in
        DI_L   : in  std_logic_vector((CO_B - 1) downto 0);
        --  right channel audio 
        DI_R   : in  std_logic_vector((CO_B - 1) downto 0);
        update : in  std_logic;
        addr   : in  std_logic_vector(7 downto 0);
        cval   : in  std_logic_vector(31 downto 0);
        CLK    : in  std_logic; --  global system clock
        RST    : in  std_logic; --  system reset
        EN_L   : out std_logic; --  left pwm enable 
        EN_R   : out std_logic  --  right pwm enable
    );
end entity;

architecture Behavioral of quantizer_interconnect is
    --  bring in components
    --  sigma delta quantizer
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
    --  pwm output stage
    component PWM_output is
        port (
            SCLK  : in  std_logic;
            DCLK  : in  std_logic;
            SDCLK : out std_logic;
            DIN   : in  std_logic;
            EN    : out std_logic;
            RST   : in  std_logic);
    end component;


    signal SDCLK_L : std_logic;
    signal SDCLK_R : std_logic;

    signal SDCK    : std_logic;
    signal QUANT_L : std_logic;
    signal QUANT_R : std_logic;

begin

    --  sigma delta uses global clock now! yay!
    SDCK <= CLK;

    --  quantizer run for left channel
    quantizer_l: SigmaDelta
        generic map (CO_B, PWM_B)
        port map (
            X      => DI_L,
            Y      => QUANT_L,
            clk    => SDCK,
            update => update,
            addr   => addr,
            cval   => cval,
            dclk   => L_READ
        );

    --  quantizer run for right channel
    quantizer_r: SigmaDelta
        generic map (CO_B, PWM_B)
        port map (
            X      => DI_R,
            Y      => QUANT_R,
            clk    => SDCK,
            update => update,
            addr   => addr,
            cval   => cval,
            dclk   => R_READ
        );

    --  pwm output left
    pwm_output_l: PWM_output
        port map (
            SCLK => SDCK,
            DCLK => L_READ,
            DIN  => QUANT_L,
            EN   => EN_L,
            RST  => RST
        );

    --  pwm output right
    pwm_output_r: PWM_output
        port map (
            SCLK => SDCK,
            DCLK => R_READ,
            DIN  => QUANT_R,
            EN   => EN_R,
            RST  => RST
        );

end architecture;
