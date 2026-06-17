.data
.globl a
a:
	.zero 20
.text
.globl main
main:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lmain_0:
	call __global_init
.Lmain_1:
	li t0, 0
	li t1, 4
	add t2, t0, t1
	sw t2, -12(s0)
.Lmain_2:
	la t0, a
	lw t1, -12(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -16(s0)
.Lmain_3:
	lw a0, -16(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl __global_init
__global_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.L__global_init_0:
	la t0, a
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.L__global_init_1:
	la t0, a
	li t1, 1
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.L__global_init_2:
	la t0, a
	li t1, 2
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 2
	sw t2, 0(t0)
.L__global_init_3:
	la t0, a
	li t1, 3
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 3
	sw t2, 0(t0)
.L__global_init_4:
	la t0, a
	li t1, 4
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 4
	sw t2, 0(t0)
.L__global_init_5:
	j .L__global_init_epilogue
.L__global_init_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
