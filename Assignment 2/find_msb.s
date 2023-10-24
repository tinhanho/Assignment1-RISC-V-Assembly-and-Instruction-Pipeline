	.file	"find_msb.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	count_exponent
	.type	count_exponent, @function
count_exponent:
	slli	a4,a1,31
	srli	a5,a0,1
	or	a5,a4,a5
	srli	a4,a1,1
	or	a1,a4,a1
	or	a0,a5,a0
	slli	a4,a1,30
	srli	a5,a0,2
	or	a5,a4,a5
	srli	a4,a1,2
	or	a4,a4,a1
	or	a0,a5,a0
	slli	a3,a4,28
	srli	a5,a0,4
	or	a5,a3,a5
	srli	a3,a4,4
	or	a3,a3,a4
	or	a4,a5,a0
	slli	a2,a3,24
	srli	a5,a4,8
	or	a5,a2,a5
	srli	a2,a3,8
	or	a2,a2,a3
	or	a5,a5,a4
	slli	a3,a2,16
	srli	a4,a5,16
	or	a4,a3,a4
	srli	a3,a2,16
	or	a3,a3,a2
	or	a4,a4,a5
	or	a4,a3,a4
	li	a2,1431654400
	srli	a5,a4,1
	addi	a2,a2,1365
	and	a5,a5,a2
	sub	a5,a4,a5
	sgtu	a4,a5,a4
	sub	a3,a3,a4
	slli	a3,a3,30
	srli	a4,a5,2
	li	a2,858992640
	addi	a2,a2,819
	or	a4,a3,a4
	and	a4,a4,a2
	and	a5,a5,a2
	add	a5,a4,a5
	sltu	a4,a5,a4
	slli	a4,a4,28
	srli	a3,a5,4
	or	a3,a4,a3
	li	a4,252645376
	add	a3,a3,a5
	addi	a4,a4,-241
	and	a3,a3,a4
	srli	a4,a3,8
	add	a4,a4,a3
	srli	a5,a4,16
	add	a5,a5,a4
	andi	a5,a5,127
	li	a0,32
	sub	a0,a0,a5
	slli	a0,a0,16
	srli	a0,a0,16
	ret
	.size	count_exponent, .-count_exponent
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"Test Data %d:\n"
	.align	2
.LC1:
	.string	"Input: 0x%08x\n"
	.align	2
.LC2:
	.string	"Leading Zeros: %u\n"
	.align	2
.LC3:
	.string	"MSB: %u\n"
	.align	2
.LC4:
	.string	"Test Data %d: Invalid input, cannot calculate MSB.\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	li	a4,4096
	li	a5,65536
	sw	s8,40(sp)
	sw	s9,36(sp)
	sw	s10,32(sp)
	addi	a4,a4,257
	addi	a5,a5,17
	li	s10,1431654400
	li	s8,858992640
	li	s9,252645376
	li	a3,17
	sw	s0,72(sp)
	sw	s2,64(sp)
	sw	s3,60(sp)
	sw	s4,56(sp)
	sw	s5,52(sp)
	sw	s7,44(sp)
	sw	ra,76(sp)
	sw	s1,68(sp)
	sw	s6,48(sp)
	sw	s11,28(sp)
	sw	a3,4(sp)
	sw	a4,8(sp)
	sw	a5,12(sp)
	addi	s7,sp,4
	li	s5,0
	addi	s10,s10,1365
	addi	s8,s8,819
	addi	s9,s9,-241
	lui	s4,%hi(.LC4)
	lui	s0,%hi(.LC0)
	lui	s3,%hi(.LC1)
	lui	s2,%hi(.LC2)
.L7:
	lw	s6,0(s7)
	li	s11,32
	addi	s5,s5,1
	srli	a5,s6,1
	or	a5,a5,s6
	srli	a4,a5,2
	or	a5,a5,a4
	srli	a4,a5,4
	or	a5,a5,a4
	srli	a4,a5,8
	or	a5,a5,a4
	srli	a4,a5,16
	or	a5,a5,a4
	srli	a4,a5,1
	and	a4,a4,s10
	sub	a4,a5,a4
	sgtu	a5,a4,a5
	neg	a5,a5
	slli	a5,a5,30
	srli	a3,a4,2
	or	a3,a5,a3
	and	a3,a3,s8
	and	a5,a4,s8
	add	a5,a3,a5
	sltu	a3,a5,a3
	srli	a4,a5,4
	slli	a3,a3,28
	or	a4,a3,a4
	add	a4,a4,a5
	and	a4,a4,s9
	srli	a5,a4,8
	add	a4,a4,a5
	srli	a5,a4,16
	add	a5,a5,a4
	andi	a5,a5,127
	sub	s11,s11,a5
	slli	s11,s11,16
	srli	s11,s11,16
	li	s1,31
	addi	a0,s0,%lo(.LC0)
	mv	a1,s5
	bgtu	s11,s1,.L4
	call	printf
	mv	a1,s6
	addi	a0,s3,%lo(.LC1)
	call	printf
	mv	a1,s11
	addi	a0,s2,%lo(.LC2)
	call	printf
	lui	a5,%hi(.LC3)
	sub	a1,s1,s11
	addi	a0,a5,%lo(.LC3)
.L9:
	call	printf
	li	a0,10
	call	putchar
	li	a5,3
	addi	s7,s7,4
	bne	s5,a5,.L7
	lw	ra,76(sp)
	lw	s0,72(sp)
	lw	s1,68(sp)
	lw	s2,64(sp)
	lw	s3,60(sp)
	lw	s4,56(sp)
	lw	s5,52(sp)
	lw	s6,48(sp)
	lw	s7,44(sp)
	lw	s8,40(sp)
	lw	s9,36(sp)
	lw	s10,32(sp)
	lw	s11,28(sp)
	li	a0,0
	addi	sp,sp,80
	jr	ra
.L4:
	addi	a0,s4,%lo(.LC4)
	j	.L9
	.size	main, .-main
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 13.2.0"
