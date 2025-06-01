cd build

ghdl -a --std=08 ../../I2S_constants.vhd
ghdl -a --std=08 ../../CLK_MGR.vhd
ghdl -a --std=08 ../../I2S_master.vhd
ghdl -a --std=08 ../../I2S_interconnect.vhd
#ghdl -a --std=08 ../../sigma_delta.vhd
ghdl -a --std=08 ../../sigma_delta_simulation.vhd
ghdl -a --std=08 ../../PWM_output.vhd
ghdl -a --std=08 ../../filters.vhd
ghdl -a --std=08 ../../amp_testbench.vhd

#ghdl -e  I2S_CLK_MGR
#ghdl -e  I2S_
#ghdl -e  SigmaDelta


#ghdl -a  ../../pwm_audio.vhd
ghdl -e --std=08 -O2 amp_testbench

ghdl -r --std=08 amp_testbench --wave=amp_testbench.ghw

cd ..
