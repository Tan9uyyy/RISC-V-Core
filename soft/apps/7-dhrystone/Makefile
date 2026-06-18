include ../../Makefile.inc 

EXEC=dhrystone.elf

all: $(EXEC)
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	cp hex/PROGROM.mem ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem ../../../firmware/DATARAM.mem

dhrystone.elf:	obj/boot.o    \
				obj/stubs.o   \
				obj/dhry_1.o  \
				obj/dhry_2.o
	$(RV_LD)  -o ./bin/$@ $^ $(LDFLAGS) -L../../libuc -luc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm

obj/stubs.o: src/stubs.c
	$(RV_GCC) $(GCCFLAGS) src/stubs.c -c -o obj/stubs.o -I../../libuc -DTIME

obj/dhry_1.o: src/dhry_1.c src/dhry.h
	$(RV_GCC) $(GCCFLAGS) src/dhry_1.c -c -o obj/dhry_1.o -I../../libuc -DTIME

obj/dhry_2.o: src/dhry_2.c src/dhry.h
	$(RV_GCC) $(GCCFLAGS) src/dhry_2.c -c -o obj/dhry_2.o -I../../libuc -DTIME

obj/boot.o : ../shared/boot.S
	$(RV_AS) $(ASFLAGS) ../shared/boot.S -o obj/boot.o

clean:
	rm -rf obj/*.o
	rm -rf hex/*.mem
	rm -rf bin/$(EXEC)
	rm -rf asm/$(EXEC).asm
