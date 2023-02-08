library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity combinational is
    port(
        count_en : in std_logic;
        rst_n   : in std_logic;
        output   : out std_logic
    );
end entity;

architecture combinational_rtl of combinational is
begin
    output <= count_en and rst_n;
end architecture;