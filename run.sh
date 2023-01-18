ghdl -a eprom.vhd
ghdl -e eprom
ghdl -r eprom
ghdl -a sram.vhd
ghdl -e sram
ghdl -r sram
ghdl -a automaton.vhd
ghdl -e automaton
ghdl -r automaton
ghdl -a system.vhd
ghdl -e system
ghdl -r system
ghdl -a system_tb.vhd
ghdl -e system_tb
ghdl -r system_tb --stop-time=1us --vcd=hw.vcd