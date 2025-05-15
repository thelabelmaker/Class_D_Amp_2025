--  import libs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.all;

package I2S_constants is 
    constant    sample_rate :   integer :=  24000;  --  sample rate of audio
    constant    MCLK_freq   :   integer :=  49152000*2;
    constant    AUD_B       :   integer :=  16;
    constant    BCLK_ratio  :   integer :=  
    integer(MCLK_freq / (2*sample_rate*AUD_B));
    constant    DIV_B       :   integer :=  integer(log2(real(BCLK_ratio)));
    constant    WS_ratio    :   integer :=  MCLK_freq / (2*sample_rate);
    constant    WS_B        :   integer :=  integer(log2(real(WS_ratio)));
    constant    PWM_B       :   integer :=  5;
end package I2S_constants;