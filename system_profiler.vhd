library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity system_profiler is
    port(
        screen     : out unsigned(7 downto 0);
        last_value : out unsigned(15 downto 0);
        clk        : in std_logic;
        rst_n      : in std_logic; -- for system module
        clr        : in std_logic; -- for profiler
        count_en   : in std_logic
    );
end entity;

architecture system_profiler_rtl of system_profiler is
    signal wire : std_logic;
begin
    i_combinational : entity work.combinational(combinational_rtl) port map(
        count_en => count_en,
        rst_n    => rst_n,
        output   => wire
    );
    i_system : entity work.system(system_rtl) port map(
        screen => screen,
        clk    => clk,
        rst_n  => rst_n
    );
    i_profiler : entity work.profiler(profiler_rtl) port map(
        clk        => clk,
        clr        => clr,
        count_en   => wire,
        last_value => last_value
    );
end architecture;