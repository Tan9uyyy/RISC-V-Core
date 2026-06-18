#RV_CCC = riscv64-linux-gnu-gcc
#RV_AS  = riscv64-linux-gnu-as
#RV_LD  = riscv64-linux-gnu-ld
#RV_OBJ = riscv64-linux-gnu-objdump

RV_GCC=riscv64-linux-gnu-gcc-12
RV_AS=riscv64-linux-gnu-as
RV_AR=riscv64-linux-gnu-ar
RV_LD=riscv64-linux-gnu-ld
RV_OBJ=riscv64-linux-gnu-objdump
RV_RANLIB=riscv64-linux-gnu-ranlib

ASFLAGS= -march=rv32i -mabi=ilp32
# -fno-stack-protector -w -Wl,--no-relax -DTIME -DUSE_MYSTDLIB -fno-pic
GCCFLAGS=-march=rv32i -mabi=ilp32 -O2 -DRISCV -fno-stack-protector -DUSE_MYSTDLIB
LDFLAGS=-T linker.ld -m elf32lriscv -nostdlib

firmware_words=../../tools/firmware_words/firmware_words

