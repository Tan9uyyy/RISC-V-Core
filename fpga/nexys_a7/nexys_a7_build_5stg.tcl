# You can then run your build script in the same shell:
# 
# > vivado -mode batch -source build.tcl
# 
# If you’d rather Vivado not generate a journal and log files:
# 
# > vivado -mode batch -nolog -nojournal -source build.tcl
# 
# 
# build settings
# 
set design_name "riscv_soc"
set arch "xc7"
set board_name "arty"
set fpga_part "xc7a100tcsg324-1"

# set reference directories for source files
set lib_dir [file normalize "./../../../../lib"]
set origin_dir [file normalize "./../../"]

# read design sources
read_vhdl -vhdl2008 ../src/riscv/riscv_types.vhd
read_vhdl -vhdl2008 ../src/riscv/riscv_config.vhd

read_vhdl -vhdl2008 ../src/riscv/rom/mem_rom_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/ram/mem_ram_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/ram/mem_ram_dp_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/alu/alu_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/decode/decoder_5stg_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/regs/registers_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/imm/immediate_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/store/mem_store_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/load/mem_load_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/csr/csr_registers_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/fetch/fetch_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/addr_stack/addr_stack_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/alu/mult/alu_mult_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/alu/div/alu_div_pkg.vhd
read_vhdl -vhdl2008 ../src/riscv/regs/registers_pass_pkg.vhd

read_vhdl -vhdl2008 ../src/riscv/rom/mem_rom.vhd
read_vhdl -vhdl2008 ../src/riscv/ram/mem_ram.vhd
read_vhdl -vhdl2008 ../src/riscv/ram/mem_ram_dp.vhd
read_vhdl -vhdl2008 ../src/riscv/alu/alu.vhd
read_vhdl -vhdl2008 ../src/riscv/decode/decoder_5stg.vhd
read_vhdl -vhdl2008 ../src/riscv/regs/registers.vhd
read_vhdl -vhdl2008 ../src/riscv/imm/immediate.vhd
read_vhdl -vhdl2008 ../src/riscv/store/mem_store.vhd
read_vhdl -vhdl2008 ../src/riscv/load/mem_load.vhd
read_vhdl -vhdl2008 ../src/riscv/csr/cnt_cycles.vhd
read_vhdl -vhdl2008 ../src/riscv/csr/cnt_instr.vhd
read_vhdl -vhdl2008 ../src/riscv/csr/csr_registers.vhd
read_vhdl -vhdl2008 ../src/riscv/fetch/fetch.vhd
read_vhdl -vhdl2008 ../src/riscv/addr_stack/addr_stack.vhd
read_vhdl -vhdl2008 ../src/riscv/alu/mult/alu_mult.vhd
read_vhdl -vhdl2008 ../src/riscv/alu/div/alu_div.vhd
read_vhdl -vhdl2008 ../src/riscv/regs/registers_pass.vhd

read_vhdl -vhdl2008 ../src/IPs/uart/uart_recv.vhd
read_vhdl -vhdl2008 ../src/IPs/uart/uart_send.vhd

read_vhdl -vhdl2008 ../src/IPs/oled_rgb/pmodoledrgb_bitmap.vhd
read_vhdl -vhdl2008 ../src/IPs/led_rgb/pwm_module.vhd
read_vhdl -vhdl2008 ../src/IPs/led_rgb/led_rgb_ctrl.vhd

read_vhdl -vhdl2008 ../src/IPs/timer/cycle_cnt.vhd
read_vhdl -vhdl2008 ../src/IPs/timer/prog_cnt.vhd
read_vhdl -vhdl2008 ../src/IPs/timer/timer_ctrl.vhd

read_vhdl -vhdl2008 ../src/IPs/clock/fake/clk_wiz_0.vhd

read_vhdl -vhdl2008 ../src/riscv/riscv_5stg.vhd
read_vhdl -vhdl2008 ../src/soc/riscv_5stg_soc.vhd

# read constraints
#read_xdc "${origin_dir}/${arch}/${board_name}.xdc"
read_xdc "./nexys_a7/xdc/Nexys-A7-100T.xdc"

# synth
#synth_design -top "top_${design_name}" -part ${fpga_part}
synth_design -top "riscv_5stg_soc" -part ${fpga_part}

# place and route
opt_design
place_design
route_design

# write bitstream
#write_bitstream -force "${origin_dir}/${arch}/${design_name}.bit"
write_bitstream -force "${design_name}.bit"
