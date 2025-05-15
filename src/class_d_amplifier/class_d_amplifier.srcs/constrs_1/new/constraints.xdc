create_generated_clock -name clk_setup_i/CLK_MGR_0/inst/BCLK -source [get_pins clk_setup_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT0] -divide_by 32 [get_pins clk_setup_i/CLK_MGR_0/inst/BCLK_reg/Q]
create_generated_clock -name clk_setup_i/CLK_MGR_0/inst/WS -source [get_pins clk_setup_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT0] -divide_by 1024 [get_pins clk_setup_i/CLK_MGR_0/inst/WS_reg/Q]
create_clock -period 651.003 -name VIRTUAL_clk_setup_i/CLK_MGR_0/inst/BCLK -waveform {0.000 325.501}
create_clock -period 20.344 -name VIRTUAL_SYSCLK_clk_setup_clk_wiz_0_0 -waveform {0.000 10.172}

set_property IOSTANDARD LVCMOS33 [get_ports CLK]

set_property IOSTANDARD LVCMOS33 [get_ports EN]
set_property IOSTANDARD LVCMOS33 [get_ports DI]
set_property PACKAGE_PIN N14 [get_ports CLK]
set_property PACKAGE_PIN P4 [get_ports DI]

set_property IOSTANDARD LVCMOS33 [get_ports BCK]
set_property IOSTANDARD LVCMOS33 [get_ports WS]
set_property PACKAGE_PIN N3 [get_ports BCK]
set_property PACKAGE_PIN N1 [get_ports WS]

set_property PACKAGE_PIN P6 [get_ports RST]
set_property IOSTANDARD LVCMOS33 [get_ports RST]


set_property DRIVE 12 [get_ports EN]
set_property SLEW SLOW [get_ports EN]


set_property PACKAGE_PIN T4 [get_ports EN]

set_property IOSTANDARD LVCMOS33 [get_ports EN_L]
set_property PACKAGE_PIN M2 [get_ports EN_L]
