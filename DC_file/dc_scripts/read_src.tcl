#module:  (15 files)
#.synopsys_dc.setup
set all_src " 
        ALU.v	/  
        control.v  	/
        ins_mem.v  	/
        mem_file.v  	/
        register_file.v /  
        top.v		/
        top_tb.sv	

               "

    
set src_path "../src/"

foreach src $all_src {
    analyze -format verilog -lib WORK $src_path$src
    regexp {(\w+)\.v} $src_path$src String MODULE_NAME
    elaborate $MODULE_NAME -arch "verilog" -lib WORK -update
}

