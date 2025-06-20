-------------------------------------------------------------------------------
--
--  crossover_coef.vhd
--
--  
--  Revision History:
--    03 Jun 25  Ethan Labelson     inital revision
--    04 Jun 25  Ethan Labelson     constants for inital biquad
--    07 Jun 25  Ethan Labelson     modified constants for testing with PCB
--    11 Jun 25  Ethan Labelson     working 2 kHz crossover tested
--    12 Jun 25  Ethan Labelson     modified for demo day (5 kHz crossover)
--    19 Jun 25  Ethan Labelson     updated comments and cleaned code
-------------------------------------------------------------------------------

--  import libs
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;
    use ieee.MATH_REAL.all;

--  package i2s_constants 
    --      i2s_constants defines the constants needed to receive data on the
    --      i2s bus. it also ended up providing important constants to the rest
    --      of the code, in particular how many bits long each audio sample is.
package I2S_constants is
    --  sample rate of audio
    constant sample_rate : integer := 192000; 
    --  master clock line frequency
    constant MCLK_freq   : integer := integer(24.576e6);
    --  time to have accurate mclk in sims
    constant MCLK_T      : time    := (1.0e12 / real(MCLK_freq)) * (1 ps);
    --  audio word length
    constant AUD_B       : integer := 32;
    --  bit clock divider ratio (depreciated now that fpga is not i2s master)
    constant BCLK_ratio  : integer := integer(MCLK_freq / (2 * sample_rate * AUD_B));
    --  counter bit to use for bit clock division
    constant DIV_B       : integer := integer(log2(real(BCLK_ratio)));
    --  LR-clock divider ratio (depreciated now that fpga is not i2s master)
    constant WS_ratio    : integer := BCLK_ratio * AUD_B;
    --  counter bit to use for LR=clock division
    constant WS_B        : integer := integer(log2(real(WS_ratio)));
    --  number of bits to use for PWM 
    constant PWM_B       : integer := 6;
    --  number of bits to use for sigma delta averaging filter
    constant ACC_B       : integer := 6;
    --  sigma delta clock speed ratio
    constant SD_ratio    : integer := 2 ** PWM_B;
    --  number of bits to use for the crossover
    constant CO_B        : integer := 24;
end package;
