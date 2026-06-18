.equ IO_BASE, 0x400000  
.section .text
.globl start
start:
    li   gp,IO_BASE
	li   sp,0x20000

	# led verte
	lui	a5,0x4
	lui	a4,0xd000
	add	a5,a5,1024
	sw	a5,0(a4)

	# call du main
	call main

	# led rouge
	lui	a4,0xd000
  	li	a5,68
  	sw	a5,0(a4)

	# on arrete la simulation
	ebreak

	# boucle infinie au cas ou...
loop:
	jal loop
	