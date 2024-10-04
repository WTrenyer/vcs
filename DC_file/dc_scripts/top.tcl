#date   2017.07.10

source -e -v ../dc_scripts/dc_setup.tcl

set TOP_LEVEL             send_top
set SRC_FILE              ../dc_scripts/read_src.tcl
set CONSTRAINT_FILE       ../dc_scripts/constraints.tcl
set TIMING_CHECK_RPT      ../rpt/$TOP_LEVEL\_timing_check.rpt
set PORT_RPT              ../rpt/$TOP_LEVEL\_port.rpt
set FLATTEN               false
set STRUCTURE             true
set MODULE_COMPILER       true
set AREA_CONSTRAINT       0
set WLM                   segmented
set CRITICAL_RANGE        0.5
set NETLIST_DDC           ../netlist/$TOP_LEVEL.ddc
set NETLIST_V             ../netlist/$TOP_LEVEL.v
set SDC                   ../sdc/$TOP_LEVEL.sdc
set SDF                   ../netlist/$TOP_LEVEL.sdf
set CONSTRAINT_VIOLATION  ../rpt/$TOP_LEVEL\_vio.rpt
set TIMING_RPT            ../rpt/$TOP_LEVEL\_timing.rpt
set TIMING_RPT_MIN            ../rpt/$TOP_LEVEL\_hold_timing.rpt
set TIMING_RPT_NUM        10
set AREA_RPT              ../rpt/$TOP_LEVEL\_area.rpt
set POWER_RPT             ../rpt/$TOP_LEVEL\_power.rpt

set_host_options -max_cores 8

source -e -v $SRC_FILE
set_svf $TOP_LEVEL\.svf
#**************************************************************
current_design $TOP_LEVEL
link
current_design $TOP_LEVEL
uniquify -dont_skip_empty_designs

set set_ultra_optimization true
current_design $TOP_LEVEL
#**************************************************************
source -e -v $CONSTRAINT_FILE
#**************************************************************
redirect  $TIMING_CHECK_RPT {check_timing}
redirect  $PORT_RPT {report_port -verbose}

#**************************************************************
set_flatten $FLATTEN
set_structure $STRUCTURE 
#**************************************************************
#Enables the Synopsys Module Compiler to generate arithmetic DesignWare parts.
set dw_prefer_mc_inside $MODULE_COMPILER
#**************************************************************
set_max_area $AREA_CONSTRAINT
#**************************************************************
set_wire_load_mode $WLM

group_path -name OUTPUTS -to [all_outputs]
group_path -name INPUTS -from [all_inputs]


#**************************************************************
#specifying the critical range to improve more paths#
set_critical_range $CRITICAL_RANGE [get_designs *]

#**************************************************************
#inserts extra logic into the design to ensure that there are no /
# feedthroughs, or that there are no two output ports connected to the same net at any level of hierarchy#
set_fix_multiple_port_nets -buffer_constants -all
#**************************************************************
compile_ultra -timing_high_effort_script -no_autoungroup
#*************************************************************
change_names -rules verilog -hierarchy

write -hierarchy -format ddc -output $NETLIST_DDC
write -hierarchy -format verilog -output $NETLIST_V
write_sdc $SDC
write_sdf $SDF
set_svf off

report_constraints -all_violators -verbose > $CONSTRAINT_VIOLATION
report_timing -max $TIMING_RPT_NUM > $TIMING_RPT
report_timing -delay min -max_paths $TIMING_RPT_NUM -nets -tran -nosplit -input_pins > $TIMING_RPT_MIN
report_area -hierarchy > $AREA_RPT
report_power -hierarchy > $POWER_RPT
