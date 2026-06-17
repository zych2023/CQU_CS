.text
.globl deepWhileBr
deepWhileBr:
	addi sp, sp, -112
	sw ra, 108(sp)
	sw s0, 104(sp)
	addi s0, sp, 112
	sw a0, -12(s0)
	sw a1, -16(s0)
.LdeepWhileBr_0:
	lw t0, -12(s0)
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -20(s0)
.LdeepWhileBr_1:
	lw t0, -20(s0)
	sw t0, -24(s0)
.LdeepWhileBr_2:
	lw t0, -24(s0)
	li t1, 75
	slt t2, t0, t1
	sw t2, -28(s0)
.LdeepWhileBr_3:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.LdeepWhileBr_4:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.LdeepWhileBr_5:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.LdeepWhileBr_6:
	lw t0, -40(s0)
	bne t0, x0, .LdeepWhileBr_8
.LdeepWhileBr_7:
	j .LdeepWhileBr_34
.LdeepWhileBr_8:
	li t0, 42
	sw t0, -44(s0)
.LdeepWhileBr_9:
	lw t0, -24(s0)
	li t1, 100
	slt t2, t0, t1
	sw t2, -48(s0)
.LdeepWhileBr_10:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.LdeepWhileBr_11:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.LdeepWhileBr_12:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.LdeepWhileBr_13:
	lw t0, -60(s0)
	bne t0, x0, .LdeepWhileBr_15
.LdeepWhileBr_14:
	j .LdeepWhileBr_33
.LdeepWhileBr_15:
	lw t0, -24(s0)
	lw t1, -44(s0)
	add t2, t0, t1
	sw t2, -64(s0)
.LdeepWhileBr_16:
	lw t0, -64(s0)
	sw t0, -24(s0)
.LdeepWhileBr_17:
	lw t0, -24(s0)
	li t1, 99
	slt t2, t1, t0
	sw t2, -68(s0)
.LdeepWhileBr_18:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.LdeepWhileBr_19:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.LdeepWhileBr_20:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.LdeepWhileBr_21:
	lw t0, -80(s0)
	bne t0, x0, .LdeepWhileBr_23
.LdeepWhileBr_22:
	j .LdeepWhileBr_33
.LdeepWhileBr_23:
	lw t0, -44(s0)
	li t1, 2
	mul t2, t0, t1
	sw t2, -84(s0)
.LdeepWhileBr_24:
	lw t0, -84(s0)
	sw t0, -88(s0)
.LdeepWhileBr_25:
	li t0, 1
	li t1, 1
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -92(s0)
.LdeepWhileBr_26:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.LdeepWhileBr_27:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.LdeepWhileBr_28:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.LdeepWhileBr_29:
	lw t0, -104(s0)
	bne t0, x0, .LdeepWhileBr_31
.LdeepWhileBr_30:
	j .LdeepWhileBr_33
.LdeepWhileBr_31:
	lw t0, -88(s0)
	li t1, 2
	mul t2, t0, t1
	sw t2, -108(s0)
.LdeepWhileBr_32:
	lw t0, -108(s0)
	sw t0, -24(s0)
.LdeepWhileBr_33:
	j .LdeepWhileBr_2
.LdeepWhileBr_34:
	lw a0, -24(s0)
	j .LdeepWhileBr_epilogue
.LdeepWhileBr_epilogue:
	lw ra, 108(sp)
	lw s0, 104(sp)
	addi sp, sp, 112
	jr ra
.globl main
main:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lmain_0:
	li t0, 2
	sw t0, -12(s0)
.Lmain_1:
	lw a0, -12(s0)
	lw a1, -12(s0)
	call deepWhileBr
	sw a0, -16(s0)
.Lmain_2:
	lw a0, -16(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
