library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity system is
    port(
        screen : out unsigned(7 downto 0);
        clk    : in std_logic;
        rst_n  : in std_logic
    );
end entity;

architecture system_rtl of system is
    signal rd : std_logic;
    signal wr : std_logic;
    signal address : std_logic_vector(4 downto 0);
    signal data : std_logic_vector(7 downto 0);
    
    function invert(input : std_logic) return std_logic is
    begin
        return not input;
    end function;
begin
    i_eprom : entity work.eprom(eprom_rtl) port map(
        rd => rd,
        en => invert(address(4)),
        clk => clk,
        address => address(3 downto 0),
        data => data
    );
    i_sram1 : entity work.sram(sram_rtl) port map(
        rd => rd,
        wr => wr,
        en => address(4),
        clk => clk,
        address => address(3 downto 0),
        data => data(7 downto 4)
    );
    i_sram2 : entity work.sram(sram_rtl) port map(
        rd => rd,
        wr => wr,
        en => address(4),
        clk => clk,
        address => address(3 downto 0),
        data => data(3 downto 0)
    );
    i_moore : entity work.automaton(automaton_rtl) port map(
        clk => clk,
        rst_n => rst_n,
        rd => rd,
        wr => wr,
        screen => screen,
        addr_bus => address,
        data_bus => data
    );
end architecture;