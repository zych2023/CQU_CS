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
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
.Lmain_0:
	li t0, 4
	sw t0, a
.Lmain_1:
	li t0, 4
	sw t0, b
.Lmain_2:
	lw t0, a
	lw t1, b
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -12(s0)
.Lmain_3:
	lw t0, -12(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -16(s0)
.Lmain_4:
	li t0, 0
	sw t0, -20(s0)
.Lmain_5:
	lw t0, -16(s0)
	bne t0, x0, .Lmain_7
.Lmain_6:
	j .Lmain_11
.Lmain_7:
	lw t0, a
	li t1, 3
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lmain_8:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lmain_9:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmain_10:
	lw t0, -32(s0)
	sw t0, -20(s0)
.Lmain_11:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lmain_12:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lmain_13:
	lw t0, -40(s0)
	bne t0, x0, .Lmain_16
.Lmain_14:
	li t0, 0
	sw t0, -44(s0)
.Lmain_15:
	j .Lmain_17
.Lmain_16:
	li t0, 1
	sw t0, -44(s0)
.Lmain_17:
	lw a0, -44(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
