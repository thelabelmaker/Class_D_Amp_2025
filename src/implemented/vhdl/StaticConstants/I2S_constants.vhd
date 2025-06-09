--  import libs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.all;

package I2S_constants is 
    constant    sample_rate :   integer :=  192000;  --  sample rate of audio
    constant    MCLK_freq   :   integer :=  integer(24.576e6);
    constant    MCLK_T      :   time    :=  (1.0e12/real(MCLK_freq)) * (1 ps);
    constant    AUD_B       :   integer :=  24;
    constant    BCLK_ratio  :   integer :=  
    integer(MCLK_freq / (2*sample_rate*AUD_B));
    constant    DIV_B       :   integer :=  integer(log2(real(BCLK_ratio)));
    constant    WS_ratio    :   integer :=  BCLK_ratio * AUD_B;
    constant    WS_B        :   integer :=  integer(log2(real(WS_ratio)));
    constant    PWM_B       :   integer :=  5;
    constant    SD_ratio    :   integer :=  2**PWM_B;
end package I2S_constants;