#
# You run the script as before:
#
# > vivado -mode batch -source program-board.tcl
#
open_hw_manager
connect_hw_server
current_hw_target
open_hw_target
set_property PROGRAM.FILE riscv_soc.bit [current_hw_device]
program_hw_devices [current_hw_device]
