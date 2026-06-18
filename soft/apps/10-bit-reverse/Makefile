include ../../Makefile.inc 

EXEC=bit_reverse.elf

all: $(EXEC)
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	cp hex/PROGROM.mem ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem ../../../firmware/DATARAM.mem

bit_reverse.elf: ./obj/boot.o       \
				./obj/bit_reverse.o
	$(RV_LD)  -o ./bin/$@ $^ $(LDFLAGS) -L../../libuc -luc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm

./obj/bit_reverse.o: ./src/bit_reverse.c
	$(RV_GCC) $(GCCFLAGS) ./src/bit_reverse.c -c -o ./obj/bit_reverse.o -I../../libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/boot.o : ../shared/boot.S
	$(RV_AS) $(ASFLAGS) ../shared/boot.S -o ./obj/boot.o

clean:
	rm -rf obj/*.o
	rm -rf hex/*.mem
	rm -rf bin/$(EXEC)
	rm -rf asm/$(EXEC).asm
