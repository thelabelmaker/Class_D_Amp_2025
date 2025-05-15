// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Wed May 14 18:56:56 2025
// Host        : legolas running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_I2S_interconnect_0_0/clk_setup_I2S_interconnect_0_0_sim_netlist.v
// Design      : clk_setup_I2S_interconnect_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tftg256-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "clk_setup_I2S_interconnect_0_0,I2S_interconnect,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "I2S_interconnect,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module clk_setup_I2S_interconnect_0_0
   (CLK,
    RST,
    DI,
    BCK,
    WS,
    L_RDY,
    R_RDY,
    DO_L,
    DO_R);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RST, FREQ_HZ 90315789, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input RST;
  input DI;
  output BCK;
  output WS;
  output L_RDY;
  output R_RDY;
  output [15:0]DO_L;
  output [15:0]DO_R;

  wire BCK;
  wire CLK;
  wire DI;
  wire [15:0]DO_L;
  wire [15:0]DO_R;
  wire L_RDY;
  wire RST;
  wire R_RDY;
  wire WS;

  clk_setup_I2S_interconnect_0_0_I2S_interconnect inst
       (.BCK(BCK),
        .CLK(CLK),
        .DI(DI),
        .DO_L(DO_L),
        .DO_R(DO_R),
        .L_RDY(L_RDY),
        .RST(RST),
        .R_RDY(R_RDY),
        .WS(WS));
endmodule

(* ORIG_REF_NAME = "I2S_CLK_MGR" *) 
module clk_setup_I2S_interconnect_0_0_I2S_CLK_MGR
   (WS,
    BCK,
    L_RDY,
    R_RDY,
    WS_reg_0,
    RST,
    CLK,
    wsd);
  output WS;
  output BCK;
  output L_RDY;
  output R_RDY;
  output WS_reg_0;
  input RST;
  input CLK;
  input wsd;

  wire BCK;
  wire CLK;
  wire FSYNC_L0;
  wire FSYNC_R0;
  wire L_RDY;
  wire RST;
  wire R_RDY;
  wire WS;
  wire WS_reg_0;
  wire clear;
  wire p_0_in;
  wire p_0_in3_in;
  wire \sclk_div[0]_i_3_n_0 ;
  wire \sclk_div_reg[0]_i_1_n_0 ;
  wire \sclk_div_reg[0]_i_1_n_1 ;
  wire \sclk_div_reg[0]_i_1_n_2 ;
  wire \sclk_div_reg[0]_i_1_n_3 ;
  wire \sclk_div_reg[0]_i_1_n_4 ;
  wire \sclk_div_reg[0]_i_1_n_5 ;
  wire \sclk_div_reg[0]_i_1_n_6 ;
  wire \sclk_div_reg[0]_i_1_n_7 ;
  wire \sclk_div_reg[4]_i_1_n_0 ;
  wire \sclk_div_reg[4]_i_1_n_1 ;
  wire \sclk_div_reg[4]_i_1_n_2 ;
  wire \sclk_div_reg[4]_i_1_n_3 ;
  wire \sclk_div_reg[4]_i_1_n_4 ;
  wire \sclk_div_reg[4]_i_1_n_5 ;
  wire \sclk_div_reg[4]_i_1_n_6 ;
  wire \sclk_div_reg[4]_i_1_n_7 ;
  wire \sclk_div_reg[8]_i_1_n_2 ;
  wire \sclk_div_reg[8]_i_1_n_3 ;
  wire \sclk_div_reg[8]_i_1_n_5 ;
  wire \sclk_div_reg[8]_i_1_n_6 ;
  wire \sclk_div_reg[8]_i_1_n_7 ;
  wire \sclk_div_reg_n_0_[0] ;
  wire \sclk_div_reg_n_0_[1] ;
  wire \sclk_div_reg_n_0_[2] ;
  wire \sclk_div_reg_n_0_[3] ;
  wire \sclk_div_reg_n_0_[4] ;
  wire \sclk_div_reg_n_0_[5] ;
  wire \sclk_div_reg_n_0_[6] ;
  wire \sclk_div_reg_n_0_[7] ;
  wire \sclk_div_reg_n_0_[9] ;
  wire wsd;
  wire [3:2]\NLW_sclk_div_reg[8]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_sclk_div_reg[8]_i_1_O_UNCONNECTED ;

  FDRE BCLK_reg
       (.C(CLK),
        .CE(RST),
        .D(\sclk_div_reg_n_0_[5] ),
        .Q(BCK),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h20)) 
    FSYNC_L_i_1
       (.I0(p_0_in3_in),
        .I1(p_0_in),
        .I2(\sclk_div_reg_n_0_[9] ),
        .O(FSYNC_L0));
  FDRE FSYNC_L_reg
       (.C(CLK),
        .CE(RST),
        .D(FSYNC_L0),
        .Q(L_RDY),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h04)) 
    FSYNC_R_i_1
       (.I0(p_0_in),
        .I1(\sclk_div_reg_n_0_[9] ),
        .I2(p_0_in3_in),
        .O(FSYNC_R0));
  FDRE FSYNC_R_reg
       (.C(CLK),
        .CE(RST),
        .D(FSYNC_R0),
        .Q(R_RDY),
        .R(1'b0));
  FDRE WS_reg
       (.C(CLK),
        .CE(RST),
        .D(p_0_in3_in),
        .Q(WS),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \sclk_div[0]_i_2 
       (.I0(RST),
        .O(clear));
  LUT1 #(
    .INIT(2'h1)) 
    \sclk_div[0]_i_3 
       (.I0(\sclk_div_reg_n_0_[0] ),
        .O(\sclk_div[0]_i_3_n_0 ));
  FDCE \sclk_div_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[0]_i_1_n_7 ),
        .Q(\sclk_div_reg_n_0_[0] ));
  CARRY4 \sclk_div_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\sclk_div_reg[0]_i_1_n_0 ,\sclk_div_reg[0]_i_1_n_1 ,\sclk_div_reg[0]_i_1_n_2 ,\sclk_div_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\sclk_div_reg[0]_i_1_n_4 ,\sclk_div_reg[0]_i_1_n_5 ,\sclk_div_reg[0]_i_1_n_6 ,\sclk_div_reg[0]_i_1_n_7 }),
        .S({\sclk_div_reg_n_0_[3] ,\sclk_div_reg_n_0_[2] ,\sclk_div_reg_n_0_[1] ,\sclk_div[0]_i_3_n_0 }));
  FDCE \sclk_div_reg[10] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[8]_i_1_n_5 ),
        .Q(p_0_in3_in));
  FDCE \sclk_div_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[0]_i_1_n_6 ),
        .Q(\sclk_div_reg_n_0_[1] ));
  FDCE \sclk_div_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[0]_i_1_n_5 ),
        .Q(\sclk_div_reg_n_0_[2] ));
  FDCE \sclk_div_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[0]_i_1_n_4 ),
        .Q(\sclk_div_reg_n_0_[3] ));
  FDCE \sclk_div_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[4]_i_1_n_7 ),
        .Q(\sclk_div_reg_n_0_[4] ));
  CARRY4 \sclk_div_reg[4]_i_1 
       (.CI(\sclk_div_reg[0]_i_1_n_0 ),
        .CO({\sclk_div_reg[4]_i_1_n_0 ,\sclk_div_reg[4]_i_1_n_1 ,\sclk_div_reg[4]_i_1_n_2 ,\sclk_div_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sclk_div_reg[4]_i_1_n_4 ,\sclk_div_reg[4]_i_1_n_5 ,\sclk_div_reg[4]_i_1_n_6 ,\sclk_div_reg[4]_i_1_n_7 }),
        .S({\sclk_div_reg_n_0_[7] ,\sclk_div_reg_n_0_[6] ,\sclk_div_reg_n_0_[5] ,\sclk_div_reg_n_0_[4] }));
  FDCE \sclk_div_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[4]_i_1_n_6 ),
        .Q(\sclk_div_reg_n_0_[5] ));
  FDCE \sclk_div_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[4]_i_1_n_5 ),
        .Q(\sclk_div_reg_n_0_[6] ));
  FDCE \sclk_div_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[4]_i_1_n_4 ),
        .Q(\sclk_div_reg_n_0_[7] ));
  FDCE \sclk_div_reg[8] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[8]_i_1_n_7 ),
        .Q(p_0_in));
  CARRY4 \sclk_div_reg[8]_i_1 
       (.CI(\sclk_div_reg[4]_i_1_n_0 ),
        .CO({\NLW_sclk_div_reg[8]_i_1_CO_UNCONNECTED [3:2],\sclk_div_reg[8]_i_1_n_2 ,\sclk_div_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_sclk_div_reg[8]_i_1_O_UNCONNECTED [3],\sclk_div_reg[8]_i_1_n_5 ,\sclk_div_reg[8]_i_1_n_6 ,\sclk_div_reg[8]_i_1_n_7 }),
        .S({1'b0,p_0_in3_in,\sclk_div_reg_n_0_[9] ,p_0_in}));
  FDCE \sclk_div_reg[9] 
       (.C(CLK),
        .CE(1'b1),
        .CLR(clear),
        .D(\sclk_div_reg[8]_i_1_n_6 ),
        .Q(\sclk_div_reg_n_0_[9] ));
  LUT3 #(
    .INIT(8'hB8)) 
    wsd_i_1
       (.I0(WS),
        .I1(RST),
        .I2(wsd),
        .O(WS_reg_0));
endmodule

(* ORIG_REF_NAME = "I2S_interconnect" *) 
module clk_setup_I2S_interconnect_0_0_I2S_interconnect
   (WS,
    BCK,
    L_RDY,
    R_RDY,
    DO_L,
    DO_R,
    RST,
    CLK,
    DI);
  output WS;
  output BCK;
  output L_RDY;
  output R_RDY;
  output [15:0]DO_L;
  output [15:0]DO_R;
  input RST;
  input CLK;
  input DI;

  wire BCK;
  wire CLK;
  wire DI;
  wire [15:0]DO_L;
  wire [15:0]DO_R;
  wire L_RDY;
  wire RST;
  wire R_RDY;
  wire WS;
  wire clk_mgr_n_4;
  wire [1:0]cnt_reg;
  wire \control/_n_0 ;
  wire wsd;

  clk_setup_I2S_interconnect_0_0_I2S_CLK_MGR clk_mgr
       (.BCK(BCK),
        .CLK(CLK),
        .L_RDY(L_RDY),
        .RST(RST),
        .R_RDY(R_RDY),
        .WS(WS),
        .WS_reg_0(clk_mgr_n_4),
        .wsd(wsd));
  clk_setup_I2S_interconnect_0_0_I2S_master control
       (.CLK(BCK),
        .DI(DI),
        .DO_L(DO_L),
        .DO_R(DO_R),
        .Q(cnt_reg),
        .RST(RST),
        .WS(WS),
        .\d_temp_reg[15]_0 (\control/_n_0 ),
        .wsd(wsd),
        .wsd_reg_0(clk_mgr_n_4));
  LUT2 #(
    .INIT(4'h7)) 
    \control/ 
       (.I0(cnt_reg[1]),
        .I1(cnt_reg[0]),
        .O(\control/_n_0 ));
endmodule

(* ORIG_REF_NAME = "I2S_master" *) 
module clk_setup_I2S_interconnect_0_0_I2S_master
   (wsd,
    Q,
    DO_L,
    DO_R,
    wsd_reg_0,
    CLK,
    RST,
    WS,
    DI,
    \d_temp_reg[15]_0 );
  output wsd;
  output [1:0]Q;
  output [15:0]DO_L;
  output [15:0]DO_R;
  input wsd_reg_0;
  input CLK;
  input RST;
  input WS;
  input DI;
  input \d_temp_reg[15]_0 ;

  wire CLK;
  wire DI;
  wire [15:0]DO_L;
  wire DO_L0;
  wire [15:0]DO_R;
  wire DO_R0;
  wire [1:0]Q;
  wire RST;
  wire WS;
  wire \cnt[0]_i_1_n_0 ;
  wire \cnt[1]_i_1_n_0 ;
  wire \cnt[2]_i_1_n_0 ;
  wire \cnt[3]_i_1_n_0 ;
  wire [3:2]cnt_reg;
  wire [15:0]d_temp;
  wire \d_temp[0]_i_1_n_0 ;
  wire \d_temp[10]_i_1_n_0 ;
  wire \d_temp[11]_i_1_n_0 ;
  wire \d_temp[12]_i_1_n_0 ;
  wire \d_temp[12]_i_2_n_0 ;
  wire \d_temp[13]_i_1_n_0 ;
  wire \d_temp[13]_i_2_n_0 ;
  wire \d_temp[14]_i_1_n_0 ;
  wire \d_temp[14]_i_2_n_0 ;
  wire \d_temp[15]_i_1_n_0 ;
  wire \d_temp[1]_i_1_n_0 ;
  wire \d_temp[2]_i_1_n_0 ;
  wire \d_temp[3]_i_1_n_0 ;
  wire \d_temp[4]_i_1_n_0 ;
  wire \d_temp[5]_i_1_n_0 ;
  wire \d_temp[6]_i_1_n_0 ;
  wire \d_temp[7]_i_1_n_0 ;
  wire \d_temp[8]_i_1_n_0 ;
  wire \d_temp[9]_i_1_n_0 ;
  wire \d_temp_reg[15]_0 ;
  wire wsd;
  wire wsd_reg_0;
  wire wsp;
  wire wsp_i_1_n_0;

  LUT3 #(
    .INIT(8'h08)) 
    \DO_L[15]_i_1 
       (.I0(wsp),
        .I1(RST),
        .I2(wsd),
        .O(DO_L0));
  FDRE \DO_L_reg[0] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[0]),
        .Q(DO_L[0]),
        .R(1'b0));
  FDRE \DO_L_reg[10] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[10]),
        .Q(DO_L[10]),
        .R(1'b0));
  FDRE \DO_L_reg[11] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[11]),
        .Q(DO_L[11]),
        .R(1'b0));
  FDRE \DO_L_reg[12] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[12]),
        .Q(DO_L[12]),
        .R(1'b0));
  FDRE \DO_L_reg[13] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[13]),
        .Q(DO_L[13]),
        .R(1'b0));
  FDRE \DO_L_reg[14] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[14]),
        .Q(DO_L[14]),
        .R(1'b0));
  FDRE \DO_L_reg[15] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[15]),
        .Q(DO_L[15]),
        .R(1'b0));
  FDRE \DO_L_reg[1] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[1]),
        .Q(DO_L[1]),
        .R(1'b0));
  FDRE \DO_L_reg[2] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[2]),
        .Q(DO_L[2]),
        .R(1'b0));
  FDRE \DO_L_reg[3] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[3]),
        .Q(DO_L[3]),
        .R(1'b0));
  FDRE \DO_L_reg[4] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[4]),
        .Q(DO_L[4]),
        .R(1'b0));
  FDRE \DO_L_reg[5] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[5]),
        .Q(DO_L[5]),
        .R(1'b0));
  FDRE \DO_L_reg[6] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[6]),
        .Q(DO_L[6]),
        .R(1'b0));
  FDRE \DO_L_reg[7] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[7]),
        .Q(DO_L[7]),
        .R(1'b0));
  FDRE \DO_L_reg[8] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[8]),
        .Q(DO_L[8]),
        .R(1'b0));
  FDRE \DO_L_reg[9] 
       (.C(CLK),
        .CE(DO_L0),
        .D(d_temp[9]),
        .Q(DO_L[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h80)) 
    \DO_R[15]_i_1 
       (.I0(wsp),
        .I1(RST),
        .I2(wsd),
        .O(DO_R0));
  FDRE \DO_R_reg[0] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[0]),
        .Q(DO_R[0]),
        .R(1'b0));
  FDRE \DO_R_reg[10] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[10]),
        .Q(DO_R[10]),
        .R(1'b0));
  FDRE \DO_R_reg[11] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[11]),
        .Q(DO_R[11]),
        .R(1'b0));
  FDRE \DO_R_reg[12] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[12]),
        .Q(DO_R[12]),
        .R(1'b0));
  FDRE \DO_R_reg[13] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[13]),
        .Q(DO_R[13]),
        .R(1'b0));
  FDRE \DO_R_reg[14] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[14]),
        .Q(DO_R[14]),
        .R(1'b0));
  FDRE \DO_R_reg[15] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[15]),
        .Q(DO_R[15]),
        .R(1'b0));
  FDRE \DO_R_reg[1] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[1]),
        .Q(DO_R[1]),
        .R(1'b0));
  FDRE \DO_R_reg[2] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[2]),
        .Q(DO_R[2]),
        .R(1'b0));
  FDRE \DO_R_reg[3] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[3]),
        .Q(DO_R[3]),
        .R(1'b0));
  FDRE \DO_R_reg[4] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[4]),
        .Q(DO_R[4]),
        .R(1'b0));
  FDRE \DO_R_reg[5] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[5]),
        .Q(DO_R[5]),
        .R(1'b0));
  FDRE \DO_R_reg[6] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[6]),
        .Q(DO_R[6]),
        .R(1'b0));
  FDRE \DO_R_reg[7] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[7]),
        .Q(DO_R[7]),
        .R(1'b0));
  FDRE \DO_R_reg[8] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[8]),
        .Q(DO_R[8]),
        .R(1'b0));
  FDRE \DO_R_reg[9] 
       (.C(CLK),
        .CE(DO_R0),
        .D(d_temp[9]),
        .Q(DO_R[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \cnt[0]_i_1 
       (.I0(wsp),
        .I1(Q[0]),
        .O(\cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hEB)) 
    \cnt[1]_i_1 
       (.I0(wsp),
        .I1(Q[0]),
        .I2(Q[1]),
        .O(\cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFEAB)) 
    \cnt[2]_i_1 
       (.I0(wsp),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(cnt_reg[2]),
        .O(\cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFFFEAAAB)) 
    \cnt[3]_i_1 
       (.I0(wsp),
        .I1(cnt_reg[2]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(cnt_reg[3]),
        .O(\cnt[3]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b0)) 
    \cnt_reg[0] 
       (.C(CLK),
        .CE(RST),
        .D(\cnt[0]_i_1_n_0 ),
        .Q(Q[0]),
        .S(1'b0));
  FDSE #(
    .INIT(1'b0)) 
    \cnt_reg[1] 
       (.C(CLK),
        .CE(RST),
        .D(\cnt[1]_i_1_n_0 ),
        .Q(Q[1]),
        .S(1'b0));
  FDSE #(
    .INIT(1'b0)) 
    \cnt_reg[2] 
       (.C(CLK),
        .CE(RST),
        .D(\cnt[2]_i_1_n_0 ),
        .Q(cnt_reg[2]),
        .S(1'b0));
  FDSE #(
    .INIT(1'b0)) 
    \cnt_reg[3] 
       (.C(CLK),
        .CE(RST),
        .D(\cnt[3]_i_1_n_0 ),
        .Q(cnt_reg[3]),
        .S(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFB00000008)) 
    \d_temp[0]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[12]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[0]),
        .O(\d_temp[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \d_temp[10]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[14]_i_2_n_0 ),
        .I3(cnt_reg[2]),
        .I4(cnt_reg[3]),
        .I5(d_temp[10]),
        .O(\d_temp[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \d_temp[11]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp_reg[15]_0 ),
        .I3(cnt_reg[2]),
        .I4(cnt_reg[3]),
        .I5(d_temp[11]),
        .O(\d_temp[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \d_temp[12]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[12]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[12]),
        .O(\d_temp[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \d_temp[12]_i_2 
       (.I0(Q[1]),
        .I1(Q[0]),
        .O(\d_temp[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \d_temp[13]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[13]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[13]),
        .O(\d_temp[13]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \d_temp[13]_i_2 
       (.I0(Q[1]),
        .I1(Q[0]),
        .O(\d_temp[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \d_temp[14]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[14]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[14]),
        .O(\d_temp[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \d_temp[14]_i_2 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\d_temp[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \d_temp[15]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp_reg[15]_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[15]),
        .O(\d_temp[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFB00000008)) 
    \d_temp[1]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[13]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[1]),
        .O(\d_temp[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFB00000008)) 
    \d_temp[2]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[14]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[2]),
        .O(\d_temp[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFB00000008)) 
    \d_temp[3]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp_reg[15]_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[3]),
        .O(\d_temp[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \d_temp[4]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[12]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[4]),
        .O(\d_temp[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \d_temp[5]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[13]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[5]),
        .O(\d_temp[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \d_temp[6]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[14]_i_2_n_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[6]),
        .O(\d_temp[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \d_temp[7]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp_reg[15]_0 ),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[2]),
        .I5(d_temp[7]),
        .O(\d_temp[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \d_temp[8]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[12]_i_2_n_0 ),
        .I3(cnt_reg[2]),
        .I4(cnt_reg[3]),
        .I5(d_temp[8]),
        .O(\d_temp[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \d_temp[9]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\d_temp[13]_i_2_n_0 ),
        .I3(cnt_reg[2]),
        .I4(cnt_reg[3]),
        .I5(d_temp[9]),
        .O(\d_temp[9]_i_1_n_0 ));
  FDRE \d_temp_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[0]_i_1_n_0 ),
        .Q(d_temp[0]),
        .R(1'b0));
  FDRE \d_temp_reg[10] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[10]_i_1_n_0 ),
        .Q(d_temp[10]),
        .R(1'b0));
  FDRE \d_temp_reg[11] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[11]_i_1_n_0 ),
        .Q(d_temp[11]),
        .R(1'b0));
  FDRE \d_temp_reg[12] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[12]_i_1_n_0 ),
        .Q(d_temp[12]),
        .R(1'b0));
  FDRE \d_temp_reg[13] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[13]_i_1_n_0 ),
        .Q(d_temp[13]),
        .R(1'b0));
  FDRE \d_temp_reg[14] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[14]_i_1_n_0 ),
        .Q(d_temp[14]),
        .R(1'b0));
  FDRE \d_temp_reg[15] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[15]_i_1_n_0 ),
        .Q(d_temp[15]),
        .R(1'b0));
  FDRE \d_temp_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[1]_i_1_n_0 ),
        .Q(d_temp[1]),
        .R(1'b0));
  FDRE \d_temp_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[2]_i_1_n_0 ),
        .Q(d_temp[2]),
        .R(1'b0));
  FDRE \d_temp_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[3]_i_1_n_0 ),
        .Q(d_temp[3]),
        .R(1'b0));
  FDRE \d_temp_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[4]_i_1_n_0 ),
        .Q(d_temp[4]),
        .R(1'b0));
  FDRE \d_temp_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[5]_i_1_n_0 ),
        .Q(d_temp[5]),
        .R(1'b0));
  FDRE \d_temp_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[6]_i_1_n_0 ),
        .Q(d_temp[6]),
        .R(1'b0));
  FDRE \d_temp_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[7]_i_1_n_0 ),
        .Q(d_temp[7]),
        .R(1'b0));
  FDRE \d_temp_reg[8] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[8]_i_1_n_0 ),
        .Q(d_temp[8]),
        .R(1'b0));
  FDRE \d_temp_reg[9] 
       (.C(CLK),
        .CE(1'b1),
        .D(\d_temp[9]_i_1_n_0 ),
        .Q(d_temp[9]),
        .R(1'b0));
  FDRE wsd_reg
       (.C(CLK),
        .CE(1'b1),
        .D(wsd_reg_0),
        .Q(wsd),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h6F60)) 
    wsp_i_1
       (.I0(WS),
        .I1(wsd),
        .I2(RST),
        .I3(wsp),
        .O(wsp_i_1_n_0));
  FDRE wsp_reg
       (.C(CLK),
        .CE(1'b1),
        .D(wsp_i_1_n_0),
        .Q(wsp),
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
