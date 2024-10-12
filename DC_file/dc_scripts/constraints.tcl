#Date: 2017.07.10
#**************************************************************

create_clock -period 8 -waveform {0  4}  -name clk [get_ports "clk"]

set_clock_uncertainty 0.5  [get_clock clk]

#*****************************************clk input *******************
set_input_delay -max 2.00 -clock clk  [remove_from_collection [all_inputs] [get_ports  "rst_n clk"]]
set_input_delay -min 0.00 -clock clk  [remove_from_collection [all_inputs] [get_ports  "rst_n clk"]]

set_output_delay -max 1.00 -clock clk [remove_from_collection [all_outputs] [get_ports "clk_new"]]
set_output_delay -min 0.00 -clock clk [remove_from_collection [all_outputs] [get_ports "clk_new"]]

#**************************************************************
#set_clock_groups -asynchronous -group {gpio_clk} -group {clk}
#set_clock_groups -asynchronous -group {clk0 clk90 clk180 clk270}

set_ideal_network [get_ports "clk"]

set_ideal_network [get_ports "rst_n"]

set_dont_touch_network [get_ports "clk"]

set_dont_touch_network [get_ports "rst_n"]

set_false_path -from [get_ports "rst_n"]
set_false_path -to   [get_ports "clk_new"]

set verilogout_show_unconnected_pins ture
set_fix_multiple_port_nets -buffer_constants -all

#**************************************************************
#design rule
set MAX_LOAD [load_of sc12mc_l28hlp_base_rvt_c35_ss_typical_max_0p945v_m40c/NAND2B_X0P5M_A12TR_C35/AN]

set_drive 0 rst_n
set_drive 0 clk

#set_driving_cell -lib_cell SUMBFSX  -library u028giohp25mvsrfs_225c125_wc  -from_pin DO -pin PAD  [remove_from_collection [all_inputs] [get_ports "clk rst_n"]]

set_max_capacitance [expr $MAX_LOAD*100] [get_designs *]
set_load [expr $MAX_LOAD*15] [all_outputs] 

set_max_fanout 25 [current_design]
set_max_transition 0.5 [current_design]

set_max_area $AREA_CONSTRAINT

#**************************************************************
#dont use for some drc errors
set_dont_use { sc12mc_l28hlp_base_rvt_c35_ss_typical_max_0p945v_m40c/XOR2_X1M_A12TR_C35  \
               sc12mc_l28hlp_base_rvt_c35_ss_typical_max_0p945v_m40c/NAND3_X1A_A12TR_C35 \
               sc12mc_l28hlp_base_rvt_c35_ss_typical_max_0p945v_m40c/XOR2_X1M_A12TR_C35  \
               sc12mc_l28hlp_base_rvt_c35_ss_typical_max_0p945v_m40c/OA211_X0P5M_A12TR_C35 }




