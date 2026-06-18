	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"(II) Result is OK"
	.align	2
.LC1:
	.string	"(II) Result is NOK"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
.L2:
	addi	sp,sp,-16
	lui	a3,%hi(vect)
	addi	a5,a3,%lo(vect)
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	a3,a3,%lo(vect)
	li	a4,0
	li	a2,1000
.L3:
	sw	a4,0(a3)
	addi	a4,a4,1
	addi	a3,a3,4
	bne	a4,a2,.L3
	li	a3,4096
	addi	a3,a3,-96
	add	a3,a5,a3
	li	s0,0
.L4:
	lw	a4,0(a5)
	addi	a5,a5,4
	addi	a4,a4,-10
	add	s0,s0,a4
	bne	a5,a3,.L4
	li	a5,491520
	addi	a5,a5,-2020
	beq	s0,a5,.L11
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	puts
.L1:
	lw	ra,12(sp)
	mv	a0,s0
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.L11:
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	j	.L1
	.size	main, .-main
	.globl	vect
	.globl	SCALAR
	.bss
	.align	2
	.type	vect, @object
	.size	vect, 4000
vect:
	.zero	4000
	.section	.srodata,"a"
	.align	2
	.type	SCALAR, @object
	.size	SCALAR, 4
SCALAR:
	.word	10
	.ident	"GCC: (Ubuntu 12.4.0-2ubuntu1~24.04) 12.4.0"
	.section	.note.GNU-stack,"",@progbits
