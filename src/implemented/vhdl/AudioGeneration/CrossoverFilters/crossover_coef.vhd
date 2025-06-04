library work;
library IEEE;
    use IEEE.STD_LOGIC_1164.all;
    use ieee.numeric_std.all;
    use work.filter_constants.all;

package crossover_coef is
    constant nbiquads: integer := 2;
    type crossover_coef_arr_t is array(0 to (nbiquads-1)) of biquad_coef;

    constant cscale: real := 2.0**(cbits-1);

    constant lpf_crossover_coef_arr : crossover_coef_arr_t := 
    (
        (   --  1st biquad coefficents
            --  b2                  --  a2
            (signed(cscale*0.0125),    signed(cscale*0.710)),
            --  b1                  --  a1
            (signed(cscale*0.0250),    signed(cscale*(-1.6601))),
            --  b0                  --  a0
            (signed(cscale*0.0125),    signed(cscale*1.0))
        ),

        (   --  2nd biquad coefficents
            --  b2                  --  a2
            (signed(cscale*0.0125),    signed(cscale*0.710)),
            --  b1                  --  a1
            (signed(cscale*0.0250),    signed(cscale*(-1.6601))),
            --  b0                  --  a0
            (signed(cscale*0.0125),    signed(cscale*1.0))
        )
    );

    constant hpf_crossover_coef_arr : crossover_coef_arr_t := 
    (
        (   --  1st biquad coefficents
            --  b2                  --  a2
            (signed(cscale*0.8425),    signed(cscale*0.710)),
            --  b1                  --  a1
            (signed(cscale*(-1.6850)),    signed(cscale*(-1.6601))),
            --  b0                  --  a0
            (signed(cscale*0.8425),    signed(cscale*1.0))
        ),

        (   --  2nd biquad coefficents
            --  b2                  --  a2
            (signed(cscale*0.8425),    signed(cscale*0.710)),
            --  b1                  --  a1
            (signed(cscale*(-1.6850)),    signed(cscale*(-1.6601))),
            --  b0                  --  a0
            (signed(cscale*0.8425),    signed(cscale*1.0))
        )
    );

end package;
