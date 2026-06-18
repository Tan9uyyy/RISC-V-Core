include ../../Makefile.clang 

EXEC=riscv_logo.elf

all: $(EXEC)
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	cp hex/PROGROM.mem ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem ../../../firmware/DATARAM.mem

riscv_logo.elf: ./obj/fx_rv32i.o   \
				./obj/fx_zicond.o  \
 				./obj/boot.o       \
 				./obj/main.o
	$(RV_LD)  -o ./bin/$@ $^ $(LDFLAGS) -L../../libuc -luc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm

./obj/fx_rv32i.o: ./src/fx_rv32i.c
	$(RV_GCC) $(GCCFLAGS) ./src/fx_rv32i.c -c -o ./obj/fx_rv32i.o -I../../libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/fx_zicond.o: ./src/fx_zicond.c
	$(RV_GCC) $(GCCFLAGS) ./src/fx_zicond.c -c -o ./obj/fx_zicond.o -I../../libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic -march=rv32i_zicond1 -menable-experimental-extensions

./obj/main.o: ./src/main.c
	$(RV_GCC) $(GCCFLAGS) ./src/main.c -c -o ./obj/main.o -I../../libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/boot.o : ../shared/boot.S
	$(RV_AS) $(ASFLAGS) ../shared/boot.S -o ./obj/boot.o

clean:
	rm -rf obj/*.o
	rm -rf hex/*.mem
	rm -rf bin/$(EXEC)
	rm -rf asm/$(EXEC).asm
