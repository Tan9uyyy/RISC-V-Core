include ../../Makefile.inc 

EXEC=main.elf

all: $(EXEC)
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	cp hex/PROGROM.mem ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem ../../../firmware/DATARAM.mem

32k:
	$(RV_GCC) $(GCCFLAGS) ./src/main.c -c -o ./obj/main.o -I../libs/libuc -fno-pic
	$(RV_AS)  $(ASFLAGS) ../shared/boot_32k.S -o ./obj/boot.o
	$(RV_LD)  -o ./bin/$(EXEC) obj/main.o obj/boot.o $(LDFLAGS) -L../libs/libuc -luc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x07FFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x17FFF
	cp hex/PROGROM.mem ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem ../../../firmware/DATARAM.mem

48k:
	$(RV_GCC) $(GCCFLAGS) ./src/main.c -c -o ./obj/main.o -I../../libuc -fno-pic
	$(RV_AS)  $(ASFLAGS) ../shared/boot_48k.S -o ./obj/boot.o
	$(RV_LD)  -o ./bin/$(EXEC) obj/main.o obj/boot.o $(LDFLAGS) -L../../libuc -luc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x03FFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	cp hex/PROGROM.mem ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem ../../../firmware/DATARAM.mem

main.elf: ./obj/boot.o       \
				./obj/main.o
	$(RV_LD)  -o ./bin/$@ $^ $(LDFLAGS) -L../../libuc -luc
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm

./obj/main.o: ./src/main.c
	$(RV_GCC) $(GCCFLAGS) ./src/main.c -c -o ./obj/main.o -I../../libuc -fno-pic
	$(RV_GCC) $(GCCFLAGS) ./src/main.c -O0 -S -o ./asm/main.O0.S -I../../libuc -fno-pic
	$(RV_GCC) $(GCCFLAGS) ./src/main.c -O2 -S -o ./asm/main.O2.S -I../../libuc -fno-pic

./obj/boot.o : ../shared/boot.S
	$(RV_AS) $(ASFLAGS) ../shared/boot.S -o ./obj/boot.o

clean:
	rm -rf obj/*.o
	rm -rf hex/*.mem
	rm -rf bin/$(EXEC)
	rm -rf asm/$(EXEC).asm
