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
ghdl -a combinational.vhd
ghdl -e combinational
ghdl -r combinational
ghdl -a profiler.vhd
ghdl -e profiler
ghdl -r profiler
ghdl -a system_profiler.vhd
ghdl -e system_profiler
ghdl -r system_profiler
ghdl -a system_profiler_tb.vhd
ghdl -e system_profiler_tb
ghdl -r system_profiler_tb --stop-time=1us --vcd=hw2.vcd