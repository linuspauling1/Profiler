library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eprom is
    generic(
        address_length : positive := 4;
        data_length : positive := 8
    );
    port(
        rd  : in std_logic;
        en  : in std_logic;
        clk : in std_logic;
        address : in std_logic_vector((address_length-1) downto 0);
        data    : out std_logic_vector((data_length-1) downto 0)
    );
end entity;

architecture eprom_rtl of eprom is
    type mem_type is array(0 to (2**address_length-1)) of std_logic_vector((data_length-1) downto 0);
    -- add 0,1
    -- add 1,2
    -- sta 0
    -- add 2,3
    -- sta 5
    -- nop
    -- lda 5
    -- lda 0
    -- hlt
    constant memory : mem_type := (
        "01000001","01001001","01100000","01001011",
        "01100101","00011111","10000101","10000000",
        "00100111","00000000","00000000","00000000",
        "00000000","00000000","00000000","00000000"
    );
begin

    process(clk) is
    begin
        if rising_edge(clk) then
            if en = '1' and rd = '1' then
                data <= memory(to_integer(unsigned(address)));
            else
                data <= (others => 'Z');
            end if;
        end if;
    end process;

end architecture;