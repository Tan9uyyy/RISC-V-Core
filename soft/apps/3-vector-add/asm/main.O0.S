	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	SCALAR
	.section	.srodata,"a"
	.align	2
	.type	SCALAR, @object
	.size	SCALAR, 4
SCALAR:
	.word	10
	.globl	vect
	.bss
	.align	2
	.type	vect, @object
	.size	vect, 4000
vect:
	.zero	4000
	.section	.rodata
	.align	2
.LC0:
	.string	"(II) Result is OK"
	.align	2
.LC1:
	.string	"(II) Result is NOK"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
.L2:
	sw	zero,-28(s0)
	j	.L3
.L4:
	lui	a5,%hi(vect)
	addi	a4,a5,%lo(vect)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,-28(s0)
	sw	a4,0(a5)
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L3:
	lw	a4,-28(s0)
	li	a5,999
	ble	a4,a5,.L4
	sw	zero,-24(s0)
.L5:
	sw	zero,-20(s0)
	j	.L6
.L7:
	lui	a5,%hi(vect)
	addi	a4,a5,%lo(vect)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	li	a5,10
	sub	a5,a4,a5
	lw	a4,-24(s0)
	add	a5,a4,a5
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L6:
	lw	a4,-20(s0)
	li	a5,999
	ble	a4,a5,.L7
	lw	a4,-24(s0)
	li	a5,491520
	addi	a5,a5,-2020
	bne	a4,a5,.L8
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	j	.L9
.L8:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
.L9:
	lw	a5,-24(s0)
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (Ubuntu 12.4.0-2ubuntu1~24.04) 12.4.0"
	.section	.note.GNU-stack,"",@progbits
