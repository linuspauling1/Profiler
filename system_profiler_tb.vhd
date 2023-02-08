library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity system_profiler_tb is
end entity;

architecture sp_tb of system_profiler_tb is
    signal screen     : unsigned(7 downto 0);
    signal last_value : unsigned(15 downto 0);
    signal clk        : std_logic := '0';
    signal rst_n      : std_logic := '0';
    signal clr        : std_logic := '0';
    signal count_en   : std_logic := '0';
begin
    i_system_profiler : entity work.system_profiler(system_profiler_rtl) port map(
        screen     => screen,
        last_value => last_value,
        clk        => clk,
        rst_n      => rst_n,
        clr        => clr,
        count_en   => count_en
    );
    process begin
        rst_n <= '1' after 18 ns;
        wait;
    end process;
    process begin
        count_en <= '1' after 18 ns;
        wait for 100 ns;
        count_en <= '0';
        wait;
    end process;
    process begin
        clr <= '0' after 10 ns;
        wait for 200 ns;
        clr <= '1';
        wait;
    end process;
    process begin
        wait for 5 ns; -- period = 10 ns
        clk <= not clk;
    end process;
end architecture;