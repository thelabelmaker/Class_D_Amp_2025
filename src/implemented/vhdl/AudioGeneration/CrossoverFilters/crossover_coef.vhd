library work;
library IEEE;
    use IEEE.STD_LOGIC_1164.all;
    use ieee.numeric_std.all;
    use work.filter_constants.all;
    use ieee.math_real.all;

package crossover_coef is
    constant nbiquads: integer := 2;
    type crossover_coef_arr_t is array(0 to (nbiquads-1)) of biquad_coef;

    --  coefficents in Q 1.(cbits-1)
    --  numbers in range -2 and 2 exclusive
    --  scale factor of cbits-2 bc of sign bit
    constant cscale: real := 2.0**(cbits-2);

    constant lpf_crossover_coef_arr : crossover_coef_arr_t := 
    (
        (   --  1st biquad coefficents
            --  b2                  --  a2
            (to_signed(integer(cscale*0.0125), cbits),    to_signed(integer(cscale*0.710), cbits)),
            --  b1                  --  a1
            (to_signed(integer(cscale*0.0250), cbits),    to_signed(integer(cscale*(-1.6601)), cbits)),
            --  b0                  --  a0
            (to_signed(integer(cscale*0.0125), cbits),    to_signed(integer(cscale*1.0), cbits))
        ),

        (   --  2nd biquad coefficents
            --  b2                  --  a2
            (to_signed(integer(cscale*0.0125), cbits),    to_signed(integer(cscale*0.710), cbits)),
            --  b1                  --  a1
            (to_signed(integer(cscale*0.0250), cbits),    to_signed(integer(cscale*(-1.6601)),cbits)),
            --  b0                  --  a0
            (to_signed(integer(cscale*0.0125), cbits),    to_signed(integer(cscale*1.0), cbits))
        )
    );

    constant hpf_crossover_coef_arr : crossover_coef_arr_t := 
    (
        (   --  1st biquad coefficents
            --  b2                  --  a2
            (to_signed(integer(cscale*0.8425), cbits),    to_signed(integer(cscale*0.710), cbits)),
            --  b1                  --  a1
            (to_signed(integer(cscale*(-1.6850)), cbits),    to_signed(integer(cscale*(-1.6601)), cbits)),
            --  b0                  --  a0
            (to_signed(integer(cscale*0.8425), cbits),    to_signed(integer(cscale*1.0), cbits))
        ),

        (   --  2nd biquad coefficents
            --  b2                  --  a2
            (to_signed(integer(cscale*0.8425), cbits),    to_signed(integer(cscale*0.710), cbits)),
            --  b1                  --  a1
            (to_signed(integer(cscale*(-1.6850)), cbits),    to_signed(integer(cscale*(-1.6601)), cbits)),
            --  b0                  --  a0
            (to_signed(integer(cscale*0.8425), cbits),    to_signed(integer(cscale*1.0), cbits))
        )
    );

end package;
