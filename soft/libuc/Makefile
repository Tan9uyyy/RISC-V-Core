include ../Makefile.inc 

#RVGCC=riscv-none-elf-gcc 
#RVAR=riscv-none-elf-ar
#RVRANLIB=riscv-none-elf-ranlib
CFLAGS=-march=rv32i -mabi=ilp32 -O2 -nostdlib -fno-stack-protector -w -Wl,--no-relax

#PATH_I=-I../../libs/LIBFEMTOC -DRISCV -DTIME -DUSE_MYSTDLIB
#PATH_L=-L../../libs/LIBFEMTOC -L../../libs/LIBFEMTORV32

%ASFLAGS= -march=rv32i -mabi=ilp32

#CC=riscv-none-elf-gcc
#AS=riscv-none-elf-as
#LK=riscv-none-elf-ld

#ASFLAGS= -march=rv32i -mabi=ilp32
#GCCFLAGS=-march=rv32i -mabi=ilp32 -O2 -fno-stack-protector -w -Wl,--no-relax  -fno-pic
#LDFLAGS=-T linker.ld -m elf32lriscv -nostdlib -L../../libs/LIBFEMTOC -L../../libs/LIBFEMTORV32 -L../../libs/LIBFEMTOGL -lfemtoc

all: libuc.a 

libuc.a: 	obj/print.o        \
			obj/printf.o       \
			obj/led_rgb.o      \
			obj/oled_screen.o  \
			obj/timer.o        \
			obj/clz.o     \
			obj/memcpy.o  \
			obj/strcmp.o  \
			obj/strlen.o  \
			obj/strncpy.o \
			obj/memset.o  \
			obj/random.o  \
			obj/strcpy.o  \
			obj/strncmp.o \
			obj/mul.o     \
			obj/div.o 
	$(RV_AR) rcs libuc.a $^
	$(RV_RANLIB) libuc.a
	$(RV_OBJ) -D libuc.a > ./asm/libuc.asm

obj/print.o : ./src/print.c
	$(RV_GCC) $(CFLAGS) ./src/print.c -c -o obj/print.o $(PATH_L)

obj/printf.o : ./src/printf.c
	$(RV_GCC) $(CFLAGS) ./src/printf.c -c -o obj/printf.o $(PATH_L)

obj/clz.o : ./src/clz.c
	$(RV_GCC) $(CFLAGS) ./src/clz.c -c -o obj/clz.o $(PATH_L)

obj/memcpy.o : ./src/memcpy.c
	$(RV_GCC) $(CFLAGS) ./src/memcpy.c -c -o obj/memcpy.o $(PATH_L)

obj/strcmp.o : ./src/strcmp.c
	$(RV_GCC) $(CFLAGS) ./src/strcmp.c -c -o obj/strcmp.o $(PATH_L)

obj/strlen.o : ./src/strlen.c
	$(RV_GCC) $(CFLAGS) ./src/strlen.c -c -o obj/strlen.o $(PATH_L)

obj/strncpy.o : ./src/strncpy.c
	$(RV_GCC) $(CFLAGS) ./src/strncpy.c -c -o obj/strncpy.o $(PATH_L)

obj/memset.o : ./src/memset.c
	$(RV_GCC) $(CFLAGS) ./src/memset.c -c -o obj/memset.o $(PATH_L)

obj/random.o : ./src/random.c
	$(RV_GCC) $(CFLAGS) ./src/random.c -c -o obj/random.o $(PATH_L)

obj/strcpy.o : ./src/strcpy.c
	$(RV_GCC) $(CFLAGS) ./src/strcpy.c -c -o obj/strcpy.o $(PATH_L)

obj/strncmp.o : ./src/strncmp.c
	$(RV_GCC) $(CFLAGS) ./src/strncmp.c -c -o obj/strncmp.o $(PATH_L)

obj/mul.o : ./src/mul.S
	$(RV_GCC) $(CFLAGS) ./src/mul.S -c -o obj/mul.o $(PATH_L)

obj/div.o : ./src/div.S
	$(RV_GCC) $(CFLAGS) ./src/div.S -c -o obj/div.o $(PATH_L)

obj/led_rgb.o : ./src/led_rgb.c
	$(RV_GCC) $(CFLAGS) ./src/led_rgb.c -c -o obj/led_rgb.o $(PATH_L)

obj/oled_screen.o : ./src/oled_screen.c
	$(RV_GCC) $(CFLAGS) ./src/oled_screen.c -c -o obj/oled_screen.o $(PATH_L)

obj/timer.o : ./src/timer.c
	$(RV_GCC) $(CFLAGS) ./src/timer.c -c -o obj/timer.o $(PATH_L)

clean:
	rm -rf ./obj/*.o
	rm -rf ./libfemtoc.a
