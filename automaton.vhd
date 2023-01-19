library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity automaton is
    port(
        clk      : in std_logic;
        rst_n    : in std_logic;
        rd       : out std_logic;
        wr       : out std_logic;
        screen   : out unsigned(7 downto 0);
        addr_bus : out std_logic_vector(4 downto 0);
        data_bus : inout std_logic_vector(7 downto 0)
    );
end entity;

architecture automaton_rtl of automaton is
    -- states signals
    type state is (if1,if2,if3,if4,id1,lda1,lda2,lda3,lda4,sta1,sta2,sta3,sta4,add1,hlt1,nop1);
    signal st : state;
    -- registers
    signal ar : unsigned(4 downto 0);
    signal dr : unsigned(7 downto 0);
    signal pc : unsigned(3 downto 0);
    signal ir : unsigned(2 downto 0);
    signal acc: unsigned(7 downto 0);
begin

    process(clk) is
    begin 
        if rising_edge(clk) then
            if rst_n = '0' then
                addr_bus <= (others => '0');
                data_bus <= (others => '0');
                screen   <= (others => '0');
                rd <= '0';
                wr <= '0';
                ar <= (others => '0');
                dr <= (others => '0');
                pc <= (others => '0');
                ir <= (others => '0');
                acc<= (others => '0');
                st <= if1;
            else
                case st is
                    when if1 =>
                        rd <= '0';
                        wr <= '0';
                        ar <= '0'&pc;
                        st <= if2;
                    when if2 =>
                        rd <= '1';
                        addr_bus <= std_logic_vector(ar);
                        st <= if3;
                    when if3 =>
                        dr <= unsigned(data_bus);
                        pc <= pc + 1;
                        st <= if4;
                    when if4 => 
                        rd <= '0';
                        ir <= dr(7 downto 5); -- opcode
                        st <= id1;
                    when id1 =>
                        case IR is
                            when "000" => -- nop
                                st <= nop1;
                            when "001" => -- halt
                                st <= hlt1;
                            when "010" => -- add
                                st <= add1;
                            when "011" => -- store
                                st <= sta1;
                            when "100" => -- load
                                st <= lda1;
                            when others => -- default
                                st <= nop1;
                        end case;
                    when lda1 =>
                        ar <= '1'&dr(3 downto 0);
                        st <= lda2;
                    when lda2 =>
                        rd <= '1';
                        addr_bus <= std_logic_vector(ar);
                        st <= lda3;
                    when lda3 =>
                        dr <= unsigned(data_bus);
                        st <= lda4;
                    when lda4 =>
                        rd <= '0';
                        acc <= dr;
                        st <= if1;
                    when sta1 =>
                        ar <= '1'&dr(3 downto 0);
                        st <= sta2;
                    when sta2 =>
                        addr_bus <= std_logic_vector(ar);
                        dr <= acc;
                        st <= sta3;
                    when sta3 =>
                        data_bus <= std_logic_vector(dr);
                        st <= sta4;
                    when sta4 =>
                        wr <= '1';
                        st <= if1;
                    when add1 =>
                        acc <= dr(3 downto 2) + dr(1 downto 0);
                        st <= if1;
                    when hlt1 =>
                        pc <= pc-1;
                        st <= if1;
                    when nop1 =>
                        st <= if1;
                    when others => -- impossible to reach
                        st <= nop1;
                end case;
            end if;
        end if;
    end process;

    screen <= acc;

end architecture;