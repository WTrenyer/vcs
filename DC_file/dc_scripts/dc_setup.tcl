#synopsys setup file

set company "Department of microelectronics, Xupt"
set technology "28 nm HLP UMC"



# /apps/EDAs/synopsys/syn/libraries/syn
set search_path " . \
                 /tools/synopsys/syn_O-2018.06syn/libraries/syn \
                 /home/demo/arm/umc/l28hlp/io/58.56.25.242_D_G-9LT-LOGIC_MIXED_MODE28N-HLP_UM028GIOHP25MVSRFS-LIBRARY_TAPE_OUT_KIT-Ver.B07_PB/UM028GIOHP25MVSRFS_B07_TAPEOUTKIT/synopsys                 \
                  /home/demo/arm/umc/l28hlp/sc12mc_base_rvt_c35/UM17LB001-FX-00001-r0p0-01eac0/db-ccs-tn \
                  $search_path "

set target_library "sc12mc_l28hlp_base_rvt_c35_ss_typical_max_0p945v_m40c.db_ccs_tn"

set synthetic_library "dw_foundation.sldb"
#set IO_DIGITAL_library "u028giohp25mvsrfs_225c125_wc.db"
set IO_DIGITAL_library "u028giohp25mvsrfs_225c-40_wc.db"
set link_library " * \
                   $target_library \
                   $synthetic_library \
                   $IO_DIGITAL_library "

#set cache_write "./cache_data/"
#set cache_read "$cache_write"
define_design_lib DEFAULT -path analyzed
alias h history
history keep 100
set verilogout_no_tri true
define_name_rules BORG -allowed {A-Za-z0-9} \
                       -first_restricted "-" \
                       -last_restricted "-" \
                       -max_length 30

set sh_output_log_file   "output.log"

