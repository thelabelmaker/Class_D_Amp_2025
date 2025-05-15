-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
-- Date        : Wed May 14 18:42:41 2025
-- Host        : legolas running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_Quantizer_Interconne_0_0/clk_setup_Quantizer_Interconne_0_0_stub.vhdl
-- Design      : clk_setup_Quantizer_Interconne_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tftg256-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_setup_Quantizer_Interconne_0_0 is
  Port ( 
    L_READ : in STD_LOGIC;
    R_READ : in STD_LOGIC;
    DI_L : in STD_LOGIC_VECTOR ( 15 downto 0 );
    DI_R : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK : in STD_LOGIC;
    RST : in STD_LOGIC;
    L_RDY : out STD_LOGIC;
    R_RDY : out STD_LOGIC;
    DO_L : out STD_LOGIC_VECTOR ( 4 downto 0 );
    DO_R : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of clk_setup_Quantizer_Interconne_0_0 : entity is "clk_setup_Quantizer_Interconne_0_0,Quantizer_Interconnect,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of clk_setup_Quantizer_Interconne_0_0 : entity is "clk_setup_Quantizer_Interconne_0_0,Quantizer_Interconnect,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=Quantizer_Interconnect,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of clk_setup_Quantizer_Interconne_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of clk_setup_Quantizer_Interconne_0_0 : entity is "module_ref";
end clk_setup_Quantizer_Interconne_0_0;

architecture stub of clk_setup_Quantizer_Interconne_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "L_READ,R_READ,DI_L[15:0],DI_R[15:0],CLK,RST,L_RDY,R_RDY,DO_L[4:0],DO_R[4:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of CLK : signal is "xilinx.com:signal:clock:1.0 CLK CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of CLK : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of CLK : signal is "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RST, FREQ_HZ 90315789, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of RST : signal is "xilinx.com:signal:reset:1.0 RST RST";
  attribute X_INTERFACE_MODE of RST : signal is "slave";
  attribute X_INTERFACE_PARAMETER of RST : signal is "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "Quantizer_Interconnect,Vivado 2024.2";
begin
end;
