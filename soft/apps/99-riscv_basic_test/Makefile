include ../../Makefile.inc 

EXEC=riscv_basic_test.elf

all: $(EXEC)
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/firmware.mem
	cp hex/PROGROM.mem  ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem  ../../../firmware/DATARAM.mem
	cp hex/firmware.mem ../../../firmware/firmware.mem

riscv_basic_test.elf: obj/boot.o    \
				 obj/riscv_basic_test.o
	$(RV_LD)  -o ./bin/$@ $^ $(LDFLAGS) -L../../libs/LIBFEMTOC -lfemtoc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm

obj/riscv_basic_test.o: src/riscv_basic_test.c
	$(RV_GCC) $(GCCFLAGS) -O0 src/riscv_basic_test.c -c -o obj/riscv_basic_test.o  -I../../libs/LIBFEMTOC -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

obj/boot.o : ../shared/boot.S
	$(RV_AS) $(ASFLAGS) ../shared/boot.S -o obj/boot.o

clean:
	rm -rf obj/*.o
	rm -rf hex/*.mem
	rm -rf bin/$(EXEC)
	rm -rf asm/$(EXEC).asm