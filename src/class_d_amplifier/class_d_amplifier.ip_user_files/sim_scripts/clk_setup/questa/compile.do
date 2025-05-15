vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv "+incdir+../../../../class_d_amplifier.gen/sources_1/bd/clk_setup/ipshared/3cbc" \
"/home/ethan/Xilinx_Vivado/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93  \
"/home/ethan/Xilinx_Vivado/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../class_d_amplifier.gen/sources_1/bd/clk_setup/ipshared/3cbc" \
"../../../bd/clk_setup/ip/clk_setup_clk_wiz_0_0/clk_setup_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/clk_setup/ip/clk_setup_clk_wiz_0_0/clk_setup_clk_wiz_0_0.v" \
"../../../bd/clk_setup/ip/clk_setup_I2S_interconnect_0_0/sim/clk_setup_I2S_interconnect_0_0.v" \
"../../../bd/clk_setup/ip/clk_setup_PWM_output_0_1/sim/clk_setup_PWM_output_0_1.v" \
"../../../bd/clk_setup/ip/clk_setup_PWM_output_0_2/sim/clk_setup_PWM_output_0_2.v" \
"../../../bd/clk_setup/ip/clk_setup_Quantizer_Interconne_0_0/sim/clk_setup_Quantizer_Interconne_0_0.v" \
"../../../bd/clk_setup/sim/clk_setup.v" \

vlog -work xil_defaultlib \
"glbl.v"

