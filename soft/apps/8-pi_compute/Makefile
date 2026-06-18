include ../../Makefile.inc 

EXEC=main.elf

all: $(EXEC)
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/firmware.mem
	cp hex/PROGROM.mem  ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem  ../../../firmware/DATARAM.mem
	cp hex/firmware.mem ../../../firmware/firmware.mem

main.elf: ./obj/boot.o       \
		  ./obj/main.o
	$(RV_LD)  -o ./bin/$@ $^ $(LDFLAGS) -L../../libuc -luc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm

./obj/main.o: ./src/main.c
	$(RV_GCC) $(GCCFLAGS) ./src/main.c -c -o ./obj/main.o -I../../libuc -DRISCV -DTIME -DUSE_MYSTDLIB -fno-pic

./obj/boot.o : ../shared/boot_leds.S
	$(RV_AS) $(ASFLAGS) ../shared/boot_leds.S -o ./obj/boot.o

clean:
	rm -rf obj/*.o
	rm -rf hex/*.mem
	rm -rf bin/$(EXEC)
	rm -rf asm/$(EXEC).asm