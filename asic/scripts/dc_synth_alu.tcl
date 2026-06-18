rm -rf  BODY ARCH dc ENTI obj PACK *.syn *.mr

set target_library [list /usr/local/DesignKit/hcmos9gp_920/CORE9GPLL_SNPS_AVT_4.1/SNPS/common/SYMBOL/CORE9GPLL.sdb	]
set link_library   [list /usr/local/DesignKit/hcmos9gp_920/CORE9GPLL_SNPS_AVT_4.1/SNPS/common/SYMBOL/CORE9GPLL.sdb	]

set hcmos9gp /usr/local/DesignKit/hcmos9gp_920/CORE9GPLL_SNPS_AVT_4.1/SNPS/bc_1.32V_0C_wc_1.08V_105C/PHS/CORE9GPLL_Nom.db 
set search_path    "$search_path"
set target_library "$hcmos9gp"
set link_library   "* $hcmos9gp"
set symbol_library "/usr/local/DesignKit/hcmos9gp_920/CORE9GPLL_SNPS_AVT_4.1/SNPS/common/SYMBOL/CORE9GPLL.sdb"

echo "\n\nSettings:"
echo "search_path:       $search_path"
echo "link_library:      $link_library"
echo "target_library:    $target_library"
echo "symbol_library:    $symbol_library"

analyze -library WORK -format vhdl { ../src/riscv_types.vhd }
analyze -library WORK -format vhdl { ../src/alu.vhd         }

#	COMPILATION NORMALE

elaborate ALU -architecture ARCH -library DEFAULT
#create_clock clk -name my_clock  -period 10
compile -exact_map -area_effort med -power_effort med -auto_ungroup area
uplevel #0 { report_cell } > area_report_normal_alu.txt
uplevel #0 { report_timing -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group } > timing_report_normal_alu.txt

#	COMPILATION ULTRA

set_ungroup ALU
set_scan_configuration -style none
set_flatten true -design ALU -effort high -minimize single_output -phase false
set_structure true -design ALU -boolean true -timing true
set_scan_configuration -style none

compile_ultra
uplevel #0 { report_cell } > area_report_ultra_alu.txt
uplevel #0 { report_timing -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group } > timing_report_ultra_alu.txt

quit
exit
