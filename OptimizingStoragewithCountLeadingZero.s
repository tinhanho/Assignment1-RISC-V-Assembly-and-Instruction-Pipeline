.data
input: .word 16
split: .string "-------------\n"
newline: .string "\n"
char_str: .string "char:"
short_str: .string "short:"
int_str: .string "int:"

.text
main:
	# a1 for input number
    lw a1, input
	# for-loop, a2 for loop counter
	addi a2, x0, 4
	# create space for char, short and int
	sb x0, 0(a3)
	sh x0, 1(a3)
	sw x0, 4(a3)
	
loop:
	jal ra, opt_storage
    jal ra, print
	slli a1, a1, 5 # shift input left to get larger data
	addi a2, a2, -1 # loop counter
	bne a2, x0, loop  
    # Exit
    li a7, 10
    ecall

opt_storage:
    addi sp, sp, -4 # create stack space to save return address
    sw ra, 0(sp)
	jal ra, count_leading_zeros # calculate leading zeros
	# if leading zero >= 24
	addi t0, s0, -24 
	bge t0, x0, char
	# if leading zero >= 16
    addi t0, s0, -16
	bge t0, x0, short
	# else
	jal x0, int
char:
	sb a1, 0(a3)
	jal x0, endif
short:
	sh a1, 1(a3)
	jal x0, endif
int:
	sw a1, 4(a3)
	jal x0, endif
endif:
	lw ra, 0(sp)
    addi sp, sp, 4
	ret

count_leading_zeros:
	add s0, x0, a1 # s0 counts the leading zeros
	srli t0, s0, 1 # t0 = x>>1
	or s0, s0, t0 # x |= (x >> 1); 
	srli t0, s0, 2 # x>>2
	or s0, s0, t0 
	srli t0, s0, 4 # x>>4
	or s0, s0, t0
	srli t0, s0, 8 # x>>8
	or s0, s0, t0
	srli t0, s0, 16 # x>>16
	or s0, s0, t0
	li t5, 0x55555555
	srli t0, s0, 1 # x>>1
	and t0, t0, t5 # (x >> 1) & 0x55555555
	sub s0, s0, t0
	li t5, 0x33333333
	srli t0, s0, 2 # x>>2
	and t0, t0, t5 # (x >> 2) & 0x33333333
	and t1, s0, t5 # x & 0x33333333
	add s0, t0, t1 
	li t5, 0x0f0f0f0f
	srli t0, s0, 4 # x>>4
	add t0, s0, t0
	and s0, t0, t5 
	srli t0, s0, 8 # x>>8
	add s0, s0, t0
	srli t0, s0, 16 # x>>16
	add s0, s0, t0
	li t5, 0x0000007f
	and s0, s0, t5 
	sub s0, x0, s0
	addi s0, s0, 32
	ret
	
print:
	# print leading zeros for testing
	# add a0, s0, x0
	# li a7, 1
	# ecall
	
    # print split symbol
    la a0, split
    li a7, 4
    ecall
    # print string "char"  
    la a0, char_str
    li a7, 4
    ecall
    # print char
	lb a0, 0(a3)
    li a7, 1
    ecall
    # newline
    la a0, newline
    li a7, 4
    ecall    
    # print string "short"
    la a0, short_str
    li a7, 4
    ecall
    # print short
	lh a0, 1(a3)
    li a7, 1
    ecall
    # newline
    la a0, newline
    li a7, 4
    ecall        
    # print string "int"
    la a0, int_str
    li a7, 4
    ecall
    # print int
	lw a0, 4(a3)
    li a7, 1
    ecall
    # newline
    la a0, newline
    li a7, 4
    ecall       
    ret
