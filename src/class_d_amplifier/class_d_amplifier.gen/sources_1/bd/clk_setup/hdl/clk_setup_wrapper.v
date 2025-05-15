//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Wed May 14 18:56:28 2025
//Host        : legolas running 64-bit unknown
//Command     : generate_target clk_setup_wrapper.bd
//Design      : clk_setup_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module clk_setup_wrapper
   (BCK,
    CLK,
    DI,
    EN_L,
    RST,
    WS);
  output BCK;
  input CLK;
  input DI;
  output EN_L;
  input RST;
  output WS;

  wire BCK;
  wire CLK;
  wire DI;
  wire EN_L;
  wire RST;
  wire WS;

  clk_setup clk_setup_i
       (.BCK(BCK),
        .CLK(CLK),
        .DI(DI),
        .EN_L(EN_L),
        .RST(RST),
        .WS(WS));
endmodule
