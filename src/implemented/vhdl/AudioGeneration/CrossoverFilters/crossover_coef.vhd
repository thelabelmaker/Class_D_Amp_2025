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


    --     constant lpf_crossover_coef_arr : crossover_coef_arr_t := 
    -- (
    --     (   --  1st biquad coefficents
    --         --  b2                  --  a2
    --         (to_signed(integer(cscale*0.995365506179770), cbits),    to_signed(integer(cscale*(-0.995763841495187)), cbits)),
    --         --  b1                  --  a1
    --         (to_signed(integer(cscale*(-1.995752995227580)), cbits),    to_signed(integer(cscale*(1.995754849910680)), cbits)),
    --         --  b0                  --  a0
    --         (to_signed(integer(cscale*1.000400189998520), cbits),    to_signed(integer(cscale*1.0), cbits))
    --     ),

    --     (   --  2nd biquad coefficents
    --         --  b2                  --  a2
    --         (to_signed(integer(cscale*(-0.164625711300000)), cbits),    to_signed(integer(cscale*((-0.734553443600000))), cbits)),
    --         --  b1                  --  a1
    --         (to_signed(integer(cscale*(-0.755552100000000)), cbits),    to_signed(integer(cscale*(1.732765500000000)), cbits)),
    --         --  b0                  --  a0
    --         (to_signed(integer(cscale*1.0), cbits),    to_signed(integer(cscale*1.0), cbits))
    --     )
    -- );

    constant lpf_crossover_coef_arr : crossover_coef_arr_t := 
    (
        (   --  1st biquad coefficents
            --  b2                  --  a2
            (to_signed(integer(cscale*0.001023217638395), cbits),    to_signed(integer(cscale*(-0.911594496458170)), cbits)),
            --  b1                  --  a1
            (to_signed(integer(cscale*0.002046435276790), cbits),    to_signed(integer(cscale*(1.907501625904590)), cbits)),
            --  b0                  --  a0
            (to_signed(integer(cscale*0.001023217638395), cbits),    to_signed(integer(cscale*1.0), cbits))
        ),
        (   --  2nd biquad coefficents
            --  b2                  --  a2
            (to_signed(integer(cscale*0.001023217638395), cbits),    to_signed(integer(cscale*(-0.911594496458170)), cbits)),
            --  b1                  --  a1
            (to_signed(integer(cscale*0.002046435276790), cbits),    to_signed(integer(cscale*(1.907501625904590)), cbits)),
            --  b0                  --  a0
            (to_signed(integer(cscale*0.001023217638395), cbits),    to_signed(integer(cscale*1.0), cbits))
        )

        
    );
    -- constant lpf_crossover_coef_arr : crossover_coef_arr_t := 
    -- (
    --     (   --  1st biquad coefficents
    --         --  b2                  --  a2
    --         (to_signed(integer(cscale*0.0), cbits),    to_signed(integer(cscale*(0.0)), cbits)),
    --         --  b1                  --  a1
    --         (to_signed(integer(cscale*(0.0)), cbits),    to_signed(integer(cscale*(0.0)), cbits)),
    --         --  b0                  --  a0
    --         (to_signed(integer(cscale*1.0), cbits),    to_signed(integer(cscale*1.0), cbits))
    --     ),

    --     (   --  1st biquad coefficents
    --         --  b2                  --  a2
    --         (to_signed(integer(cscale*0.0), cbits),    to_signed(integer(cscale*(0.0)), cbits)),
    --         --  b1                  --  a1
    --         (to_signed(integer(cscale*(0.0)), cbits),    to_signed(integer(cscale*(0.0)), cbits)),
    --         --  b0                  --  a0
    --         (to_signed(integer(cscale*1.0), cbits),    to_signed(integer(cscale*1.0), cbits))
    --     )
    -- );

    constant hpf_crossover_coef_arr : crossover_coef_arr_t := 
    (
        (   --  1st biquad coefficents
            --  b2                  --  a2
            (to_signed(integer(cscale*0.954774030590690), cbits),    to_signed(integer(cscale*(-0.911594496458170)), cbits)),
            --  b1                  --  a1
            (to_signed(integer(cscale*(-1.909548061181380)), cbits),    to_signed(integer(cscale*(1.907501625904590)), cbits)),
            --  b0                  --  a0
            (to_signed(integer(cscale*0.954774030590690), cbits),    to_signed(integer(cscale*1.0), cbits))
        ),

        (   --  2nd biquad coefficents
            --  b2                  --  a2
            (to_signed(integer(cscale*0.954774030590690), cbits),    to_signed(integer(cscale*(-0.911594496458170)), cbits)),
            --  b1                  --  a1
            (to_signed(integer(cscale*(-1.909548061181380)), cbits),    to_signed(integer(cscale*(1.907501625904590)), cbits)),
            --  b0                  --  a0
            (to_signed(integer(cscale*0.954774030590690), cbits),    to_signed(integer(cscale*1.0), cbits))
        )

    );

    -- constant hpf_crossover_coef_arr : crossover_coef_arr_t := 
    -- (
    --     (   --  1st biquad coefficents
    --         --  b2                  --  a2
    --         (to_signed(integer(cscale*0.0), cbits),    to_signed(integer(cscale*(0.0)), cbits)),
    --         --  b1                  --  a1
    --         (to_signed(integer(cscale*(0.0)), cbits),    to_signed(integer(cscale*(0.0)), cbits)),
    --         --  b0                  --  a0
    --         (to_signed(integer(cscale*1.0), cbits),    to_signed(integer(cscale*1.0), cbits))
    --     ),

    --     (   --  1st biquad coefficents
    --         --  b2                  --  a2
    --         (to_signed(integer(cscale*0.0), cbits),    to_signed(integer(cscale*(0.0)), cbits)),
    --         --  b1                  --  a1
    --         (to_signed(integer(cscale*(0.0)), cbits),    to_signed(integer(cscale*(0.0)), cbits)),
    --         --  b0                  --  a0
    --         (to_signed(integer(cscale*1.0), cbits),    to_signed(integer(cscale*1.0), cbits))
    --     )
    -- );

end package;
