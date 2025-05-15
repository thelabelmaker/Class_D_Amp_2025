transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+../../../../class_d_amplifier.gen/sources_1/bd/clk_setup/ipshared/3cbc" -l xpm -l xil_defaultlib \
"/home/ethan/Xilinx_Vivado/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  -incr \
"/home/ethan/Xilinx_Vivado/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../class_d_amplifier.gen/sources_1/bd/clk_setup/ipshared/3cbc" -l xpm -l xil_defaultlib \
"../../../bd/clk_setup/ip/clk_setup_clk_wiz_0_0/clk_setup_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/clk_setup/ip/clk_setup_clk_wiz_0_0/clk_setup_clk_wiz_0_0.v" \
"../../../bd/clk_setup/ip/clk_setup_I2S_interconnect_0_0/sim/clk_setup_I2S_interconnect_0_0.v" \
"../../../bd/clk_setup/ip/clk_setup_PWM_output_0_1/sim/clk_setup_PWM_output_0_1.v" \
"../../../bd/clk_setup/ip/clk_setup_PWM_output_0_2/sim/clk_setup_PWM_output_0_2.v" \
"../../../bd/clk_setup/ip/clk_setup_Quantizer_Interconne_0_0/sim/clk_setup_Quantizer_Interconne_0_0.v" \
"../../../bd/clk_setup/sim/clk_setup.v" \

vlog -work xil_defaultlib \
"glbl.v"

