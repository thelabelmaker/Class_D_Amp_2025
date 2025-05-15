// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Wed May 14 18:56:55 2025
// Host        : legolas running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_PWM_output_0_2/clk_setup_PWM_output_0_2_stub.v
// Design      : clk_setup_PWM_output_0_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tftg256-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "clk_setup_PWM_output_0_2,PWM_output,{}" *) (* CORE_GENERATION_INFO = "clk_setup_PWM_output_0_2,PWM_output,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=PWM_output,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "PWM_output,Vivado 2024.2" *) 
module clk_setup_PWM_output_0_2(SCLK, DCLK, DIN, EN, RST)
/* synthesis syn_black_box black_box_pad_pin="DCLK,DIN[4:0],EN,RST" */
/* synthesis syn_force_seq_prim="SCLK" */;
  input SCLK /* synthesis syn_isclock = 1 */;
  input DCLK;
  input [4:0]DIN;
  output EN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input RST;
endmodule
