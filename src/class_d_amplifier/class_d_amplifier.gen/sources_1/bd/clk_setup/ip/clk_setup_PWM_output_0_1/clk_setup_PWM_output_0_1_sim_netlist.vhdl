-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
-- Date        : Wed May 14 18:56:56 2025
-- Host        : legolas running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_PWM_output_0_1/clk_setup_PWM_output_0_1_sim_netlist.vhdl
-- Design      : clk_setup_PWM_output_0_1
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tftg256-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_setup_PWM_output_0_1_PWM_output is
  port (
    EN : out STD_LOGIC;
    DCLK : in STD_LOGIC;
    SCLK : in STD_LOGIC;
    DIN : in STD_LOGIC_VECTOR ( 4 downto 0 );
    RST : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of clk_setup_PWM_output_0_1_PWM_output : entity is "PWM_output";
end clk_setup_PWM_output_0_1_PWM_output;

architecture STRUCTURE of clk_setup_PWM_output_0_1_PWM_output is
  signal DCLKD : STD_LOGIC;
  signal DCLKD_i_1_n_0 : STD_LOGIC;
  signal \^en\ : STD_LOGIC;
  signal EN_i_1_n_0 : STD_LOGIC;
  signal EN_i_2_n_0 : STD_LOGIC;
  signal EN_i_3_n_0 : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal \cntr[0]_i_1_n_0\ : STD_LOGIC;
  signal \cntr[1]_i_1_n_0\ : STD_LOGIC;
  signal \cntr[2]_i_1_n_0\ : STD_LOGIC;
  signal \cntr[3]_i_1_n_0\ : STD_LOGIC;
  signal \cntr[4]_i_1_n_0\ : STD_LOGIC;
  signal cntr_reg : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal dsync : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal dsync0 : STD_LOGIC;
  signal \dsync1__1\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 4 to 4 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of DCLKD_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of EN_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \cntr[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \cntr[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \cntr[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \cntr[4]_i_3\ : label is "soft_lutpair2";
begin
  EN <= \^en\;
DCLKD_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => DCLK,
      I1 => RST,
      I2 => DCLKD,
      O => DCLKD_i_1_n_0
    );
DCLKD_reg: unisim.vcomponents.FDRE
     port map (
      C => SCLK,
      CE => '1',
      D => DCLKD_i_1_n_0,
      Q => DCLKD,
      R => '0'
    );
EN_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFBB8088"
    )
        port map (
      I0 => EN_i_2_n_0,
      I1 => RST,
      I2 => DCLKD,
      I3 => DCLK,
      I4 => \^en\,
      O => EN_i_1_n_0
    );
EN_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B2FF00B2"
    )
        port map (
      I0 => EN_i_3_n_0,
      I1 => cntr_reg(3),
      I2 => dsync(3),
      I3 => cntr_reg(4),
      I4 => dsync(4),
      O => EN_i_2_n_0
    );
EN_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2F02FFFF00002F02"
    )
        port map (
      I0 => dsync(0),
      I1 => cntr_reg(0),
      I2 => cntr_reg(1),
      I3 => dsync(1),
      I4 => cntr_reg(2),
      I5 => dsync(2),
      O => EN_i_3_n_0
    );
EN_reg: unisim.vcomponents.FDRE
     port map (
      C => SCLK,
      CE => '1',
      D => EN_i_1_n_0,
      Q => \^en\,
      R => '0'
    );
\cntr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"45"
    )
        port map (
      I0 => cntr_reg(0),
      I1 => DCLKD,
      I2 => DCLK,
      O => \cntr[0]_i_1_n_0\
    );
\cntr[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6066"
    )
        port map (
      I0 => cntr_reg(1),
      I1 => cntr_reg(0),
      I2 => DCLKD,
      I3 => DCLK,
      O => \cntr[1]_i_1_n_0\
    );
\cntr[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6A006A6A"
    )
        port map (
      I0 => cntr_reg(2),
      I1 => cntr_reg(1),
      I2 => cntr_reg(0),
      I3 => DCLKD,
      I4 => DCLK,
      O => \cntr[2]_i_1_n_0\
    );
\cntr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAA00006AAA6AAA"
    )
        port map (
      I0 => cntr_reg(3),
      I1 => cntr_reg(2),
      I2 => cntr_reg(0),
      I3 => cntr_reg(1),
      I4 => DCLKD,
      I5 => DCLK,
      O => \cntr[3]_i_1_n_0\
    );
\cntr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000006AAAAAAA"
    )
        port map (
      I0 => cntr_reg(4),
      I1 => cntr_reg(3),
      I2 => cntr_reg(1),
      I3 => cntr_reg(0),
      I4 => cntr_reg(2),
      I5 => \dsync1__1\,
      O => \cntr[4]_i_1_n_0\
    );
\cntr[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => RST,
      O => clear
    );
\cntr[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => DCLK,
      I1 => DCLKD,
      O => \dsync1__1\
    );
\cntr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => SCLK,
      CE => '1',
      CLR => clear,
      D => \cntr[0]_i_1_n_0\,
      Q => cntr_reg(0)
    );
\cntr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => SCLK,
      CE => '1',
      CLR => clear,
      D => \cntr[1]_i_1_n_0\,
      Q => cntr_reg(1)
    );
\cntr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => SCLK,
      CE => '1',
      CLR => clear,
      D => \cntr[2]_i_1_n_0\,
      Q => cntr_reg(2)
    );
\cntr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => SCLK,
      CE => '1',
      CLR => clear,
      D => \cntr[3]_i_1_n_0\,
      Q => cntr_reg(3)
    );
\cntr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => SCLK,
      CE => '1',
      CLR => clear,
      D => \cntr[4]_i_1_n_0\,
      Q => cntr_reg(4)
    );
\dsync[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => RST,
      I1 => DCLKD,
      I2 => DCLK,
      O => dsync0
    );
\dsync[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => DIN(4),
      O => p_0_in(4)
    );
\dsync_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => SCLK,
      CE => dsync0,
      D => DIN(0),
      Q => dsync(0),
      R => '0'
    );
\dsync_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => SCLK,
      CE => dsync0,
      D => DIN(1),
      Q => dsync(1),
      R => '0'
    );
\dsync_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => SCLK,
      CE => dsync0,
      D => DIN(2),
      Q => dsync(2),
      R => '0'
    );
\dsync_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => SCLK,
      CE => dsync0,
      D => DIN(3),
      Q => dsync(3),
      R => '0'
    );
\dsync_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => SCLK,
      CE => dsync0,
      D => p_0_in(4),
      Q => dsync(4),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_setup_PWM_output_0_1 is
  port (
    SCLK : in STD_LOGIC;
    DCLK : in STD_LOGIC;
    DIN : in STD_LOGIC_VECTOR ( 4 downto 0 );
    EN : out STD_LOGIC;
    RST : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of clk_setup_PWM_output_0_1 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of clk_setup_PWM_output_0_1 : entity is "clk_setup_PWM_output_0_1,PWM_output,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of clk_setup_PWM_output_0_1 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of clk_setup_PWM_output_0_1 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of clk_setup_PWM_output_0_1 : entity is "PWM_output,Vivado 2024.2";
end clk_setup_PWM_output_0_1;

architecture STRUCTURE of clk_setup_PWM_output_0_1 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of RST : signal is "xilinx.com:signal:reset:1.0 RST RST";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of RST : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of RST : signal is "XIL_INTERFACENAME RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.clk_setup_PWM_output_0_1_PWM_output
     port map (
      DCLK => DCLK,
      DIN(4 downto 0) => DIN(4 downto 0),
      EN => EN,
      RST => RST,
      SCLK => SCLK
    );
end STRUCTURE;
