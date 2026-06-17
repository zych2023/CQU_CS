.data
.globl a
a:
	.word 0
.text
.globl func
func:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
.Lfunc_0:
	lw t0, a
	sw t0, -12(s0)
.Lfunc_1:
	li t0, 1
	sw t0, -16(s0)
.Lfunc_2:
	lw t0, -16(s0)
	lw t1, -12(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -20(s0)
.Lfunc_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lfunc_4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lfunc_5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lfunc_6:
	lw t0, -32(s0)
	bne t0, x0, .Lfunc_9
.Lfunc_7:
	li a0, 0
	j .Lfunc_epilogue
.Lfunc_8:
	j .Lfunc_epilogue
.Lfunc_9:
	lw t0, -16(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -36(s0)
.Lfunc_10:
	lw t0, -36(s0)
	sw t0, -16(s0)
.Lfunc_11:
	li a0, 1
	j .Lfunc_epilogue
.Lfunc_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
.globl main
main:
	addi sp, sp, -80
	sw ra, 76(sp)
	sw s0, 72(sp)
	addi s0, sp, 80
.Lmain_0:
	call __global_init
.Lmain_1:
	li t0, 0
	sw t0, -12(s0)
.Lmain_2:
	li t0, 0
	sw t0, -16(s0)
.Lmain_3:
	lw t0, -16(s0)
	li t1, 100
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
	j .Lmain_21
.Lmain_9:
	call func
	sw a0, -36(s0)
.Lmain_10:
	lw t0, -36(s0)
	li t1, 1
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -40(s0)
.Lmain_11:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lmain_12:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmain_13:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.Lmain_14:
	lw t0, -52(s0)
	bne t0, x0, .Lmain_16
.Lmain_15:
	j .Lmain_18
.Lmain_16:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -56(s0)
.Lmain_17:
	lw t0, -56(s0)
	sw t0, -12(s0)
.Lmain_18:
	lw t0, -16(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -60(s0)
.Lmain_19:
	lw t0, -60(s0)
	sw t0, -16(s0)
.Lmain_20:
	j .Lmain_3
.Lmain_21:
	lw t0, -12(s0)
	li t1, 100
	slt t2, t0, t1
	sw t2, -64(s0)
.Lmain_22:
	lw t0, -64(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_23:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.Lmain_24:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.Lmain_25:
	lw t0, -76(s0)
	bne t0, x0, .Lmain_28
.Lmain_26:
	li a0, 0
	call putint
.Lmain_27:
	j .Lmain_29
.Lmain_28:
	li a0, 1
	call putint
.Lmain_29:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 76(sp)
	lw s0, 72(sp)
	addi sp, sp, 80
	jr ra
.globl __global_init
__global_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.L__global_init_0:
	li t0, 7
	sw t0, a
.L__global_init_1:
	j .L__global_init_epilogue
.L__global_init_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
