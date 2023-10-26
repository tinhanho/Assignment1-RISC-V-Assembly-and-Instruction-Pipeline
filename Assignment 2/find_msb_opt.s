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
	srli t0, a0, 1 # t0 = x>>1
	or a0, a0, t0 # x |= (x >> 1); 
	srli t0, a0, 2 # x>>2
	or a0, a0, t0 
	srli t0, a0, 4 # x>>4
	or a0, a0, t0
	srli t0, a0, 8 # x>>8
	or a0, a0, t0
	srli t0, a0, 16 # x>>16
	or a0, a0, t0
	li t5, 0x55555555
	srli t0, a0, 1 # x>>1
	and t0, t0, t5 # (x >> 1) & 0x55555555
	sub a0, a0, t0
	li t5, 0x33333333
	srli t0, a0, 2 # x>>2
	and t0, t0, t5 # (x >> 2) & 0x33333333
	and t1, a0, t5 # x & 0x33333333
	add a0, t0, t1 
	li t5, 0x0f0f0f0f
	srli t0, a0, 4 # x>>4
	add t0, a0, t0
	and a0, t0, t5 
	srli t0, a0, 8 # x>>8
	add a0, a0, t0
	srli t0, a0, 16 # x>>16
	add a0, a0, t0
	li t5, 0x0000007f
	and a0, a0, t5 
	sub a0, x0, a0
	addi a0, a0, 32
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
	li	s4,31
	li s1,1
	lui	s11,%hi(.LC4)
	lui	s10,%hi(.LC0)
	lui	s9,%hi(.LC1)
	lui	s8,%hi(.LC2)
	lui	s7,%hi(.LC3)
.L5:
	# loop 1
	li s1,1
	lw	s3,0(s2)
	mv	a0,s3
	li	a1,0
	call	count_leading_zeros
	mv	s0,a0
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
	li a0,10
	call putchar
	addi s1,s1,1
	# loop 2
	lw s3,4(s2)
	mv a0,s3
	li a1,0
	call count_leading_zeros
	mv s0,a0
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
	li a0,10
	call putchar
	addi s1,s1,1
	# loop 3
	lw s3,8(s2)
	mv a0,s3
	li a1,0
	call count_leading_zeros
	mv s0,a0
	bgtu    a0,s4,.L3
	mv      a1,s1
	addi    a0,s10,%lo(.LC0)
	call    printf
	mv      a1,s3
	addi    a0,s9,%lo(.LC1)
	call    printf
	mv      a1,s0
	addi    a0,s8,%lo(.LC2)
	call    printf
	sub     a1,s4,s0
	addi    a0,s7,%lo(.LC3)
	call    printf
	li a0,10
	call putchar
	addi s1,s1,1
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
.L3:
        mv a1,s1
        addi a0,s11,%lo(.LC4)
        call printf
