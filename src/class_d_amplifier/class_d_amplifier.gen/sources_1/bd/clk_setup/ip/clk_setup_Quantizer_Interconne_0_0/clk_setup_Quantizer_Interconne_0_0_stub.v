// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Wed May 14 18:42:41 2025
// Host        : legolas running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_Quantizer_Interconne_0_0/clk_setup_Quantizer_Interconne_0_0_stub.v
// Design      : clk_setup_Quantizer_Interconne_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tftg256-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "clk_setup_Quantizer_Interconne_0_0,Quantizer_Interconnect,{}" *) (* CORE_GENERATION_INFO = "clk_setup_Quantizer_Interconne_0_0,Quantizer_Interconnect,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=Quantizer_Interconnect,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "Quantizer_Interconnect,Vivado 2024.2" *) 
module clk_setup_Quantizer_Interconne_0_0(L_READ, R_READ, DI_L, DI_R, CLK, RST, L_RDY, R_RDY, DO_L, 
  DO_R)
/* synthesis syn_black_box black_box_pad_pin="L_READ,R_READ,DI_L[15:0],DI_R[15:0],CLK,RST,L_RDY,R_RDY,DO_L[4:0],DO_R[4:0]" */;
  input L_READ;
  input R_READ;
  input [15:0]DI_L;
  input [15:0]DI_R;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RST, FREQ_HZ 90315789, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input RST;
  output L_RDY;
  output R_RDY;
  output [4:0]DO_L;
  output [4:0]DO_R;
endmodule
