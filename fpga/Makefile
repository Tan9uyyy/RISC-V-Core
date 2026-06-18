EXEC=riscv_logo.elf

all: build_riscv_hls build_riscv load_riscv

build_riscv_hls:
	make -C ../hls build_hls export_hls


#build_riscv_cmod_a7: build_riscv_cmod_a7_2023

#
#
# XILINX VITIS 2024.2
#
#

build_riscv_nexys_a7:
	rm -rf ./proj
	vivado -mode batch -nolog -nojournal -source ./nexys_a7/nexys_a7_build.tcl

build_riscv_nexys_a7_5stg:
	rm -rf ./proj
	vivado -mode batch -nolog -nojournal -source ./nexys_a7/nexys_a7_build_5stg.tcl

#
#
# XILINX VITIS 2023.2
#
#

build_riscv_cmod_a7_2024:
	rm -rf ./proj
	vivado -mode batch -nolog -nojournal -source ./cmod_a7/cmod_a7_build.2024.2.tcl

build_riscv_cmod_a7_2023:
	rm -rf ./proj
	vivado -mode batch -nolog -nojournal -source ./cmod_a7/cmod_a7_build.2023.2.tcl

build_riscv_cmod_a7_5stg_2023:
	rm -rf ./proj
	vivado -mode batch -nolog -nojournal -source ./cmod_a7/cmod_a7_build_5stg_2023.2.tcl

build_riscv_20k_a7:
	rm -rf ./proj
	vivado -mode batch -nolog -nojournal -source ./cmod_a7/cmod_a7_build_20k.2023.2.tcl

#
#
# Parties communes
#
#

load_riscv_cmod:
	openFPGALoader -b cmoda7_35t riscv_soc.bit

flash_riscv_cmod_a7:
	openFPGALoader -b cmoda7_35t riscv_soc.bit -f

load_riscv_nexys_a7:
	openFPGALoader -b nexys_a7_100 riscv_soc.bit

flash_riscv_nexys_a7:
	openFPGALoader -b nexys_a7_100 riscv_soc.bit -f

#
#
# YOSYS for TANG NANO 20K
#
#

build_nano20k:
	make -f ./nano20k/Makefile

load_nano20k:
	make -f ./nano20k/Makefile load_fpga

clean:
	rm -rf ./proj
	rm -rf *.bit
	rm -rf *.txt
	rm -rf *.zip
	rm -rf .gen
	rm -rf .srcs/
	rm -rf .Xil/
