-------------------------------------------------------------------------------
--
--  crossover_coef.vhd
--
--  this file contains the coefficents which define the behavior of the biquad
--  filters used to implement the digital crossover.
--  
--  Revision History:
--    03 Jun 25  Ethan Labelson     inital revision
--    04 Jun 25  Ethan Labelson     constants for inital biquad
--    07 Jun 25  Ethan Labelson     modified constants for testing with PCB
--    11 Jun 25  Ethan Labelson     working 2 kHz crossover tested
--    12 Jun 25  Ethan Labelson     modified for demo day (5 kHz crossover)
--    19 Jun 25  Ethan Labelson     updated comments and cleaned code
-------------------------------------------------------------------------------

library work; --  import external filter info
    use work.filter_constants.all;

library ieee; --  import needed standard libs
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

    --  package crossover_coef 
    --      crossover_coef defines the coefficents for the biquad filters.
    --      each biquad has 6 different coefficents which define the 
    --      behavior of the filter. this package centralizes all of the biquad
    --      coefficents so that they can be easily changed and accessed.

package crossover_coef is
    --  define number of biquads for each component
    constant nbiquads : integer := 2;

    --  create array type of biquad coefficents
    type crossover_coef_arr_t is array (0 to (nbiquads - 1)) of biquad_coef;

    --  coefficents in Q 1.(cbits-1)
    --  cbits (bits to use for consts) is defined in filter_constants.vhd
    --      as of demo cbits is set to 18 bc FPGA dsp slices are 25x18 mult
    --  this gives numbers in range -2 and 2 
    --  scale factor of cbits-2 bc 1 sign bit and 1 bit left of decimal
    constant cscale : real := 2.0 ** (cbits - 2);

    --  as of demo setup is 5 kHz crossover with 192 kHz sample rate. 
    --  can be modified for other crossover frequencies and sample rates using
    --  the coefficent spreadsheet (in computation subdir of the repo).
    --  the spreadsheet contains a useful diagram for visiualising the biquad
    --  and where the coefficents are used in the filter.

    --  define coefficents for low pass section of crossover
    constant lpf_crossover_coef_arr : crossover_coef_arr_t := (
        (--  1st biquad coefficents
            (
                to_signed(integer(cscale * 0.005742849731856), cbits), --  b2
                to_signed(integer(cscale * (- 0.719845029718650)), cbits) --  a2
            ),
            (
                to_signed(integer(cscale * 0.011485699463712), cbits), --  b1
                to_signed(integer(cscale * (1.696873630791230)), cbits) --  a1
            ),
            (
                to_signed(integer(cscale * 0.005742849731856), cbits), --  b0
                to_signed(integer(cscale * 1.0), cbits) -- a0
            )
        ),
        (--  2nd biquad coefficents
            (
                to_signed(integer(cscale * 0.000003844633507), cbits), --  b2
                to_signed(integer(cscale * (- 0.994461789066686)), cbits) --  a2
            ),
            (
                to_signed(integer(cscale * 0.000007689267014), cbits), --  b1
                to_signed(integer(cscale * (1.994446410532660)), cbits) --  a1
            ),
            (
                to_signed(integer(cscale * 0.000003844633507), cbits), --  b0
                to_signed(integer(cscale * 1.0), cbits) --  a0
            )
        )
    );

    constant hpf_crossover_coef_arr : crossover_coef_arr_t := (
        (--  1st biquad coefficents
            (
                to_signed(integer(cscale * 0.854179665127469), cbits), --  b2
                to_signed(integer(cscale * (- 0.719845029718650)), cbits) -- a2
            ),
            (
                to_signed(integer(cscale * (- 1.70835933025494)), cbits), --  b1
                to_signed(integer(cscale * (1.696873630791230)), cbits) -- a1
            ),
            (
                to_signed(integer(cscale * 0.854179665127469), cbits), --b0
                to_signed(integer(cscale * 1.0), cbits) --  a0
            )
        ),
        (--  2nd biquad coefficents
            (
                to_signed(integer(cscale * 0.854179665127469), cbits), --  b2
                to_signed(integer(cscale * (- 0.719845029718650)), cbits) --  a2
            ),
            (
                to_signed(integer(cscale * (- 1.70835933025494)), cbits), --  b1
                to_signed(integer(cscale * (1.696873630791230)), cbits) --  a1
            ),
            (
                to_signed(integer(cscale * 0.854179665127469), cbits), --  b0
                to_signed(integer(cscale * 1.0), cbits) --  a0
            )
        )
    );

end package;

--  old testing coefficents for "turning off" filters

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
