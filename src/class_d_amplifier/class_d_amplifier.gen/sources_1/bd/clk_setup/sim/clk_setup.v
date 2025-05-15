//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Wed May 14 18:56:28 2025
//Host        : legolas running 64-bit unknown
//Command     : generate_target clk_setup.bd
//Design      : clk_setup
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "clk_setup,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=clk_setup,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=4,numPkgbdBlks=0,bdsource=USER,da_board_cnt=1,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "clk_setup.hwdef" *) 
module clk_setup
   (BCK,
    CLK,
    DI,
    EN_L,
    RST,
    WS);
  output BCK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN clk_setup_CLK, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.DI DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.DI, LAYERED_METADATA undef" *) input DI;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.EN_L DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.EN_L, LAYERED_METADATA undef" *) output EN_L;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input RST;
  output WS;

  wire BCK;
  wire CLK;
  wire DI;
  wire EN_L;
  wire [15:0]I2S_interconnect_0_DO_L;
  wire [15:0]I2S_interconnect_0_DO_R;
  wire I2S_interconnect_0_L_RDY;
  wire I2S_interconnect_0_R_RDY;
  wire [4:0]Quantizer_Interconne_0_DO_L;
  wire [4:0]Quantizer_Interconne_0_DO_R;
  wire Quantizer_Interconne_0_L_RDY;
  wire Quantizer_Interconne_0_R_RDY;
  wire RST;
  wire WS;
  wire clk_wiz_0_SYSCLK;

  clk_setup_I2S_interconnect_0_0 I2S_interconnect_0
       (.BCK(BCK),
        .CLK(clk_wiz_0_SYSCLK),
        .DI(DI),
        .DO_L(I2S_interconnect_0_DO_L),
        .DO_R(I2S_interconnect_0_DO_R),
        .L_RDY(I2S_interconnect_0_L_RDY),
        .RST(RST),
        .R_RDY(I2S_interconnect_0_R_RDY),
        .WS(WS));
  clk_setup_PWM_output_0_1 PWM_output_0
       (.DCLK(Quantizer_Interconne_0_L_RDY),
        .DIN(Quantizer_Interconne_0_DO_L),
        .EN(EN_L),
        .RST(RST),
        .SCLK(clk_wiz_0_SYSCLK));
  clk_setup_PWM_output_0_2 PWM_output_1
       (.DCLK(Quantizer_Interconne_0_R_RDY),
        .DIN(Quantizer_Interconne_0_DO_R),
        .RST(RST),
        .SCLK(clk_wiz_0_SYSCLK));
  clk_setup_Quantizer_Interconne_0_0 Quantizer_Interconne_0
       (.CLK(clk_wiz_0_SYSCLK),
        .DI_L(I2S_interconnect_0_DO_L),
        .DI_R(I2S_interconnect_0_DO_R),
        .DO_L(Quantizer_Interconne_0_DO_L),
        .DO_R(Quantizer_Interconne_0_DO_R),
        .L_RDY(Quantizer_Interconne_0_L_RDY),
        .L_READ(I2S_interconnect_0_L_RDY),
        .RST(RST),
        .R_RDY(Quantizer_Interconne_0_R_RDY),
        .R_READ(I2S_interconnect_0_R_RDY));
  clk_setup_clk_wiz_0_0 clk_wiz_0
       (.SYSCLK(clk_wiz_0_SYSCLK),
        .clk_in1(CLK),
        .resetn(RST));
endmodule
