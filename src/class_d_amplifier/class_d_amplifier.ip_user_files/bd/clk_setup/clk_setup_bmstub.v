// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module clk_setup (
  CLK,
  EN_L,
  DI,
  WS,
  BCK,
  RST
);

  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *)
  (* X_INTERFACE_MODE = "slave CLK.CLK" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN clk_setup_CLK, INSERT_VIP 0" *)
  input CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.EN_L DATA" *)
  (* X_INTERFACE_MODE = "master DATA.EN_L" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.EN_L, LAYERED_METADATA undef" *)
  output EN_L;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.DI DATA" *)
  (* X_INTERFACE_MODE = "slave DATA.DI" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.DI, LAYERED_METADATA undef" *)
  input DI;
  (* X_INTERFACE_IGNORE = "true" *)
  output WS;
  (* X_INTERFACE_IGNORE = "true" *)
  output BCK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST RST" *)
  (* X_INTERFACE_MODE = "slave RST.RST" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  input RST;

  // stub module has no contents

endmodule
