.text
.globl main
main:
	addi sp, sp, -96
	sw ra, 92(sp)
	sw s0, 88(sp)
	addi s0, sp, 96
.Lmain_0:
	li t0, 56
	sw t0, -12(s0)
.Lmain_1:
	li t0, 4
	sw t0, -16(s0)
.Lmain_2:
	li t0, 0
	li t1, 4
	sub t2, t0, t1
	sw t2, -20(s0)
.Lmain_3:
	lw t0, -12(s0)
	lw t1, -20(s0)
	sub t2, t0, t1
	sw t2, -24(s0)
.Lmain_4:
	lw t0, -24(s0)
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -28(s0)
.Lmain_5:
	lw t0, -28(s0)
	sw t0, -12(s0)
.Lmain_6:
	lw t0, -12(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmain_7:
	lw t0, -32(s0)
	seqz t2, t0
	sw t2, -36(s0)
.Lmain_8:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lmain_9:
	lw t0, -40(s0)
	seqz t2, t0
	sw t2, -44(s0)
.Lmain_10:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmain_11:
	lw t0, -48(s0)
	seqz t2, t0
	sw t2, -52(s0)
.Lmain_12:
	li t0, 0
	lw t1, -52(s0)
	sub t2, t0, t1
	sw t2, -56(s0)
.Lmain_13:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lmain_14:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lmain_15:
	lw t0, -64(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_16:
	lw t0, -68(s0)
	bne t0, x0, .Lmain_20
.Lmain_17:
	li t0, 0
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -72(s0)
.Lmain_18:
	lw t0, -72(s0)
	sw t0, -12(s0)
.Lmain_19:
	j .Lmain_24
.Lmain_20:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -76(s0)
.Lmain_21:
	li t0, 0
	lw t1, -76(s0)
	sub t2, t0, t1
	sw t2, -80(s0)
.Lmain_22:
	li t0, 0
	lw t1, -80(s0)
	sub t2, t0, t1
	sw t2, -84(s0)
.Lmain_23:
	lw t0, -84(s0)
	sw t0, -12(s0)
.Lmain_24:
	lw a0, -12(s0)
	call putint
.Lmain_25:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 92(sp)
	lw s0, 88(sp)
	addi sp, sp, 96
	jr ra
