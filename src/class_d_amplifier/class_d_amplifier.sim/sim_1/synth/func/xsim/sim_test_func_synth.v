// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Tue Apr 29 10:51:13 2025
// Host        : legolas running 64-bit unknown
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.sim/sim_1/synth/func/xsim/sim_test_func_synth.v
// Design      : clk_setup_wrapper
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tftg256-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* HW_HANDOFF = "clk_setup.hwdef" *) 
module clk_setup
   (BCK,
    CLK,
    DI,
    EN,
    RST,
    WS);
  output BCK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN clk_setup_CLK, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.DI DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.DI, LAYERED_METADATA undef" *) input DI;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.EN DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.EN, LAYERED_METADATA undef" *) output EN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input RST;
  output WS;

  wire BCK;
  wire CLK;
  wire DI;
  wire EN;
  wire [15:0]I2S_master_0_DO_L;
  wire Net;
  wire RST;
  wire WS;
  wire NLW_CLK_MGR_0_FSYNC_UNCONNECTED;
  wire NLW_CLK_MGR_0_PWCLK_UNCONNECTED;
  wire [15:0]NLW_I2S_master_0_DO_R_UNCONNECTED;
  wire NLW_clk_wiz_0_locked_UNCONNECTED;

  (* CHECK_LICENSE_TYPE = "clk_setup_CLK_MGR_0_0,CLK_MGR,{}" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* IMPORTED_FROM = "/home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_CLK_MGR_0_0/clk_setup_CLK_MGR_0_0.dcp" *) 
  (* IMPORTED_TYPE = "CHECKPOINT" *) 
  (* IP_DEFINITION_SOURCE = "module_ref" *) 
  (* IS_IMPORTED *) 
  (* X_CORE_INFO = "CLK_MGR,Vivado 2024.2" *) 
  clk_setup_CLK_MGR_0_0 CLK_MGR_0
       (.BCLK(BCK),
        .FSYNC(NLW_CLK_MGR_0_FSYNC_UNCONNECTED),
        .PWCLK(NLW_CLK_MGR_0_PWCLK_UNCONNECTED),
        .RST(RST),
        .SYSCLK(Net),
        .WS(WS));
  (* CHECK_LICENSE_TYPE = "clk_setup_I2S_master_0_0,I2S_master,{}" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* IMPORTED_FROM = "/home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_I2S_master_0_0/clk_setup_I2S_master_0_0.dcp" *) 
  (* IMPORTED_TYPE = "CHECKPOINT" *) 
  (* IP_DEFINITION_SOURCE = "module_ref" *) 
  (* IS_IMPORTED *) 
  (* X_CORE_INFO = "I2S_master,Vivado 2024.2" *) 
  clk_setup_I2S_master_0_0 I2S_master_0
       (.BCLK(BCK),
        .DI(DI),
        .DO_L(I2S_master_0_DO_L),
        .DO_R(NLW_I2S_master_0_DO_R_UNCONNECTED[15:0]),
        .MCLK(Net),
        .RST(RST),
        .WS(WS));
  (* CHECK_LICENSE_TYPE = "clk_setup_PWM_output_0_0,PWM_output,{}" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* IMPORTED_FROM = "/home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_PWM_output_0_0/clk_setup_PWM_output_0_0.dcp" *) 
  (* IMPORTED_TYPE = "CHECKPOINT" *) 
  (* IP_DEFINITION_SOURCE = "module_ref" *) 
  (* IS_IMPORTED *) 
  (* X_CORE_INFO = "PWM_output,Vivado 2024.2" *) 
  clk_setup_PWM_output_0_0 PWM_output_0
       (.DCLK(WS),
        .DIN(I2S_master_0_DO_L),
        .EN(EN),
        .RST(RST),
        .SCLK(Net));
  (* IMPORTED_FROM = "/home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_clk_wiz_0_0/clk_setup_clk_wiz_0_0.dcp" *) 
  (* IMPORTED_TYPE = "CHECKPOINT" *) 
  (* IS_IMPORTED *) 
  clk_setup_clk_wiz_0_0 clk_wiz_0
       (.SYSCLK(Net),
        .clk_in1(CLK),
        .locked(NLW_clk_wiz_0_locked_UNCONNECTED),
        .resetn(RST));
endmodule

(* CHECK_LICENSE_TYPE = "clk_setup_CLK_MGR_0_0,CLK_MGR,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "CLK_MGR,Vivado 2024.2" *) 
module clk_setup_CLK_MGR_0_0
   (SYSCLK,
    WS,
    BCLK,
    FSYNC,
    PWCLK,
    RST);
  input SYSCLK;
  output WS;
  output BCLK;
  output FSYNC;
  output PWCLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input RST;

  wire \<const0> ;
  wire BCLK;
  wire PWCLK;
  wire RST;
  wire SYSCLK;
  wire WS;

  assign FSYNC = \<const0> ;
  GND GND
       (.G(\<const0> ));
  clk_setup_CLK_MGR_0_0_CLK_MGR inst
       (.BCLK(BCLK),
        .PWCLK(PWCLK),
        .RST(RST),
        .SYSCLK(SYSCLK),
        .WS(WS));
endmodule

(* ORIG_REF_NAME = "CLK_MGR" *) 
module clk_setup_CLK_MGR_0_0_CLK_MGR
   (WS,
    BCLK,
    PWCLK,
    SYSCLK,
    RST);
  output WS;
  output BCLK;
  output PWCLK;
  input SYSCLK;
  input RST;

  wire BCLK;
  wire BCLK_i_1_n_0;
  wire PWCLK;
  wire PWCLK_i_1_n_0;
  wire RST;
  wire SYSCLK;
  wire WS;
  wire WS_i_1_n_0;
  wire clear;
  wire p_1_in;
  wire [8:0]plusOp;
  wire \sclk_div[8]_i_3_n_0 ;
  wire \sclk_div_reg_n_0_[0] ;
  wire \sclk_div_reg_n_0_[1] ;
  wire \sclk_div_reg_n_0_[2] ;
  wire \sclk_div_reg_n_0_[3] ;
  wire \sclk_div_reg_n_0_[4] ;
  wire \sclk_div_reg_n_0_[5] ;
  wire \sclk_div_reg_n_0_[6] ;
  wire \sclk_div_reg_n_0_[7] ;

  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    BCLK_i_1
       (.I0(\sclk_div_reg_n_0_[3] ),
        .I1(RST),
        .I2(BCLK),
        .O(BCLK_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    BCLK_reg
       (.C(SYSCLK),
        .CE(1'b1),
        .D(BCLK_i_1_n_0),
        .Q(BCLK),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hB8)) 
    PWCLK_i_1
       (.I0(\sclk_div_reg_n_0_[2] ),
        .I1(RST),
        .I2(PWCLK),
        .O(PWCLK_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    PWCLK_reg
       (.C(SYSCLK),
        .CE(1'b1),
        .D(PWCLK_i_1_n_0),
        .Q(PWCLK),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    WS_i_1
       (.I0(p_1_in),
        .I1(RST),
        .I2(WS),
        .O(WS_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    WS_reg
       (.C(SYSCLK),
        .CE(1'b1),
        .D(WS_i_1_n_0),
        .Q(WS),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \sclk_div[0]_i_1 
       (.I0(\sclk_div_reg_n_0_[0] ),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \sclk_div[1]_i_1 
       (.I0(\sclk_div_reg_n_0_[0] ),
        .I1(\sclk_div_reg_n_0_[1] ),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \sclk_div[2]_i_1 
       (.I0(\sclk_div_reg_n_0_[0] ),
        .I1(\sclk_div_reg_n_0_[1] ),
        .I2(\sclk_div_reg_n_0_[2] ),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \sclk_div[3]_i_1 
       (.I0(\sclk_div_reg_n_0_[1] ),
        .I1(\sclk_div_reg_n_0_[0] ),
        .I2(\sclk_div_reg_n_0_[2] ),
        .I3(\sclk_div_reg_n_0_[3] ),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \sclk_div[4]_i_1 
       (.I0(\sclk_div_reg_n_0_[2] ),
        .I1(\sclk_div_reg_n_0_[0] ),
        .I2(\sclk_div_reg_n_0_[1] ),
        .I3(\sclk_div_reg_n_0_[3] ),
        .I4(\sclk_div_reg_n_0_[4] ),
        .O(plusOp[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \sclk_div[5]_i_1 
       (.I0(\sclk_div_reg_n_0_[3] ),
        .I1(\sclk_div_reg_n_0_[1] ),
        .I2(\sclk_div_reg_n_0_[0] ),
        .I3(\sclk_div_reg_n_0_[2] ),
        .I4(\sclk_div_reg_n_0_[4] ),
        .I5(\sclk_div_reg_n_0_[5] ),
        .O(plusOp[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \sclk_div[6]_i_1 
       (.I0(\sclk_div[8]_i_3_n_0 ),
        .I1(\sclk_div_reg_n_0_[6] ),
        .O(plusOp[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \sclk_div[7]_i_1 
       (.I0(\sclk_div[8]_i_3_n_0 ),
        .I1(\sclk_div_reg_n_0_[6] ),
        .I2(\sclk_div_reg_n_0_[7] ),
        .O(plusOp[7]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \sclk_div[8]_i_1 
       (.I0(\sclk_div_reg_n_0_[6] ),
        .I1(\sclk_div[8]_i_3_n_0 ),
        .I2(\sclk_div_reg_n_0_[7] ),
        .I3(p_1_in),
        .O(plusOp[8]));
  LUT1 #(
    .INIT(2'h1)) 
    \sclk_div[8]_i_2 
       (.I0(RST),
        .O(clear));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \sclk_div[8]_i_3 
       (.I0(\sclk_div_reg_n_0_[5] ),
        .I1(\sclk_div_reg_n_0_[3] ),
        .I2(\sclk_div_reg_n_0_[1] ),
        .I3(\sclk_div_reg_n_0_[0] ),
        .I4(\sclk_div_reg_n_0_[2] ),
        .I5(\sclk_div_reg_n_0_[4] ),
        .O(\sclk_div[8]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[0] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[0]),
        .Q(\sclk_div_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[1] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[1]),
        .Q(\sclk_div_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[2] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[2]),
        .Q(\sclk_div_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[3] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[3]),
        .Q(\sclk_div_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[4] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[4]),
        .Q(\sclk_div_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[5] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[5]),
        .Q(\sclk_div_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[6] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[6]),
        .Q(\sclk_div_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[7] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[7]),
        .Q(\sclk_div_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \sclk_div_reg[8] 
       (.C(SYSCLK),
        .CE(1'b1),
        .CLR(clear),
        .D(plusOp[8]),
        .Q(p_1_in));
endmodule

(* CHECK_LICENSE_TYPE = "clk_setup_I2S_master_0_0,I2S_master,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "I2S_master,Vivado 2024.2" *) 
module clk_setup_I2S_master_0_0
   (MCLK,
    BCLK,
    WS,
    DI,
    DO_L,
    DO_R,
    RST);
  input MCLK;
  input BCLK;
  input WS;
  input DI;
  output [15:0]DO_L;
  output [15:0]DO_R;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input RST;

  wire BCLK;
  wire DI;
  wire [15:0]DO_L;
  wire [15:0]DO_R;
  wire RST;
  wire WS;

  clk_setup_I2S_master_0_0_I2S_master inst
       (.BCLK(BCLK),
        .DI(DI),
        .DO_L(DO_L),
        .DO_R(DO_R),
        .RST(RST),
        .WS(WS));
endmodule

(* ORIG_REF_NAME = "I2S_master" *) 
module clk_setup_I2S_master_0_0_I2S_master
   (DO_L,
    DO_R,
    DI,
    RST,
    BCLK,
    WS);
  output [15:0]DO_L;
  output [15:0]DO_R;
  input DI;
  input RST;
  input BCLK;
  input WS;

  wire BCLK;
  wire DI;
  wire [15:0]DO_L;
  wire DO_L0;
  wire [15:0]DO_R;
  wire DO_R0;
  wire RST;
  wire WS;
  wire \cnt[0]_i_1_n_0 ;
  wire \cnt[1]_i_1_n_0 ;
  wire \cnt[2]_i_1_n_0 ;
  wire \cnt[3]_i_1_n_0 ;
  wire [3:0]cnt_reg;
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
  wire \inst/_n_0 ;
  wire wsd;
  wire wsd_i_1_n_0;
  wire wsp;
  wire wsp_i_1_n_0;

  LUT3 #(
    .INIT(8'h08)) 
    \DO_L[15]_i_1 
       (.I0(wsp),
        .I1(RST),
        .I2(wsd),
        .O(DO_L0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[0] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[0]),
        .Q(DO_L[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[10] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[10]),
        .Q(DO_L[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[11] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[11]),
        .Q(DO_L[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[12] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[12]),
        .Q(DO_L[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[13] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[13]),
        .Q(DO_L[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[14] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[14]),
        .Q(DO_L[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[15] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[15]),
        .Q(DO_L[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[1] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[1]),
        .Q(DO_L[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[2] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[2]),
        .Q(DO_L[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[3] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[3]),
        .Q(DO_L[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[4] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[4]),
        .Q(DO_L[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[5] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[5]),
        .Q(DO_L[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[6] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[6]),
        .Q(DO_L[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[7] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[7]),
        .Q(DO_L[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[8] 
       (.C(BCLK),
        .CE(DO_L0),
        .D(d_temp[8]),
        .Q(DO_L[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_L_reg[9] 
       (.C(BCLK),
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
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[0] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[0]),
        .Q(DO_R[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[10] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[10]),
        .Q(DO_R[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[11] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[11]),
        .Q(DO_R[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[12] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[12]),
        .Q(DO_R[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[13] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[13]),
        .Q(DO_R[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[14] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[14]),
        .Q(DO_R[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[15] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[15]),
        .Q(DO_R[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[1] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[1]),
        .Q(DO_R[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[2] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[2]),
        .Q(DO_R[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[3] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[3]),
        .Q(DO_R[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[4] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[4]),
        .Q(DO_R[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[5] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[5]),
        .Q(DO_R[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[6] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[6]),
        .Q(DO_R[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[7] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[7]),
        .Q(DO_R[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[8] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[8]),
        .Q(DO_R[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \DO_R_reg[9] 
       (.C(BCLK),
        .CE(DO_R0),
        .D(d_temp[9]),
        .Q(DO_R[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hDA)) 
    \cnt[0]_i_1 
       (.I0(cnt_reg[0]),
        .I1(wsp),
        .I2(RST),
        .O(\cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hF9AA)) 
    \cnt[1]_i_1 
       (.I0(cnt_reg[1]),
        .I1(cnt_reg[0]),
        .I2(wsp),
        .I3(RST),
        .O(\cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFA9AAAA)) 
    \cnt[2]_i_1 
       (.I0(cnt_reg[2]),
        .I1(cnt_reg[0]),
        .I2(cnt_reg[1]),
        .I3(wsp),
        .I4(RST),
        .O(\cnt[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAA9AAAAAAAA)) 
    \cnt[3]_i_1 
       (.I0(cnt_reg[3]),
        .I1(cnt_reg[1]),
        .I2(cnt_reg[0]),
        .I3(cnt_reg[2]),
        .I4(wsp),
        .I5(RST),
        .O(\cnt[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[0] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\cnt[0]_i_1_n_0 ),
        .Q(cnt_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[1] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\cnt[1]_i_1_n_0 ),
        .Q(cnt_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[2] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\cnt[2]_i_1_n_0 ),
        .Q(cnt_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[3] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\cnt[3]_i_1_n_0 ),
        .Q(cnt_reg[3]),
        .R(1'b0));
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
        .I2(\inst/_n_0 ),
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
       (.I0(cnt_reg[1]),
        .I1(cnt_reg[0]),
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
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \d_temp[13]_i_2 
       (.I0(cnt_reg[1]),
        .I1(cnt_reg[0]),
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
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \d_temp[14]_i_2 
       (.I0(cnt_reg[0]),
        .I1(cnt_reg[1]),
        .O(\d_temp[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \d_temp[15]_i_1 
       (.I0(DI),
        .I1(RST),
        .I2(\inst/_n_0 ),
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
        .I2(\inst/_n_0 ),
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
        .I2(\inst/_n_0 ),
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
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[0] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[0]_i_1_n_0 ),
        .Q(d_temp[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[10] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[10]_i_1_n_0 ),
        .Q(d_temp[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[11] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[11]_i_1_n_0 ),
        .Q(d_temp[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[12] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[12]_i_1_n_0 ),
        .Q(d_temp[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[13] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[13]_i_1_n_0 ),
        .Q(d_temp[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[14] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[14]_i_1_n_0 ),
        .Q(d_temp[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[15] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[15]_i_1_n_0 ),
        .Q(d_temp[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[1] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[1]_i_1_n_0 ),
        .Q(d_temp[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[2] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[2]_i_1_n_0 ),
        .Q(d_temp[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[3] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[3]_i_1_n_0 ),
        .Q(d_temp[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[4] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[4]_i_1_n_0 ),
        .Q(d_temp[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[5] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[5]_i_1_n_0 ),
        .Q(d_temp[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[6] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[6]_i_1_n_0 ),
        .Q(d_temp[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[7] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[7]_i_1_n_0 ),
        .Q(d_temp[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[8] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[8]_i_1_n_0 ),
        .Q(d_temp[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_temp_reg[9] 
       (.C(BCLK),
        .CE(1'b1),
        .D(\d_temp[9]_i_1_n_0 ),
        .Q(d_temp[9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h7)) 
    \inst/ 
       (.I0(cnt_reg[1]),
        .I1(cnt_reg[0]),
        .O(\inst/_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    wsd_i_1
       (.I0(WS),
        .I1(RST),
        .I2(wsd),
        .O(wsd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    wsd_reg
       (.C(BCLK),
        .CE(1'b1),
        .D(wsd_i_1_n_0),
        .Q(wsd),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h6F60)) 
    wsp_i_1
       (.I0(WS),
        .I1(wsd),
        .I2(RST),
        .I3(wsp),
        .O(wsp_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    wsp_reg
       (.C(BCLK),
        .CE(1'b1),
        .D(wsp_i_1_n_0),
        .Q(wsp),
        .R(1'b0));
endmodule

(* CHECK_LICENSE_TYPE = "clk_setup_PWM_output_0_0,PWM_output,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "PWM_output,Vivado 2024.2" *) 
module clk_setup_PWM_output_0_0
   (SCLK,
    DCLK,
    DIN,
    EN,
    RST);
  input SCLK;
  input DCLK;
  input [15:0]DIN;
  output EN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input RST;

  wire \<const0> ;

  assign EN = \<const0> ;
  GND GND
       (.G(\<const0> ));
endmodule

module clk_setup_clk_wiz_0_0
   (SYSCLK,
    resetn,
    locked,
    clk_in1);
  output SYSCLK;
  input resetn;
  output locked;
  input clk_in1;

  wire SYSCLK;
  wire clk_in1;
  wire locked;
  wire resetn;

  clk_setup_clk_wiz_0_0_clk_wiz inst
       (.SYSCLK(SYSCLK),
        .clk_in1(clk_in1),
        .locked(locked),
        .resetn(resetn));
endmodule

module clk_setup_clk_wiz_0_0_clk_wiz
   (SYSCLK,
    resetn,
    locked,
    clk_in1);
  output SYSCLK;
  input resetn;
  output locked;
  input clk_in1;

  wire SYSCLK;
  wire SYSCLK_clk_setup_clk_wiz_0_0;
  wire clk_in1;
  wire clk_in1_clk_setup_clk_wiz_0_0;
  wire clkfbout_buf_clk_setup_clk_wiz_0_0;
  wire clkfbout_clk_setup_clk_wiz_0_0;
  wire locked;
  wire reset_high;
  wire resetn;
  wire NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT1_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED;
  wire NLW_mmcm_adv_inst_DRDY_UNCONNECTED;
  wire NLW_mmcm_adv_inst_PSDONE_UNCONNECTED;
  wire [15:0]NLW_mmcm_adv_inst_DO_UNCONNECTED;

  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkf_buf
       (.I(clkfbout_clk_setup_clk_wiz_0_0),
        .O(clkfbout_buf_clk_setup_clk_wiz_0_0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUF #(
    .IOSTANDARD("DEFAULT")) 
    clkin1_ibufg
       (.I(clk_in1),
        .O(clk_in1_clk_setup_clk_wiz_0_0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clkout1_buf
       (.I(SYSCLK_clk_setup_clk_wiz_0_0),
        .O(SYSCLK));
  (* BOX_TYPE = "PRIMITIVE" *) 
  MMCME2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT_F(43.625000),
    .CLKFBOUT_PHASE(0.000000),
    .CLKFBOUT_USE_FINE_PS("FALSE"),
    .CLKIN1_PERIOD(10.000000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE_F(17.750000),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT0_USE_FINE_PS("FALSE"),
    .CLKOUT1_DIVIDE(1),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT1_USE_FINE_PS("FALSE"),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT2_USE_FINE_PS("FALSE"),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT3_USE_FINE_PS("FALSE"),
    .CLKOUT4_CASCADE("FALSE"),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT4_USE_FINE_PS("FALSE"),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .CLKOUT5_USE_FINE_PS("FALSE"),
    .CLKOUT6_DIVIDE(1),
    .CLKOUT6_DUTY_CYCLE(0.500000),
    .CLKOUT6_PHASE(0.000000),
    .CLKOUT6_USE_FINE_PS("FALSE"),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(5),
    .IS_CLKINSEL_INVERTED(1'b0),
    .IS_PSEN_INVERTED(1'b0),
    .IS_PSINCDEC_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .REF_JITTER1(0.010000),
    .REF_JITTER2(0.010000),
    .SS_EN("FALSE"),
    .SS_MODE("CENTER_HIGH"),
    .SS_MOD_PERIOD(10000),
    .STARTUP_WAIT("FALSE")) 
    mmcm_adv_inst
       (.CLKFBIN(clkfbout_buf_clk_setup_clk_wiz_0_0),
        .CLKFBOUT(clkfbout_clk_setup_clk_wiz_0_0),
        .CLKFBOUTB(NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED),
        .CLKFBSTOPPED(NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED),
        .CLKIN1(clk_in1_clk_setup_clk_wiz_0_0),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKINSTOPPED(NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED),
        .CLKOUT0(SYSCLK_clk_setup_clk_wiz_0_0),
        .CLKOUT0B(NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED),
        .CLKOUT1(NLW_mmcm_adv_inst_CLKOUT1_UNCONNECTED),
        .CLKOUT1B(NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED),
        .CLKOUT2(NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED),
        .CLKOUT2B(NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED),
        .CLKOUT3(NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED),
        .CLKOUT3B(NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED),
        .CLKOUT4(NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED),
        .CLKOUT6(NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_mmcm_adv_inst_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_mmcm_adv_inst_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(locked),
        .PSCLK(1'b0),
        .PSDONE(NLW_mmcm_adv_inst_PSDONE_UNCONNECTED),
        .PSEN(1'b0),
        .PSINCDEC(1'b0),
        .PWRDWN(1'b0),
        .RST(reset_high));
  LUT1 #(
    .INIT(2'h1)) 
    mmcm_adv_inst_i_1
       (.I0(resetn),
        .O(reset_high));
endmodule

(* NotValidForBitStream *)
module clk_setup_wrapper
   (BCK,
    CLK,
    DI,
    EN,
    RST,
    WS);
  output BCK;
  input CLK;
  input DI;
  output EN;
  input RST;
  output WS;

  wire BCK;
  wire BCK_OBUF;
  (* IBUF_LOW_PWR *) wire CLK;
  wire DI;
  wire DI_IBUF;
  wire EN;
  wire EN_OBUF;
  wire RST;
  wire RST_IBUF;
  wire WS;
  wire WS_OBUF;

  OBUF BCK_OBUF_inst
       (.I(BCK_OBUF),
        .O(BCK));
  IBUF DI_IBUF_inst
       (.I(DI),
        .O(DI_IBUF));
  OBUF EN_OBUF_inst
       (.I(EN_OBUF),
        .O(EN));
  IBUF RST_IBUF_inst
       (.I(RST),
        .O(RST_IBUF));
  OBUF WS_OBUF_inst
       (.I(WS_OBUF),
        .O(WS));
  (* HW_HANDOFF = "clk_setup.hwdef" *) 
  clk_setup clk_setup_i
       (.BCK(BCK_OBUF),
        .CLK(CLK),
        .DI(DI_IBUF),
        .EN(EN_OBUF),
        .RST(RST_IBUF),
        .WS(WS_OBUF));
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
