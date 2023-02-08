library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity profiler is
    port(
        clk        : in  std_logic;
        clr        : in  std_logic;
        count_en   : in  std_logic; -- has higher priority than clr
        last_value : out unsigned(15 downto 0) -- 16 bit register
    );
end entity;

architecture profiler_rtl of profiler is
begin
    process(clk) is
        variable buf : unsigned(15 downto 0) := (others => '0');
    begin
        if clk = '1' then
            if count_en = '1' then
                buf := buf + 1;
            elsif clr = '1' then
                buf := (others => '0');
            end if;
        end if;
        last_value <= buf;
    end process;
end architecture;