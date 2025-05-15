-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
-- Date        : Wed May 14 18:42:41 2025
-- Host        : legolas running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_Quantizer_Interconne_0_0/clk_setup_Quantizer_Interconne_0_0_sim_netlist.vhdl
-- Design      : clk_setup_Quantizer_Interconne_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tftg256-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_setup_Quantizer_Interconne_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of clk_setup_Quantizer_Interconne_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of clk_setup_Quantizer_Interconne_0_0 : entity is "clk_setup_Quantizer_Interconne_0_0,Quantizer_Interconnect,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of clk_setup_Quantizer_Interconne_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of clk_setup_Quantizer_Interconne_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of clk_setup_Quantizer_Interconne_0_0 : entity is "Quantizer_Interconnect,Vivado 2024.2";
end clk_setup_Quantizer_Interconne_0_0;

architecture STRUCTURE of clk_setup_Quantizer_Interconne_0_0 is
  signal \^di_l\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^di_r\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^l_read\ : STD_LOGIC;
  signal \^r_read\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of CLK : signal is "xilinx.com:signal:clock:1.0 CLK CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of CLK : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of CLK : signal is "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RST, FREQ_HZ 90315789, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of RST : signal is "xilinx.com:signal:reset:1.0 RST RST";
  attribute X_INTERFACE_MODE of RST : signal is "slave";
  attribute X_INTERFACE_PARAMETER of RST : signal is "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
  DO_L(4 downto 0) <= \^di_l\(15 downto 11);
  DO_R(4 downto 0) <= \^di_r\(15 downto 11);
  L_RDY <= \^l_read\;
  R_RDY <= \^r_read\;
  \^di_l\(15 downto 11) <= DI_L(15 downto 11);
  \^di_r\(15 downto 11) <= DI_R(15 downto 11);
  \^l_read\ <= L_READ;
  \^r_read\ <= R_READ;
end STRUCTURE;
