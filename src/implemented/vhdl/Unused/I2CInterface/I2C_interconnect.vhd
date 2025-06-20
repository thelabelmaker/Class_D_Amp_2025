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

library work;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity I2C_interconnect is
    port (
        SDA    : inout std_logic;
        SCL    : in    std_logic;
        dout   : out   std_logic_vector(31 downto 0);
        addr   : out   std_logic_vector(7 downto 0);
        update : out   std_logic;

        clk    : in    std_logic;
        rst    : in    std_logic
    );

end entity;

architecture DataFlow of I2C_interconnect is
    component I2C_rec is
        port (SDA  : inout std_logic;
              SCL  : in    std_logic;
              RST  : in    std_logic;
              DOUT : out   std_logic_vector(39 downto 0);
              DRDY : out   std_logic;
              CLK  : in    std_logic
             );
    end component;

    signal update_async   : std_logic;
    signal update_sync_d : std_logic;
    signal update_sync    : std_logic;
    signal data_async     : std_logic_vector(39 downto 0);

begin
    i2c_interface: I2C_rec
        port map (
            SDA  => SDA,
            SCL  => SCL,
            RST  => RST,
            DOUT => data_async,
            DRDY => update_async,
            CLK  => CLK
        );

    process (clk)
    begin
        if rising_edge(clk) then
            update_sync <= update_async;
            update_sync_d <= update_sync;
            update <=   update_sync_d;
            if update_sync='1' and update_sync_d='0' then
                addr <= data_async(39 downto 32);
                dout <= data_async(31 downto 0);
            end if;
        end if;
    end process;
end architecture;
