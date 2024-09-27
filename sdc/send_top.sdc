###################################################################

# Created by write_sdc on Thu Sep 26 23:13:11 2024

###################################################################
set sdc_version 2.1

set_units -time ns -resistance 1.000000e+04kOhm -capacitance 1.000000e-04pF    \
-voltage V -current uA
set_wire_load_mode segmented
set_max_area 0
set_max_transition 0.5 [current_design]
set_max_fanout 25 [current_design]
set_max_capacitance 0 [current_design]
set_load -pin_load 0 [get_ports led]
set_ideal_network [get_ports clk]
create_clock [get_ports clk]  -period 8  -waveform {0 4}
set_clock_uncertainty 0.5  [get_clocks clk]
group_path -name INPUTS  -from [list [get_ports clk] [get_ports res_clk] [get_ports rst]]
group_path -name OUTPUTS  -to [get_ports led]
set_input_delay -clock clk  -max 2  [get_ports res_clk]
set_input_delay -clock clk  -min 0  [get_ports res_clk]
set_input_delay -clock clk  -max 2  [get_ports rst]
set_input_delay -clock clk  -min 0  [get_ports rst]
set_output_delay -clock clk  -max 1  [get_ports led]
set_output_delay -clock clk  -min 0  [get_ports led]
