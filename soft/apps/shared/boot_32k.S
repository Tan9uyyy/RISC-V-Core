#
# A boot sequence designed to be used with the INTR./DATA 32k RAM model.
#
.equ IO_BASE, 0x400000  
.section .text
.globl start
start:
    li   gp,IO_BASE
	li   sp,0x18000
	call main
	ebreak
	