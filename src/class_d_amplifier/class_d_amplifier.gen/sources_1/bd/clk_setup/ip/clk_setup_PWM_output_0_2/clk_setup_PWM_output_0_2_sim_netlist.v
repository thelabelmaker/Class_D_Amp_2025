// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Wed May 14 18:56:55 2025
// Host        : legolas running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_PWM_output_0_2/clk_setup_PWM_output_0_2_sim_netlist.v
// Design      : clk_setup_PWM_output_0_2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tftg256-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "clk_setup_PWM_output_0_2,PWM_output,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "PWM_output,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module clk_setup_PWM_output_0_2
   (SCLK,
    DCLK,
    DIN,
    EN,
    RST);
  input SCLK;
  input DCLK;
  input [4:0]DIN;
  output EN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input RST;

  wire DCLK;
  wire [4:0]DIN;
  wire EN;
  wire RST;
  wire SCLK;

  clk_setup_PWM_output_0_2_PWM_output inst
       (.DCLK(DCLK),
        .DIN(DIN),
        .EN(EN),
        .RST(RST),
        .SCLK(SCLK));
endmodule

(* ORIG_REF_NAME = "PWM_output" *) 
module clk_setup_PWM_output_0_2_PWM_output
   (EN,
    DCLK,
    SCLK,
    DIN,
    RST);
  output EN;
  input DCLK;
  input SCLK;
  input [4:0]DIN;
  input RST;

  wire DCLK;
  wire DCLKD;
  wire DCLKD_i_1_n_0;
  wire [4:0]DIN;
  wire EN;
  wire EN_i_1_n_0;
  wire EN_i_2_n_0;
  wire EN_i_3_n_0;
  wire RST;
  wire SCLK;
  wire clear;
  wire \cntr[0]_i_1_n_0 ;
  wire \cntr[1]_i_1_n_0 ;
  wire \cntr[2]_i_1_n_0 ;
  wire \cntr[3]_i_1_n_0 ;
  wire \cntr[4]_i_1_n_0 ;
  wire [4:0]cntr_reg;
  wire [4:0]dsync;
  wire dsync0;
  wire dsync1__1;
  wire [4:4]p_0_in;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    DCLKD_i_1
       (.I0(DCLK),
        .I1(RST),
        .I2(DCLKD),
        .O(DCLKD_i_1_n_0));
  FDRE DCLKD_reg
       (.C(SCLK),
        .CE(1'b1),
        .D(DCLKD_i_1_n_0),
        .Q(DCLKD),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hBFBB8088)) 
    EN_i_1
       (.I0(EN_i_2_n_0),
        .I1(RST),
        .I2(DCLKD),
        .I3(DCLK),
        .I4(EN),
        .O(EN_i_1_n_0));
  LUT5 #(
    .INIT(32'hB2FF00B2)) 
    EN_i_2
       (.I0(EN_i_3_n_0),
        .I1(cntr_reg[3]),
        .I2(dsync[3]),
        .I3(cntr_reg[4]),
        .I4(dsync[4]),
        .O(EN_i_2_n_0));
  LUT6 #(
    .INIT(64'h2F02FFFF00002F02)) 
    EN_i_3
       (.I0(dsync[0]),
        .I1(cntr_reg[0]),
        .I2(cntr_reg[1]),
        .I3(dsync[1]),
        .I4(cntr_reg[2]),
        .I5(dsync[2]),
        .O(EN_i_3_n_0));
  FDRE EN_reg
       (.C(SCLK),
        .CE(1'b1),
        .D(EN_i_1_n_0),
        .Q(EN),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h45)) 
    \cntr[0]_i_1 
       (.I0(cntr_reg[0]),
        .I1(DCLKD),
        .I2(DCLK),
        .O(\cntr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6066)) 
    \cntr[1]_i_1 
       (.I0(cntr_reg[1]),
        .I1(cntr_reg[0]),
        .I2(DCLKD),
        .I3(DCLK),
        .O(\cntr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h6A006A6A)) 
    \cntr[2]_i_1 
       (.I0(cntr_reg[2]),
        .I1(cntr_reg[1]),
        .I2(cntr_reg[0]),
        .I3(DCLKD),
        .I4(DCLK),
        .O(\cntr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAA00006AAA6AAA)) 
    \cntr[3]_i_1 
       (.I0(cntr_reg[3]),
        .I1(cntr_reg[2]),
        .I2(cntr_reg[0]),
        .I3(cntr_reg[1]),
        .I4(DCLKD),
        .I5(DCLK),
        .O(\cntr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000006AAAAAAA)) 
    \cntr[4]_i_1 
       (.I0(cntr_reg[4]),
        .I1(cntr_reg[3]),
        .I2(cntr_reg[1]),
        .I3(cntr_reg[0]),
        .I4(cntr_reg[2]),
        .I5(dsync1__1),
        .O(\cntr[4]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \cntr[4]_i_2 
       (.I0(RST),
        .O(clear));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \cntr[4]_i_3 
       (.I0(DCLK),
        .I1(DCLKD),
        .O(dsync1__1));
  FDCE \cntr_reg[0] 
       (.C(SCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\cntr[0]_i_1_n_0 ),
        .Q(cntr_reg[0]));
  FDCE \cntr_reg[1] 
       (.C(SCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\cntr[1]_i_1_n_0 ),
        .Q(cntr_reg[1]));
  FDCE \cntr_reg[2] 
       (.C(SCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\cntr[2]_i_1_n_0 ),
        .Q(cntr_reg[2]));
  FDCE \cntr_reg[3] 
       (.C(SCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\cntr[3]_i_1_n_0 ),
        .Q(cntr_reg[3]));
  FDCE \cntr_reg[4] 
       (.C(SCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\cntr[4]_i_1_n_0 ),
        .Q(cntr_reg[4]));
  LUT3 #(
    .INIT(8'h20)) 
    \dsync[4]_i_1 
       (.I0(RST),
        .I1(DCLKD),
        .I2(DCLK),
        .O(dsync0));
  LUT1 #(
    .INIT(2'h1)) 
    \dsync[4]_i_2 
       (.I0(DIN[4]),
        .O(p_0_in));
  FDRE \dsync_reg[0] 
       (.C(SCLK),
        .CE(dsync0),
        .D(DIN[0]),
        .Q(dsync[0]),
        .R(1'b0));
  FDRE \dsync_reg[1] 
       (.C(SCLK),
        .CE(dsync0),
        .D(DIN[1]),
        .Q(dsync[1]),
        .R(1'b0));
  FDRE \dsync_reg[2] 
       (.C(SCLK),
        .CE(dsync0),
        .D(DIN[2]),
        .Q(dsync[2]),
        .R(1'b0));
  FDRE \dsync_reg[3] 
       (.C(SCLK),
        .CE(dsync0),
        .D(DIN[3]),
        .Q(dsync[3]),
        .R(1'b0));
  FDRE \dsync_reg[4] 
       (.C(SCLK),
        .CE(dsync0),
        .D(p_0_in),
        .Q(dsync[4]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
