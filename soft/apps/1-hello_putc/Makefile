include ../../Makefile.inc 

EXEC=hello.elf

all: $(EXEC)
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/PROGROM.mem -from_addr 0x00000 -to_addr 0x0FFFF
	$(firmware_words) ./bin/$(EXEC) -ram 0x20000 -max_addr 0x20000 -out hex/DATARAM.mem -from_addr 0x10000 -to_addr 0x1FFFF
	cp hex/PROGROM.mem ../../../firmware/PROGROM.mem
	cp hex/DATARAM.mem ../../../firmware/DATARAM.mem

hello.elf: obj/hello.o
	$(RV_LD)  -o ./bin/$@ $^ $(LDFLAGS) 
	$(RV_OBJ) -D ./bin/$(EXEC) > ./asm/$(EXEC).asm

obj/hello.o: src/hello.c
	$(RV_GCC) $(GCCFLAGS) src/hello.c -c -o obj/hello.o

clean:
	rm -rf obj/*.o
	rm -rf hex/*.mem
	rm -rf bin/$(EXEC)
	rm -rf asm/$(EXEC).asm