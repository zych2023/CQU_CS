.text
.globl main
main:
	addi sp, sp, -64
	sw ra, 60(sp)
	sw s0, 56(sp)
	addi s0, sp, 64
.Lmain_0:
	li t0, 0
	sw t0, -12(s0)
.Lmain_1:
	li t0, 0
	sw t0, -16(s0)
.Lmain_2:
	lw t0, -12(s0)
	li t1, 100
	slt t2, t0, t1
	sw t2, -20(s0)
.Lmain_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lmain_4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lmain_5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmain_6:
	lw t0, -32(s0)
	bne t0, x0, .Lmain_8
.Lmain_7:
	j .Lmain_20
.Lmain_8:
	lw t0, -12(s0)
	li t1, 50
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -36(s0)
.Lmain_9:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lmain_10:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lmain_11:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmain_12:
	lw t0, -48(s0)
	bne t0, x0, .Lmain_14
.Lmain_13:
	j .Lmain_15
.Lmain_14:
	j .Lmain_20
.Lmain_15:
	lw t0, -16(s0)
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -52(s0)
.Lmain_16:
	lw t0, -52(s0)
	sw t0, -16(s0)
.Lmain_17:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -56(s0)
.Lmain_18:
	lw t0, -56(s0)
	sw t0, -12(s0)
.Lmain_19:
	j .Lmain_2
.Lmain_20:
	lw a0, -16(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 60(sp)
	lw s0, 56(sp)
	addi sp, sp, 64
	jr ra
