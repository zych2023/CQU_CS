.data
.globl arr
arr:
	.zero 24
.text
.globl main
main:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
.Lmain_0:
	call __global_init
.Lmain_1:
	li t0, 0
	sw t0, -12(s0)
.Lmain_2:
	li t0, 0
	sw t0, -16(s0)
.Lmain_3:
	lw t0, -12(s0)
	li t1, 6
	slt t2, t0, t1
	sw t2, -20(s0)
.Lmain_4:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lmain_5:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lmain_6:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmain_7:
	lw t0, -32(s0)
	bne t0, x0, .Lmain_9
.Lmain_8:
	j .Lmain_16
.Lmain_9:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -36(s0)
.Lmain_10:
	la t0, arr
	lw t1, -36(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -40(s0)
.Lmain_11:
	lw t0, -16(s0)
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -44(s0)
.Lmain_12:
	lw t0, -44(s0)
	sw t0, -16(s0)
.Lmain_13:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -48(s0)
.Lmain_14:
	lw t0, -48(s0)
	sw t0, -12(s0)
.Lmain_15:
	j .Lmain_3
.Lmain_16:
	lw a0, -16(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
.globl __global_init
__global_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.L__global_init_0:
	la t0, arr
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.L__global_init_1:
	la t0, arr
	li t1, 1
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 2
	sw t2, 0(t0)
.L__global_init_2:
	la t0, arr
	li t1, 2
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 33
	sw t2, 0(t0)
.L__global_init_3:
	la t0, arr
	li t1, 3
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 4
	sw t2, 0(t0)
.L__global_init_4:
	la t0, arr
	li t1, 4
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 5
	sw t2, 0(t0)
.L__global_init_5:
	la t0, arr
	li t1, 5
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 6
	sw t2, 0(t0)
.L__global_init_6:
	j .L__global_init_epilogue
.L__global_init_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
