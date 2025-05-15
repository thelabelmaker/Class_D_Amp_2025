-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
-- Date        : Wed May 14 18:56:56 2025
-- Host        : legolas running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/ethan/Documents/ee119c/Class_D_Amp_2025/src/class_d_amplifier/class_d_amplifier.gen/sources_1/bd/clk_setup/ip/clk_setup_I2S_interconnect_0_0/clk_setup_I2S_interconnect_0_0_sim_netlist.vhdl
-- Design      : clk_setup_I2S_interconnect_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tftg256-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_setup_I2S_interconnect_0_0_I2S_CLK_MGR is
  port (
    WS : out STD_LOGIC;
    BCK : out STD_LOGIC;
    L_RDY : out STD_LOGIC;
    R_RDY : out STD_LOGIC;
    WS_reg_0 : out STD_LOGIC;
    RST : in STD_LOGIC;
    CLK : in STD_LOGIC;
    wsd : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of clk_setup_I2S_interconnect_0_0_I2S_CLK_MGR : entity is "I2S_CLK_MGR";
end clk_setup_I2S_interconnect_0_0_I2S_CLK_MGR;

architecture STRUCTURE of clk_setup_I2S_interconnect_0_0_I2S_CLK_MGR is
  signal FSYNC_L0 : STD_LOGIC;
  signal FSYNC_R0 : STD_LOGIC;
  signal \^ws\ : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in3_in : STD_LOGIC;
  signal \sclk_div[0]_i_3_n_0\ : STD_LOGIC;
  signal \sclk_div_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \sclk_div_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \sclk_div_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \sclk_div_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \sclk_div_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \sclk_div_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \sclk_div_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \sclk_div_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \sclk_div_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \sclk_div_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \sclk_div_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \sclk_div_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \sclk_div_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \sclk_div_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \sclk_div_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \sclk_div_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \sclk_div_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \sclk_div_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \sclk_div_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \sclk_div_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \sclk_div_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[0]\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[1]\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[2]\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[3]\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[4]\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[5]\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[6]\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[7]\ : STD_LOGIC;
  signal \sclk_div_reg_n_0_[9]\ : STD_LOGIC;
  signal \NLW_sclk_div_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_sclk_div_reg[8]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of FSYNC_L_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of FSYNC_R_i_1 : label is "soft_lutpair0";
begin
  WS <= \^ws\;
BCLK_reg: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => RST,
      D => \sclk_div_reg_n_0_[5]\,
      Q => BCK,
      R => '0'
    );
FSYNC_L_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => p_0_in3_in,
      I1 => p_0_in,
      I2 => \sclk_div_reg_n_0_[9]\,
      O => FSYNC_L0
    );
FSYNC_L_reg: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => RST,
      D => FSYNC_L0,
      Q => L_RDY,
      R => '0'
    );
FSYNC_R_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => p_0_in,
      I1 => \sclk_div_reg_n_0_[9]\,
      I2 => p_0_in3_in,
      O => FSYNC_R0
    );
FSYNC_R_reg: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => RST,
      D => FSYNC_R0,
      Q => R_RDY,
      R => '0'
    );
WS_reg: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => RST,
      D => p_0_in3_in,
      Q => \^ws\,
      R => '0'
    );
\sclk_div[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => RST,
      O => clear
    );
\sclk_div[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \sclk_div_reg_n_0_[0]\,
      O => \sclk_div[0]_i_3_n_0\
    );
\sclk_div_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[0]_i_1_n_7\,
      Q => \sclk_div_reg_n_0_[0]\
    );
\sclk_div_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \sclk_div_reg[0]_i_1_n_0\,
      CO(2) => \sclk_div_reg[0]_i_1_n_1\,
      CO(1) => \sclk_div_reg[0]_i_1_n_2\,
      CO(0) => \sclk_div_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \sclk_div_reg[0]_i_1_n_4\,
      O(2) => \sclk_div_reg[0]_i_1_n_5\,
      O(1) => \sclk_div_reg[0]_i_1_n_6\,
      O(0) => \sclk_div_reg[0]_i_1_n_7\,
      S(3) => \sclk_div_reg_n_0_[3]\,
      S(2) => \sclk_div_reg_n_0_[2]\,
      S(1) => \sclk_div_reg_n_0_[1]\,
      S(0) => \sclk_div[0]_i_3_n_0\
    );
\sclk_div_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[8]_i_1_n_5\,
      Q => p_0_in3_in
    );
\sclk_div_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[0]_i_1_n_6\,
      Q => \sclk_div_reg_n_0_[1]\
    );
\sclk_div_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[0]_i_1_n_5\,
      Q => \sclk_div_reg_n_0_[2]\
    );
\sclk_div_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[0]_i_1_n_4\,
      Q => \sclk_div_reg_n_0_[3]\
    );
\sclk_div_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[4]_i_1_n_7\,
      Q => \sclk_div_reg_n_0_[4]\
    );
\sclk_div_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sclk_div_reg[0]_i_1_n_0\,
      CO(3) => \sclk_div_reg[4]_i_1_n_0\,
      CO(2) => \sclk_div_reg[4]_i_1_n_1\,
      CO(1) => \sclk_div_reg[4]_i_1_n_2\,
      CO(0) => \sclk_div_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sclk_div_reg[4]_i_1_n_4\,
      O(2) => \sclk_div_reg[4]_i_1_n_5\,
      O(1) => \sclk_div_reg[4]_i_1_n_6\,
      O(0) => \sclk_div_reg[4]_i_1_n_7\,
      S(3) => \sclk_div_reg_n_0_[7]\,
      S(2) => \sclk_div_reg_n_0_[6]\,
      S(1) => \sclk_div_reg_n_0_[5]\,
      S(0) => \sclk_div_reg_n_0_[4]\
    );
\sclk_div_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[4]_i_1_n_6\,
      Q => \sclk_div_reg_n_0_[5]\
    );
\sclk_div_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[4]_i_1_n_5\,
      Q => \sclk_div_reg_n_0_[6]\
    );
\sclk_div_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[4]_i_1_n_4\,
      Q => \sclk_div_reg_n_0_[7]\
    );
\sclk_div_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[8]_i_1_n_7\,
      Q => p_0_in
    );
\sclk_div_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sclk_div_reg[4]_i_1_n_0\,
      CO(3 downto 2) => \NLW_sclk_div_reg[8]_i_1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \sclk_div_reg[8]_i_1_n_2\,
      CO(0) => \sclk_div_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_sclk_div_reg[8]_i_1_O_UNCONNECTED\(3),
      O(2) => \sclk_div_reg[8]_i_1_n_5\,
      O(1) => \sclk_div_reg[8]_i_1_n_6\,
      O(0) => \sclk_div_reg[8]_i_1_n_7\,
      S(3) => '0',
      S(2) => p_0_in3_in,
      S(1) => \sclk_div_reg_n_0_[9]\,
      S(0) => p_0_in
    );
\sclk_div_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => CLK,
      CE => '1',
      CLR => clear,
      D => \sclk_div_reg[8]_i_1_n_6\,
      Q => \sclk_div_reg_n_0_[9]\
    );
wsd_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^ws\,
      I1 => RST,
      I2 => wsd,
      O => WS_reg_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_setup_I2S_interconnect_0_0_I2S_master is
  port (
    wsd : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DO_L : out STD_LOGIC_VECTOR ( 15 downto 0 );
    DO_R : out STD_LOGIC_VECTOR ( 15 downto 0 );
    wsd_reg_0 : in STD_LOGIC;
    CLK : in STD_LOGIC;
    RST : in STD_LOGIC;
    WS : in STD_LOGIC;
    DI : in STD_LOGIC;
    \d_temp_reg[15]_0\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of clk_setup_I2S_interconnect_0_0_I2S_master : entity is "I2S_master";
end clk_setup_I2S_interconnect_0_0_I2S_master;

architecture STRUCTURE of clk_setup_I2S_interconnect_0_0_I2S_master is
  signal DO_L0 : STD_LOGIC;
  signal DO_R0 : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal cnt_reg : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal d_temp : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \d_temp[0]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[10]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[11]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[12]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[12]_i_2_n_0\ : STD_LOGIC;
  signal \d_temp[13]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[13]_i_2_n_0\ : STD_LOGIC;
  signal \d_temp[14]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[14]_i_2_n_0\ : STD_LOGIC;
  signal \d_temp[15]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[1]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[2]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[3]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[4]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[5]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[6]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[7]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[8]_i_1_n_0\ : STD_LOGIC;
  signal \d_temp[9]_i_1_n_0\ : STD_LOGIC;
  signal \^wsd\ : STD_LOGIC;
  signal wsp : STD_LOGIC;
  signal wsp_i_1_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \cnt[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \cnt[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \cnt[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \cnt[3]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \d_temp[12]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \d_temp[14]_i_2\ : label is "soft_lutpair3";
begin
  Q(1 downto 0) <= \^q\(1 downto 0);
  wsd <= \^wsd\;
\DO_L[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => wsp,
      I1 => RST,
      I2 => \^wsd\,
      O => DO_L0
    );
\DO_L_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(0),
      Q => DO_L(0),
      R => '0'
    );
\DO_L_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(10),
      Q => DO_L(10),
      R => '0'
    );
\DO_L_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(11),
      Q => DO_L(11),
      R => '0'
    );
\DO_L_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(12),
      Q => DO_L(12),
      R => '0'
    );
\DO_L_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(13),
      Q => DO_L(13),
      R => '0'
    );
\DO_L_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(14),
      Q => DO_L(14),
      R => '0'
    );
\DO_L_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(15),
      Q => DO_L(15),
      R => '0'
    );
\DO_L_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(1),
      Q => DO_L(1),
      R => '0'
    );
\DO_L_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(2),
      Q => DO_L(2),
      R => '0'
    );
\DO_L_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(3),
      Q => DO_L(3),
      R => '0'
    );
\DO_L_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(4),
      Q => DO_L(4),
      R => '0'
    );
\DO_L_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(5),
      Q => DO_L(5),
      R => '0'
    );
\DO_L_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(6),
      Q => DO_L(6),
      R => '0'
    );
\DO_L_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(7),
      Q => DO_L(7),
      R => '0'
    );
\DO_L_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(8),
      Q => DO_L(8),
      R => '0'
    );
\DO_L_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_L0,
      D => d_temp(9),
      Q => DO_L(9),
      R => '0'
    );
\DO_R[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => wsp,
      I1 => RST,
      I2 => \^wsd\,
      O => DO_R0
    );
\DO_R_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(0),
      Q => DO_R(0),
      R => '0'
    );
\DO_R_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(10),
      Q => DO_R(10),
      R => '0'
    );
\DO_R_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(11),
      Q => DO_R(11),
      R => '0'
    );
\DO_R_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(12),
      Q => DO_R(12),
      R => '0'
    );
\DO_R_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(13),
      Q => DO_R(13),
      R => '0'
    );
\DO_R_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(14),
      Q => DO_R(14),
      R => '0'
    );
\DO_R_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(15),
      Q => DO_R(15),
      R => '0'
    );
\DO_R_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(1),
      Q => DO_R(1),
      R => '0'
    );
\DO_R_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(2),
      Q => DO_R(2),
      R => '0'
    );
\DO_R_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(3),
      Q => DO_R(3),
      R => '0'
    );
\DO_R_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(4),
      Q => DO_R(4),
      R => '0'
    );
\DO_R_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(5),
      Q => DO_R(5),
      R => '0'
    );
\DO_R_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(6),
      Q => DO_R(6),
      R => '0'
    );
\DO_R_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(7),
      Q => DO_R(7),
      R => '0'
    );
\DO_R_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(8),
      Q => DO_R(8),
      R => '0'
    );
\DO_R_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => DO_R0,
      D => d_temp(9),
      Q => DO_R(9),
      R => '0'
    );
\cnt[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => wsp,
      I1 => \^q\(0),
      O => \cnt[0]_i_1_n_0\
    );
\cnt[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EB"
    )
        port map (
      I0 => wsp,
      I1 => \^q\(0),
      I2 => \^q\(1),
      O => \cnt[1]_i_1_n_0\
    );
\cnt[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEAB"
    )
        port map (
      I0 => wsp,
      I1 => \^q\(1),
      I2 => \^q\(0),
      I3 => cnt_reg(2),
      O => \cnt[2]_i_1_n_0\
    );
\cnt[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEAAAB"
    )
        port map (
      I0 => wsp,
      I1 => cnt_reg(2),
      I2 => \^q\(0),
      I3 => \^q\(1),
      I4 => cnt_reg(3),
      O => \cnt[3]_i_1_n_0\
    );
\cnt_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => RST,
      D => \cnt[0]_i_1_n_0\,
      Q => \^q\(0),
      S => '0'
    );
\cnt_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => RST,
      D => \cnt[1]_i_1_n_0\,
      Q => \^q\(1),
      S => '0'
    );
\cnt_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => RST,
      D => \cnt[2]_i_1_n_0\,
      Q => cnt_reg(2),
      S => '0'
    );
\cnt_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => RST,
      D => \cnt[3]_i_1_n_0\,
      Q => cnt_reg(3),
      S => '0'
    );
\d_temp[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFB00000008"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[12]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(0),
      O => \d_temp[0]_i_1_n_0\
    );
\d_temp[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[14]_i_2_n_0\,
      I3 => cnt_reg(2),
      I4 => cnt_reg(3),
      I5 => d_temp(10),
      O => \d_temp[10]_i_1_n_0\
    );
\d_temp[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp_reg[15]_0\,
      I3 => cnt_reg(2),
      I4 => cnt_reg(3),
      I5 => d_temp(11),
      O => \d_temp[11]_i_1_n_0\
    );
\d_temp[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFFFFFF08000000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[12]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(12),
      O => \d_temp[12]_i_1_n_0\
    );
\d_temp[12]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      O => \d_temp[12]_i_2_n_0\
    );
\d_temp[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFFFFFF08000000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[13]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(13),
      O => \d_temp[13]_i_1_n_0\
    );
\d_temp[13]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      O => \d_temp[13]_i_2_n_0\
    );
\d_temp[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFFFFFF08000000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[14]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(14),
      O => \d_temp[14]_i_1_n_0\
    );
\d_temp[14]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \d_temp[14]_i_2_n_0\
    );
\d_temp[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFFFFFF08000000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp_reg[15]_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(15),
      O => \d_temp[15]_i_1_n_0\
    );
\d_temp[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFB00000008"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[13]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(1),
      O => \d_temp[1]_i_1_n_0\
    );
\d_temp[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFB00000008"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[14]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(2),
      O => \d_temp[2]_i_1_n_0\
    );
\d_temp[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFB00000008"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp_reg[15]_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(3),
      O => \d_temp[3]_i_1_n_0\
    );
\d_temp[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[12]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(4),
      O => \d_temp[4]_i_1_n_0\
    );
\d_temp[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[13]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(5),
      O => \d_temp[5]_i_1_n_0\
    );
\d_temp[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[14]_i_2_n_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(6),
      O => \d_temp[6]_i_1_n_0\
    );
\d_temp[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp_reg[15]_0\,
      I3 => cnt_reg(3),
      I4 => cnt_reg(2),
      I5 => d_temp(7),
      O => \d_temp[7]_i_1_n_0\
    );
\d_temp[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[12]_i_2_n_0\,
      I3 => cnt_reg(2),
      I4 => cnt_reg(3),
      I5 => d_temp(8),
      O => \d_temp[8]_i_1_n_0\
    );
\d_temp[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => DI,
      I1 => RST,
      I2 => \d_temp[13]_i_2_n_0\,
      I3 => cnt_reg(2),
      I4 => cnt_reg(3),
      I5 => d_temp(9),
      O => \d_temp[9]_i_1_n_0\
    );
\d_temp_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[0]_i_1_n_0\,
      Q => d_temp(0),
      R => '0'
    );
\d_temp_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[10]_i_1_n_0\,
      Q => d_temp(10),
      R => '0'
    );
\d_temp_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[11]_i_1_n_0\,
      Q => d_temp(11),
      R => '0'
    );
\d_temp_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[12]_i_1_n_0\,
      Q => d_temp(12),
      R => '0'
    );
\d_temp_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[13]_i_1_n_0\,
      Q => d_temp(13),
      R => '0'
    );
\d_temp_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[14]_i_1_n_0\,
      Q => d_temp(14),
      R => '0'
    );
\d_temp_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[15]_i_1_n_0\,
      Q => d_temp(15),
      R => '0'
    );
\d_temp_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[1]_i_1_n_0\,
      Q => d_temp(1),
      R => '0'
    );
\d_temp_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[2]_i_1_n_0\,
      Q => d_temp(2),
      R => '0'
    );
\d_temp_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[3]_i_1_n_0\,
      Q => d_temp(3),
      R => '0'
    );
\d_temp_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[4]_i_1_n_0\,
      Q => d_temp(4),
      R => '0'
    );
\d_temp_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[5]_i_1_n_0\,
      Q => d_temp(5),
      R => '0'
    );
\d_temp_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[6]_i_1_n_0\,
      Q => d_temp(6),
      R => '0'
    );
\d_temp_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[7]_i_1_n_0\,
      Q => d_temp(7),
      R => '0'
    );
\d_temp_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[8]_i_1_n_0\,
      Q => d_temp(8),
      R => '0'
    );
\d_temp_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => \d_temp[9]_i_1_n_0\,
      Q => d_temp(9),
      R => '0'
    );
wsd_reg: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => wsd_reg_0,
      Q => \^wsd\,
      R => '0'
    );
wsp_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6F60"
    )
        port map (
      I0 => WS,
      I1 => \^wsd\,
      I2 => RST,
      I3 => wsp,
      O => wsp_i_1_n_0
    );
wsp_reg: unisim.vcomponents.FDRE
     port map (
      C => CLK,
      CE => '1',
      D => wsp_i_1_n_0,
      Q => wsp,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_setup_I2S_interconnect_0_0_I2S_interconnect is
  port (
    WS : out STD_LOGIC;
    BCK : out STD_LOGIC;
    L_RDY : out STD_LOGIC;
    R_RDY : out STD_LOGIC;
    DO_L : out STD_LOGIC_VECTOR ( 15 downto 0 );
    DO_R : out STD_LOGIC_VECTOR ( 15 downto 0 );
    RST : in STD_LOGIC;
    CLK : in STD_LOGIC;
    DI : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of clk_setup_I2S_interconnect_0_0_I2S_interconnect : entity is "I2S_interconnect";
end clk_setup_I2S_interconnect_0_0_I2S_interconnect;

architecture STRUCTURE of clk_setup_I2S_interconnect_0_0_I2S_interconnect is
  signal \^bck\ : STD_LOGIC;
  signal \^ws\ : STD_LOGIC;
  signal clk_mgr_n_4 : STD_LOGIC;
  signal cnt_reg : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \control/_n_0\ : STD_LOGIC;
  signal wsd : STD_LOGIC;
begin
  BCK <= \^bck\;
  WS <= \^ws\;
clk_mgr: entity work.clk_setup_I2S_interconnect_0_0_I2S_CLK_MGR
     port map (
      BCK => \^bck\,
      CLK => CLK,
      L_RDY => L_RDY,
      RST => RST,
      R_RDY => R_RDY,
      WS => \^ws\,
      WS_reg_0 => clk_mgr_n_4,
      wsd => wsd
    );
control: entity work.clk_setup_I2S_interconnect_0_0_I2S_master
     port map (
      CLK => \^bck\,
      DI => DI,
      DO_L(15 downto 0) => DO_L(15 downto 0),
      DO_R(15 downto 0) => DO_R(15 downto 0),
      Q(1 downto 0) => cnt_reg(1 downto 0),
      RST => RST,
      WS => \^ws\,
      \d_temp_reg[15]_0\ => \control/_n_0\,
      wsd => wsd,
      wsd_reg_0 => clk_mgr_n_4
    );
\control/\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => cnt_reg(1),
      I1 => cnt_reg(0),
      O => \control/_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clk_setup_I2S_interconnect_0_0 is
  port (
    CLK : in STD_LOGIC;
    RST : in STD_LOGIC;
    DI : in STD_LOGIC;
    BCK : out STD_LOGIC;
    WS : out STD_LOGIC;
    L_RDY : out STD_LOGIC;
    R_RDY : out STD_LOGIC;
    DO_L : out STD_LOGIC_VECTOR ( 15 downto 0 );
    DO_R : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of clk_setup_I2S_interconnect_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of clk_setup_I2S_interconnect_0_0 : entity is "clk_setup_I2S_interconnect_0_0,I2S_interconnect,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of clk_setup_I2S_interconnect_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of clk_setup_I2S_interconnect_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of clk_setup_I2S_interconnect_0_0 : entity is "I2S_interconnect,Vivado 2024.2";
end clk_setup_I2S_interconnect_0_0;

architecture STRUCTURE of clk_setup_I2S_interconnect_0_0 is
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
inst: entity work.clk_setup_I2S_interconnect_0_0_I2S_interconnect
     port map (
      BCK => BCK,
      CLK => CLK,
      DI => DI,
      DO_L(15 downto 0) => DO_L(15 downto 0),
      DO_R(15 downto 0) => DO_R(15 downto 0),
      L_RDY => L_RDY,
      RST => RST,
      R_RDY => R_RDY,
      WS => WS
    );
end STRUCTURE;
