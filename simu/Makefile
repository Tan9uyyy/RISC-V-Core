#
#
#
#
########################################################################################################################
#
#
#
#
all: alu_sim
#
#
#
#
########################################################################################################################
#
#
#
#
alu_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/alu_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed alu_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed alu_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
decoder_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/decode/decoder.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/decode/decoder_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed decoder_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed decoder_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
div_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/div/alu_div_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/div/alu_div.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/div/alu_div_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed alu_div_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed alu_div_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
fetch_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/fetch/fetch_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/fetch/fetch.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/fetch/fetch_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed fetch_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed fetch_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
imm_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/imm/immediate_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/imm/immediate.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/imm/immediate_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed immediate_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed immediate_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
load_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/load/mem_load_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/load/mem_load.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/load/mem_load_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed mem_load_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed mem_load_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
mult_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/mult/alu_mult_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/mult/alu_mult.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/alu/mult/alu_mult_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed alu_mult_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed alu_mult_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
ram_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_config.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/ram/mem_ram_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/ram/mem_ram.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/ram/mem_ram_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed mem_ram_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed mem_ram_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
regs_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/regs/registers_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/regs/registers.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/regs/registers_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed registers_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed registers_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
rom_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete
	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_config.vhd 
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/rom/mem_rom_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/rom/mem_rom.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/rom/mem_rom_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed mem_rom_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed mem_rom_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
store_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/store/mem_store_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/store/mem_store.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/store/mem_store_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed mem_store_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed mem_store_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
forward_sim:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	# Analyse des codes VHDL
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/forward/reg_forward_pkg.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/forward/reg_forward.vhd
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/riscv/forward/reg_forward_tb.vhd

	# Elaboration du modele simulable
	ghdl -e --std=08 -frelaxed reg_forward_tb

	# Simulation du modele
	ghdl -r --std=08 -frelaxed reg_forward_tb --wave=trace.ghw --ieee-asserts=disable --max-stack-alloc=0
#
#
#
#
########################################################################################################################
#
#
#
#
riscv:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/strings_h.vhdl
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/regexp_h.vhdl
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/ctype_h.vhdl
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/stdlib_h.vhdl
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/stdio_h.vhdl

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/riscv_config.vhd
	ghdl -a --std=08 -frelaxed ../src/observer.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/rom/mem_rom_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/rom/mem_rom.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/ram/mem_ram_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/ram/mem_ram.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/ram/mem_ram_dp_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/ram/mem_ram_dp.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/alu/alu_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/alu/alu.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/decode/decoder_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/decode/decoder.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/regs/registers_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/regs/registers.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/imm/immediate_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/imm/immediate.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/store/mem_store_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/store/mem_store.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/load/mem_load_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/load/mem_load.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/csr/cnt_cycles.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/csr/cnt_instr.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/csr/csr_registers.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/fetch/fetch_pkg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/fetch/fetch.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/IPs/spi/spi_master.vhd
	ghdl -a --std=08 -frelaxed ../src/IPs/spi/spi_master.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/uart_recv.vhd
	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/uart_send.vhd
	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/clk_wiz_0.vhd
	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/pmodoledrgb_bitmap.vhd
	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/pmodoledrgb_terminal.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/IPs/led_rgb/led_rgb_ctrl.vhd
	ghdl -a --std=08 -frelaxed ../src/IPs/led_rgb/pwm_module.vhd

	ghdl -a --std=08 -frelaxed ../src/IPs/timer/cycle_cnt.vhd
	ghdl -a --std=08 -frelaxed ../src/IPs/timer/prog_cnt.vhd
	ghdl -a --std=08 -frelaxed ../src/IPs/timer/timer_ctrl.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/riscv.vhd
	ghdl -a --std=08 -frelaxed ../src/soc/riscv_soc.vhd
	ghdl -a --std=08 -frelaxed ../testbench/riscv_soc_tb.vhd

	# les composants

	ghdl -e --std=08 -frelaxed riscv_soc_tb

	# Nettoyage des anciens fichiers
	find . -name "*.o"           -delete

	# Simulation du modele RTL
	ghdl -r --std=08 -frelaxed riscv_soc_tb --ieee-asserts=disable --max-stack-alloc=0 --wave=riscv_soc_tb.ghw
#
#
#
#
########################################################################################################################
#
#
#
#
riscv_5stg:
	# Nettoyage des anciens fichiers
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete

	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/strings_h.vhdl
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/regexp_h.vhdl
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/ctype_h.vhdl
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/stdlib_h.vhdl
	ghdl -a --std=08 -fsynopsys -Wno-hide -Wno-shared -frelaxed ../src/tools/stdio_h.vhdl

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/riscv_types.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/riscv_config.vhd
	ghdl -a --std=08 -frelaxed ../src/observer.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/rom/mem_rom.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/rom/mem_rom_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/ram/mem_ram.vhd     # useless
	ghdl -a --std=08 -frelaxed ../src/riscv/ram/mem_ram_pkg.vhd # useless

	ghdl -a --std=08 -frelaxed ../src/riscv/ram/mem_ram_dp.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/ram/mem_ram_dp_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/alu/alu.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/alu/alu_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/alu/mult/alu_mult.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/alu/mult/alu_mult_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/alu/div/alu_div.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/alu/div/alu_div_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/decode/decoder_5stg.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/decode/decoder_5stg_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/regs/registers_pass.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/regs/registers_pass_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/imm/immediate.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/imm/immediate_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/store/mem_store.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/store/mem_store_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/load/mem_load.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/load/mem_load_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/addr_stack/addr_stack.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/addr_stack/addr_stack_pkg.vhd

	ghdl -a --std=08 -frelaxed ../src/riscv/forward/reg_forward.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/forward/reg_forward_pkg.vhd


	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/csr/cnt_cycles.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/csr/cnt_instr.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/csr/csr_registers.vhd
	ghdl -a --std=08 -frelaxed ../src/riscv/csr/csr_registers_pkg.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/fetch/fetch.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/IPs/spi/spi_master.vhd
	ghdl -a --std=08 -frelaxed ../src/IPs/spi/spi_master.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/uart_recv.vhd
	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/uart_send.vhd
	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/clk_wiz_0.vhd
	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/pmodoledrgb_bitmap.vhd
	ghdl -a --std=08 -frelaxed ../testbench/fake_modules/pmodoledrgb_terminal.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/IPs/led_rgb/led_rgb_ctrl.vhd
	ghdl -a --std=08 -frelaxed ../src/IPs/led_rgb/pwm_module.vhd

	ghdl -a --std=08 -frelaxed ../src/IPs/timer/cycle_cnt.vhd
	ghdl -a --std=08 -frelaxed ../src/IPs/timer/prog_cnt.vhd
	ghdl -a --std=08 -frelaxed ../src/IPs/timer/timer_ctrl.vhd

	# les composants

	ghdl -a --std=08 -frelaxed ../src/riscv/riscv_5stg.vhd
	ghdl -a --std=08 -frelaxed ../src/soc/riscv_5stg_soc.vhd
	ghdl -a --std=08 -frelaxed ../testbench/riscv_5stg_soc_tb.vhd

	# les composants

	ghdl -e --std=08 -frelaxed riscv_5stg_soc_tb

	find . -name "*.o"           -delete

	#ghdl -r --std=08 -frelaxed riscv_5stg_soc_tb --ieee-asserts=disable --max-stack-alloc=0
	#ghdl -r --std=08 -frelaxed riscv_5stg_soc_tb --ieee-asserts=disable --max-stack-alloc=0 --vcd=trace.vcd --stop-time=1000us
	ghdl -r --std=08 -frelaxed riscv_5stg_soc_tb --ieee-asserts=disable --max-stack-alloc=0 --stop-time=1000ms
#
#
#
#
########################################################################################################################
#
#
#
#
clean:
	find . -name "work-obj08.cf" -delete
	find . -name "*.o"           -delete
	find . -name "alu_tb"        -delete
	find . -name "alu_div_tb"    -delete
	find . -name "alu_mult_tb"   -delete
	find . -name "decoder_tb"    -delete
	find . -name "fetch_tb"      -delete
	find . -name "immediate_tb"  -delete
	find . -name "mem_store_tb"  -delete
	find . -name "mem_load_tb"   -delete
	find . -name "registers_tb"  -delete

	find . -name "trace.ghw"     -delete
	find . -name "trace.gtw"     -delete
	find . -name "trace.vcd"     -delete
