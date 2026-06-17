.data
.globl a
a:
	.word 0
.globl b
b:
	.word 0
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
	li t0, 5
	sw t0, -12(s0)
.Lmain_2:
	lw t0, -12(s0)
	lw t1, b
	add t2, t0, t1
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
	li t0, 3
	sw t0, a
.L__global_init_1:
	li t0, 5
	sw t0, b
.L__global_init_2:
	j .L__global_init_epilogue
.L__global_init_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
