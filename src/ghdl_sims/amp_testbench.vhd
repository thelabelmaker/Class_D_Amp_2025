----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2025 05:57:16 PM
-- Design Name: 
-- Module Name: sim_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.I2S_constants.all;
--use work.I2S_interconnect.all;
--use work.I2S_interconnect.all;

use IEEE.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity amp_testbench is
end amp_testbench;

architecture Behavioral of amp_testbench is


component I2S_interconnect is
    Port ( CLK  : in STD_LOGIC;
           RST  : in STD_LOGIC;
           DI   : in STD_LOGIC;
           BCK  : out STD_LOGIC;
           WS   : out STD_LOGIC;
           L_RDY    : out STD_LOGIC;
           R_RDY    : out STD_LOGIC;
           DO_L     : out STD_LOGIC_VECTOR(15 downto 0);
           DO_R     : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component SigmaDelta is generic(nbits : integer := 8);
    port(
        --  raw audio input
        X   :   in      std_logic_vector((nbits-1) downto 0);

        --  quantized output
        Y   :   buffer  std_logic   :=  '0';

        --  global clock input
        clk :   in      std_logic;

        dclk    :   in  std_logic
    );
end component;

component SigmaDeltaSim is generic( nbits : integer := 8; 
                                    outb  : integer := 8);
    port(
        --  raw audio input
        X   :   in      std_logic_vector((nbits-1) downto 0);

        --  quantized output
        Y   :   buffer  std_logic_vector((outb-1) downto 0);

        --  global clock input
        clk :   in      std_logic;

        dclk    :   in  std_logic
    );
end component;

component SMA_Decimator is generic (   inbits  : integer := 1;
                                    outbits : integer := 5);
    port(
        X   :   in  std_logic_vector((inbits-1) downto 0);
        Y   :   out std_logic_vector((outbits-1) downto 0);
        clk :   std_logic
    );
end component;

component PWM_output is 
    Port ( SCLK : in STD_LOGIC;
           DCLK : out STD_LOGIC;
           SDCLK: out std_logic;
           DIN : in STD_LOGIC_VECTOR ((PWM_B-1) downto 0);
           EN : out STD_LOGIC;
           RST : in STD_LOGIC);
end component;


signal  clk :   STD_LOGIC;
signal  bclk:   STD_LOGIC;
signal  WS  :   STD_LOGIC;
signal  DI  :   STD_LOGIC   :=  '0';
signal  pwm :   STD_LOGIC;
signal  rst :   STD_LOGIC;
signal pwclk:   STD_LOGIC;
signal sl   :   STD_LOGIC;
signal sr   :   STD_LOGIC;

signal  DL  :   std_logic_vector(15 downto 0):=	(others => '0');
signal  DR  :   std_logic_vector(15 downto 0):=	(others => '0');

signal  DLI :   std_logic_vector(15 downto 0):=	(others => '0');
signal  DRI :   std_logic_vector(15 downto 0):=	(others => '0');

signal ENL  :   STD_LOGIC;
signal ENR  :   STD_LOGIC;


signal SDOLV:   std_logic_vector(0 downto 0):=	(others => '0');
signal SDORV:   std_logic_vector(0 downto 0):=	(others => '0');

signal PWM_INL  :   std_logic_vector((PWM_B-1) downto 0) :=	(others => '0');
signal PWM_INR  :   std_logic_vector((PWM_B-1) downto 0) :=	(others => '0');

signal SD_CLK_L  :   std_logic;
signal SD_CLK_R  :   std_logic;


begin
    MGR : I2S_interconnect port map(
        CLK => clk,
        BCK => bclk,
        WS  => WS,
        DI  => DI, 
        RST =>  rst,
        L_RDY   => sl,
        R_RDY   => sr,
        DO_L    => DL,
        DO_R    => DR
    );

    -- SDL: SigmaDelta
    -- generic map (
    --   nbits => 16
    -- )
    -- port map (
    --   X   => DL,
    --   Y   => SDOL,
    --   clk => clk,
    --   dclk => sl
    -- );

    -- SDR: SigmaDelta
    -- generic map (
    --   nbits => 16
    -- )
    -- port map (
    --   X   => DR,
    --   Y   => SDOR,
    --   clk => clk,
    --   dclk => sr
    -- );

    SDTL: SigmaDeltaSim
    generic map (
      nbits => AUD_B,
      outb  => PWM_B
    )
    port map (
      X   => DL,
      Y   => PWM_INL,
      clk => SD_CLK_L,
      dclk => sl
    );

    SDTR: SigmaDeltaSim
    generic map (
      nbits => AUD_B,
      outb  => PWM_B
    )
    port map (
      X   => DR,
      Y   => PWM_INR,
      clk => SD_CLK_R,
      dclk => sr
    );

    -- DEC_L : SMA_Decimator generic map ( 
    --     inbits => 1,
    --     outbits => 5
    -- )
    -- port map(
    --     X => SDOLV,
    --     Y => PWM_INL,
    --     clk => clk
    -- );
    
    -- DEC_R : SMA_Decimator generic map ( 
    --     inbits => 1,
    --     outbits => 5
    -- )
    -- port map(
    --     X => SDORV,
    --     Y => PWM_INR,
    --     clk => clk
    -- );

    PWL : PWM_output port map(
        SCLK => clk,
        DCLK => sl,
        SDCLK => SD_CLK_L,
        DIN => PWM_INL,
        EN => ENL,
        RST => rst
    );
    
    PWR : PWM_output port map(
        SCLK => clk,
        DCLK => sr,
        SDCLK => SD_CLK_R,
        DIN => PWM_INR,
        EN => ENR,
        RST => rst
    );
    
    


    process
    begin
    rst <= '1';
    wait for 100*MCLK_T;
    rst <= '0';
    wait for 100*MCLK_T;
    rst <= '1';
    wait until rising_edge(WS);
    wait until falling_edge(bclk);
    for k in -32000 to 32000 loop 
        DLI <= std_logic_vector(to_signed(integer(32000.0*sin(real(1*k)/(2.0*math_pi*22.0))), DLI'length));
        for b in DLI'high downto 0 loop
            wait until falling_edge(bclk);
            DI  <=  DLI(b);
        end loop;
        DI <=   DLI(0);
        DRI <= std_logic_vector(to_signed(integer(32000.0*sin(real(-1*k)/(2.0*math_pi*22.0))), DRI'length));
        for b in DRI'high downto 0 loop
            wait until falling_edge(bclk);
            DI  <=  DRI(b);
        end loop;
    end loop;
    
    wait for 1000 ms;
    end process;
    
    CLOCK_CLK : process
    begin
        -- this process generates a clock with a 22.6MHz frequency and 50% duty 
        -- cycle stop the clock when end of simulation is reached
        clk <= '0';
        wait for MCLK_T / 2;
        clk <= '1';
        wait for MCLK_T / 2;
    end process;

end Behavioral;
