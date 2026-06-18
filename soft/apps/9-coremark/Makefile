include ../../Makefile.inc 

EXEC=coremark.elf

all: $(EXEC)
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/firmware.mem
	cp hex/PROGROM.mem  ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem  ../../../firmware/DATARAM.mem
	cp hex/firmware.mem ../../../firmware/firmware.mem

coremark.elf: 	./obj/core_list_join.o  \
 		  		./obj/core_main.o       \
 		  		./obj/core_matrix.o     \
 		  		./obj/core_portme.o     \
 		  		./obj/core_state.o      \
 		  		./obj/core_util.o       \
 		  		./obj/ee_printf.o       \
 		  		./obj/perf.o            \
 		  		./obj/mul.o             \
 		  		./obj/div.o             \
		  		./obj/boot.o
	$(RV_LD)  -o ./bin/$@ $^ $(LDFLAGS) -L../../libuc -luc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm

./obj/core_list_join.o: ./src/core_list_join.c
	$(RV_GCC) $(GCCFLAGS) ./src/core_list_join.c -c -o ./obj/core_list_join.o -I../../libs/libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/core_main.o: ./src/core_main.c
	$(RV_GCC) $(GCCFLAGS) ./src/core_main.c -c -o ./obj/core_main.o -I../../libs/libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/core_matrix.o: ./src/core_matrix.c
	$(RV_GCC) $(GCCFLAGS) ./src/core_matrix.c -c -o ./obj/core_matrix.o -I../../libs/libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/core_portme.o: ./src/core_portme.c
	$(RV_GCC) $(GCCFLAGS) ./src/core_portme.c -c -o ./obj/core_portme.o -I../../libs/libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/core_state.o: ./src/core_state.c
	$(RV_GCC) $(GCCFLAGS) ./src/core_state.c -c -o ./obj/core_state.o -I../../libs/libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/core_util.o: ./src/core_util.c
	$(RV_GCC) $(GCCFLAGS) ./src/core_util.c -c -o ./obj/core_util.o -I../../libs/libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/ee_printf.o: ./src/ee_printf.c
	$(RV_GCC) $(GCCFLAGS) ./src/ee_printf.c -c -o ./obj/ee_printf.o -I../../libs/libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

obj/mul.o : ../shared/mul.S
	$(RV_AS) $(ASFLAGS) ../shared/mul.S -o obj/mul.o

obj/div.o : ../shared/div.S
	$(RV_AS) $(ASFLAGS) ../shared/div.S -o obj/div.o

./obj/perf.o : ./src/perf.S
	$(RV_AS) $(ASFLAGS) ./src/perf.S -o ./obj/perf.o

./obj/boot.o : ../shared/boot_leds.S
	$(RV_AS) $(ASFLAGS) ../shared/boot_leds.S -o ./obj/boot.o

clean:
	rm -rf obj/*.o
	rm -rf hex/*.mem
	rm -rf bin/$(EXEC)
	rm -rf asm/$(EXEC).asm