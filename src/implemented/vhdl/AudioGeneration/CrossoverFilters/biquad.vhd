library work;
    use work.filter_constants.all;
    use work.crossover_coef.all;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity biquad is
    generic (
        xbits : integer := 16
    );
    port (
        X    : in  std_logic_vector((xbits - 1) downto 0);
        Y    : out std_logic_vector((xbits - 1) downto 0);
        coef : in  biquad_coef;
        clk  : in  std_logic;
        rst  : in  std_logic
    );
end entity;

architecture DataFlow of biquad is
    constant ybits : integer := 32;
    type Y_arr is array (3 downto - 3) of signed(ybits - 1 downto 0);
    type X_arr is array (3 downto - 3) of signed(X'range);
    signal pe_in  : X_arr;
    signal pe_out : Y_arr;
    signal Y0     : signed(ybits - 1 downto 0);

    component filter_pe is
        generic (
            coefbits : integer := 16;
            xbits    : integer := 24;
            ybits    : integer := 48
        );
        port (
            X    : in  signed((xbits - 1) downto 0);
            Xd   : out signed((xbits - 1) downto 0);
            Y    : out signed((ybits - 1) downto 0);
            coef : in  signed((coefbits - 1) downto 0);
            clk  : in  std_logic;
            rst  : in  std_logic
        );
    end component;

begin

    pe_in(0) <= signed(X);
    --  constants stored in Q1.14, need right shift of 14 bits to kill underflow
    Y0 <= pe_out(- 2) + pe_out(- 1) + pe_out(0) - pe_out(1) - pe_out(2);
    Y  <= std_logic_vector(pe_in(1)) when rst <= '1' else (others => '0');

    filter_pe_x0: filter_pe
        generic map (
            coefbits => cbits,
            xbits    => xbits,
            ybits    => ybits
        )
        port map (
            X    => pe_in(0),
            Xd   => pe_in(- 1),
            Y    => pe_out(0),
            coef => coef(0, 1),
            clk  => clk,
            rst  => rst
        );

    filter_pe_y0: filter_pe
        generic map (
            coefbits => cbits,
            xbits    => X'length,
            ybits    => ybits
        )
        port map (
            X    => Y0(Y0'high downto Y0'high-X'high),
            Xd   => pe_in(1),
            coef => coef(0, 0),
            clk  => clk,
            rst  => rst
        );

    filter_pe_loop: for n in 1 to 2 generate
        filter_pe_pn: filter_pe
            generic map (
                coefbits => cbits,
                xbits    => X'length,
                ybits    => ybits
            )
            port map (
                X    => pe_in(- 1 * n),
                Xd   => pe_in(- 1 * (n + 1)),
                Y    => pe_out(- 1 * n),
                coef => coef(n, 1),
                clk  => clk,
                rst  => rst
            );

        filter_pe_nn: filter_pe
            generic map (
                coefbits => cbits,
                xbits    => X'length,
                ybits    => ybits
            )
            port map (
                X    => pe_in(n),
                Xd   => pe_in((n + 1)),
                Y    => pe_out(n),
                coef => coef(n, 0),
                clk  => clk,
                rst  => rst
            );
    end generate;

end architecture;
