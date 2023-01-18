library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity system_tb is
end entity;

architecture tb of system_tb is
    signal screen : unsigned(7 downto 0);
    signal clk    : std_logic := '0';
    signal rst_n  : std_logic := '0';
begin
    i_system : entity work.system(system_rtl) port map(
        screen => screen,
        clk    => clk,
        rst_n  => rst_n
    );
    process begin
        rst_n <= '1' after 18 ns;
        wait;
    end process;
    process begin
        wait for 5 ns; -- period = 10 ns
        clk <= not clk;
    end process;
end architecture;