--  import libs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.all;

package I2S_constants is 
    constant    sample_rate :   integer :=  48000;  --  sample rate of audio
    constant    MCLK_freq   :   integer :=  49152000;
    constant    AUD_B       :   integer :=  16;
    constant    BCLK_ratio  :   integer :=  MCLK_freq / (2*sample_rate*AUD_B);
    constant    DIV_B       :   integer :=  log2(BCLK_ratio);
    constant    WS_ratio    :   integer :=  MCLK_freq / (2*sample_rate);
    constant    WS_B        :   integer :=  log2(MCLK_ratio);

end package I2S_constants;