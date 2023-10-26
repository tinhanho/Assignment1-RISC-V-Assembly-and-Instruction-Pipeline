	.file	"find_msb.c"
	.option nopic
	.attribute arch, "rv32i2p1_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	count_leading_zeros
	.type	count_leading_zeros, @function
count_leading_zeros:
	slli	a4,a1,31
	srli	a5,a0,1
	or	a5,a4,a5
	srli	a4,a1,1
	or	a0,a5,a0
	or	a1,a4,a1
	slli	a4,a1,30
	srli	a5,a0,2
	or	a5,a4,a5
	srli	a2,a1,2
	or	a0,a5,a0
	or	a2,a2,a1
	slli	a4,a2,28
	srli	a5,a0,4
	or	a5,a4,a5
	srli	a3,a2,4
	or	a4,a5,a0
	or	a3,a3,a2
	slli	a2,a3,24
	srli	a5,a4,8
	or	a5,a2,a5
	srli	a2,a3,8
	or	a5,a5,a4
	or	a2,a2,a3
	slli	a3,a2,16
	srli	a4,a5,16
	or	a4,a3,a4
	srli	a3,a2,16
	or	a4,a4,a5
	or	a3,a3,a2
	or	a4,a3,a4
	srli	a5,a4,1
	li	a2,1431654400
	addi	a2,a2,1365
	and	a5,a5,a2
	sub	a5,a4,a5
	sgtu	a4,a5,a4
	sub	a3,a3,a4
	slli	a3,a3,30
	srli	a4,a5,2
	or	a4,a3,a4
	li	a3,858992640
	addi	a3,a3,819
	and	a4,a4,a3
	and	a5,a5,a3
	add	a5,a4,a5
	sltu	a4,a5,a4
	slli	a4,a4,28
	srli	a3,a5,4
	or	a3,a4,a3
	add	a3,a3,a5
	li	a5,252645376
	addi	a5,a5,-241
	and	a3,a3,a5
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
	.size	count_leading_zeros, .-count_leading_zeros
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"Test Data %d:\n"
	.align	2
.LC1:
	.string	"Input: 0x%08lx\n"
	.align	2
.LC2:
	.string	"Leading Zeros: %lu\n"
	.align	2
.LC3:
	.string	"MSB: %lu\n"
	.align	2
.LC4:
	.string	"Test Data %d: Invalid input, cannot calculate MSB.\n"
	.align	2
.LC5:
	.string	"cycle count: %u\n"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sw	ra,76(sp)
	sw	s0,72(sp)
	sw	s1,68(sp)
	sw	s2,64(sp)
	sw	s3,60(sp)
	sw	s4,56(sp)
	sw	s5,52(sp)
	sw	s6,48(sp)
	sw	s7,44(sp)
	sw	s8,40(sp)
	sw	s9,36(sp)
	sw	s10,32(sp)
	sw	s11,28(sp)
	call	get_cycles
	mv	s5,a0
	li	a5,17
	sw	a5,4(sp)
	li	a5,4096
	addi	a5,a5,257
	sw	a5,8(sp)
	li	a5,65536
	addi	a5,a5,17
	sw	a5,12(sp)
	addi	s2,sp,4
	li	s1,1
	li	s4,31
	lui	s11,%hi(.LC4)
	lui	s10,%hi(.LC0)
	lui	s9,%hi(.LC1)
	lui	s8,%hi(.LC2)
	lui	s7,%hi(.LC3)
	li	s6,4
	j	.L5
.L3:
	mv	a1,s1
	addi	a0,s11,%lo(.LC4) # invalid
	call	printf
.L4:
	li	a0,10
	call	putchar
	addi	s1,s1,1
	addi	s2,s2,4
	beq	s1,s6,.L8 # leave loop
.L5:
	lw	s3,0(s2) # load test_data
	mv	a0,s3
	li	a1,0
	call	count_leading_zeros
	mv	s0,a0 # s0 is clz value
	bgtu	a0,s4,.L3
	mv	a1,s1
	addi	a0,s10,%lo(.LC0)
	call	printf
	mv	a1,s3
	addi	a0,s9,%lo(.LC1)
	call	printf
	mv	a1,s0
	addi	a0,s8,%lo(.LC2)
	call	printf
	sub	a1,s4,s0
	addi	a0,s7,%lo(.LC3)
	call	printf
	j	.L4
.L8:
	call	get_cycles
	sub	a1,a0,s5
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	printf
	li	a0,0
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
	addi	sp,sp,80
	jr	ra
	.size	main, .-main
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 13.2.0"
