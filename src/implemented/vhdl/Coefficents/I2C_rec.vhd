----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 05:37:09 AM
-- Design Name: 
-- Module Name: I2C_rec - Behavioral
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
    use IEEE.STD_LOGIC_1164.all;
    use IEEE.NUMERIC_STD.all;

    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;

entity I2C_rec is
    port (SDA  : inout STD_LOGIC;
          SCL  : in    STD_LOGIC;
          RST  : in    STD_LOGIC;
          DOUT : out   STD_LOGIC_VECTOR(47 downto 0);
          DRDY : out   STD_LOGIC;
          CLK  : in    STD_LOGIC
         );
end entity;

architecture Behavioral of I2C_rec is

    signal b_buff : std_logic_vector(7 downto 0);
    signal d_buff : std_logic_vector(DOUT'range);

    --type BUS_FSM is array(1 downto 0) of std_logic;
    type BUS_FSM is array (3 downto 0) of std_logic;
    constant IDLE        : BUS_FSM := x"0";
    constant LISTEN_ADDR : BUS_FSM := x"1";
    constant ACK_ADDR    : BUS_FSM := x"2";
    constant RD_DATA     : BUS_FSM := x"3";
    constant ACK_DATA    : BUS_FSM := x"4";
    constant DATA_DONE   : BUS_FSM := x"5";
    signal BUS_STATE : BUS_FSM := IDLE;

    constant N_BYTES : integer := 6;

    signal bit_cntr  : integer range 0 to 7;
    signal byte_cntr : integer range 0 to 5;

    signal ACK : std_logic;
    signal SDI : std_logic;

    constant I2C_ADDR : std_logic_vector(7 downto 0) := x"10";
begin

    SDA <= ACK when BUS_STATE = ACK_ADDR or BUS_STATE = ACK_DATA else
           'Z';
    SDI <= SDA;

    process (SCL, SDA)
    begin
        if rising_edge(SDA) and SCL = '1' then
            BUS_STATE <= IDLE;
            bit_cntr <= 7;

        elsif falling_edge(SDA) and SCL = '1' then
            BUS_STATE <= LISTEN_ADDR;
            bit_cntr <= 7;

        elsif rising_edge(SCL) then
            case (BUS_STATE) is
                when IDLE =>
                    ACK <= 'Z';
                when LISTEN_ADDR =>
                    d_buff(bit_cntr) <= SDA;
                    if bit_cntr = 0 then
                        BUS_STATE <= ACK_ADDR;
                    else
                        BUS_STATE <= LISTEN_ADDR;
                        bit_cntr <= bit_cntr - 1;
                    end if;
                when RD_DATA =>
                    b_buff(bit_cntr) <= SDA;
                    if bit_cntr = 0 then
                        BUS_STATE <= ACK_DATA;
                        bit_cntr <= 7;
                    else
                        BUS_STATE <= RD_DATA;
                        bit_cntr <= bit_cntr - 1;
                    end if;
                when others =>
                    BUS_STATE <= BUS_STATE;
            end case;
        end if;

        if falling_edge(SCL) then
            case BUS_STATE is
                when ACK_ADDR =>
                    bit_cntr <= 7;
                    if b_buff = I2C_ADDR then
                        if bit_cntr = 0 then
                            ACK <= '0';
                            BUS_STATE <= ACK_ADDR;
                        else
                            ACK <= 'Z';
                            BUS_STATE <= RD_DATA;
                        end if;
                    else
                        ACK <= 'Z';
                        BUS_STATE <= IDLE;
                    end if;

                when ACK_DATA =>
                    bit_cntr <= 7;
                    if bit_cntr = 0 then
                        ACK <= '0';
                    else
                        ACK <= 'Z';
                        BUS_STATE <= RD_DATA;
                        byte_cntr <= byte_cntr - 1;
                    end if;
                when others =>
                    BUS_STATE <= BUS_STATE;
            end case;
        end if;
    end process;

    process (CLK)
    begin
        if rising_edge(CLK) then
            if BUS_STATE = IDLE then
                DRDY <= '1';
            else
                DRDY <= '0';
            end if;

        end if;
    end process;

end Behavioral;
