.data
.globl a
a:
	.word 0
.globl b
b:
	.word 0
.globl c
c:
	.word 0
.globl d
d:
	.word 0
.globl e
e:
	.word 0
.text
.globl main
main:
	addi sp, sp, -112
	sw ra, 108(sp)
	sw s0, 104(sp)
	addi s0, sp, 112
.Lmain_0:
	call __global_init
.Lmain_1:
	li t0, 0
	sw t0, -12(s0)
.Lmain_2:
	lw t0, a
	lw t1, b
	mul t2, t0, t1
	sw t2, -16(s0)
.Lmain_3:
	lw t0, -16(s0)
	lw t1, c
	div t2, t0, t1
	sw t2, -20(s0)
.Lmain_4:
	lw t0, e
	lw t1, d
	add t2, t0, t1
	sw t2, -24(s0)
.Lmain_5:
	lw t0, -20(s0)
	lw t1, -24(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -28(s0)
.Lmain_6:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmain_7:
	li t0, 0
	sw t0, -36(s0)
.Lmain_8:
	lw t0, -32(s0)
	bne t0, x0, .Lmain_10
.Lmain_9:
	j .Lmain_18
.Lmain_10:
	lw t0, a
	lw t1, b
	add t2, t0, t1
	sw t2, -40(s0)
.Lmain_11:
	lw t0, a
	lw t1, -40(s0)
	mul t2, t0, t1
	sw t2, -44(s0)
.Lmain_12:
	lw t0, -44(s0)
	lw t1, c
	add t2, t0, t1
	sw t2, -48(s0)
.Lmain_13:
	lw t0, d
	lw t1, e
	add t2, t0, t1
	sw t2, -52(s0)
.Lmain_14:
	lw t0, -48(s0)
	lw t1, -52(s0)
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -56(s0)
.Lmain_15:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lmain_16:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lmain_17:
	lw t0, -64(s0)
	sw t0, -36(s0)
.Lmain_18:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_19:
	li t0, 1
	sw t0, -72(s0)
.Lmain_20:
	lw t0, -68(s0)
	seqz t2, t0
	sw t2, -76(s0)
.Lmain_21:
	lw t0, -76(s0)
	bne t0, x0, .Lmain_23
.Lmain_22:
	j .Lmain_32
.Lmain_23:
	lw t0, b
	lw t1, c
	mul t2, t0, t1
	sw t2, -80(s0)
.Lmain_24:
	lw t0, a
	lw t1, -80(s0)
	sub t2, t0, t1
	sw t2, -84(s0)
.Lmain_25:
	lw t0, a
	lw t1, c
	div t2, t0, t1
	sw t2, -88(s0)
.Lmain_26:
	lw t0, d
	lw t1, -88(s0)
	sub t2, t0, t1
	sw t2, -92(s0)
.Lmain_27:
	lw t0, -84(s0)
	lw t1, -92(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -96(s0)
.Lmain_28:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lmain_29:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.Lmain_30:
	lw t0, -104(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -108(s0)
.Lmain_31:
	lw t0, -108(s0)
	sw t0, -72(s0)
.Lmain_32:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.Lmain_33:
	lw t0, -112(s0)
	bne t0, x0, .Lmain_35
.Lmain_34:
	j .Lmain_36
.Lmain_35:
	li t0, 1
	sw t0, -12(s0)
.Lmain_36:
	lw a0, -12(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 108(sp)
	lw s0, 104(sp)
	addi sp, sp, 112
	jr ra
.globl __global_init
__global_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.L__global_init_0:
	li t0, 1
	sw t0, a
.L__global_init_1:
	li t0, 0
	sw t0, b
.L__global_init_2:
	li t0, 1
	sw t0, c
.L__global_init_3:
	li t0, 2
	sw t0, d
.L__global_init_4:
	li t0, 4
	sw t0, e
.L__global_init_5:
	j .L__global_init_epilogue
.L__global_init_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
