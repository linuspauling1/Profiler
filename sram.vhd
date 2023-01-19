library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sram is
    generic(
        address_length : positive := 4;
        data_length : positive := 4
    );
    port(
        rd  : in std_logic;
        wr  : in std_logic;
        en  : in std_logic;
        clk : in std_logic;
        address : in std_logic_vector((address_length-1) downto 0);
        data    : inout std_logic_vector((data_length-1) downto 0)
    );
end entity;

architecture sram_rtl of sram is
    type mem_type is array(0 to (2**address_length-1)) of std_logic_vector((data_length-1) downto 0);
    signal memory : mem_type;
begin
    process(clk) is
        variable buf : std_logic_vector((data_length-1) downto 0) := (others => 'Z');
    begin
        if rising_edge(clk) then
            buf := (others => 'Z');
            if en = '1' then
                if rd = '1' then -- even if wr is active!
                    buf := memory(to_integer(unsigned(address)));
                elsif wr = '1' then
                    memory(to_integer(unsigned(address))) <= data;
                end if;
            end if;
            data <= buf;
        end if;
    end process;
end architecture;

architecture sram_async of sram is
    type mem_type is array(0 to (2**address_length-1)) of std_logic_vector((data_length-1) downto 0);
    signal memory : mem_type;
begin
    process(rd,en) begin
        if rd = '0' or en = '0' then
            data <= (others => 'Z');
        end if;
    end process;
    process(clk) begin
        if rising_edge(clk) and en = '1' then
            if rd = '1' then -- rd has higher priority than wr
                data <= memory(to_integer(unsigned(address)));
            elsif wr = '1' then -- wr has lower priority than rd
                memory(to_integer(unsigned(address))) <= data;
            end if;
        end if;
    end process;
end architecture;