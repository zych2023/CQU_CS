.text
.globl FourWhile
FourWhile:
	addi sp, sp, -128
	sw ra, 124(sp)
	sw s0, 120(sp)
	addi s0, sp, 128
.LFourWhile_0:
	li t0, 5
	sw t0, -12(s0)
.LFourWhile_1:
	li t0, 6
	sw t0, -16(s0)
.LFourWhile_2:
	li t0, 7
	sw t0, -20(s0)
.LFourWhile_3:
	li t0, 10
	sw t0, -24(s0)
.LFourWhile_4:
	lw t0, -12(s0)
	li t1, 20
	slt t2, t0, t1
	sw t2, -28(s0)
.LFourWhile_5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.LFourWhile_6:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.LFourWhile_7:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.LFourWhile_8:
	lw t0, -40(s0)
	bne t0, x0, .LFourWhile_10
.LFourWhile_9:
	j .LFourWhile_46
.LFourWhile_10:
	lw t0, -12(s0)
	li t1, 3
	add t2, t0, t1
	sw t2, -44(s0)
.LFourWhile_11:
	lw t0, -44(s0)
	sw t0, -12(s0)
.LFourWhile_12:
	lw t0, -16(s0)
	li t1, 10
	slt t2, t0, t1
	sw t2, -48(s0)
.LFourWhile_13:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.LFourWhile_14:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.LFourWhile_15:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.LFourWhile_16:
	lw t0, -60(s0)
	bne t0, x0, .LFourWhile_18
.LFourWhile_17:
	j .LFourWhile_43
.LFourWhile_18:
	lw t0, -16(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -64(s0)
.LFourWhile_19:
	lw t0, -64(s0)
	sw t0, -16(s0)
.LFourWhile_20:
	lw t0, -20(s0)
	li t1, 7
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -68(s0)
.LFourWhile_21:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.LFourWhile_22:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.LFourWhile_23:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.LFourWhile_24:
	lw t0, -80(s0)
	bne t0, x0, .LFourWhile_26
.LFourWhile_25:
	j .LFourWhile_40
.LFourWhile_26:
	lw t0, -20(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -84(s0)
.LFourWhile_27:
	lw t0, -84(s0)
	sw t0, -20(s0)
.LFourWhile_28:
	lw t0, -24(s0)
	li t1, 20
	slt t2, t0, t1
	sw t2, -88(s0)
.LFourWhile_29:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -92(s0)
.LFourWhile_30:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.LFourWhile_31:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.LFourWhile_32:
	lw t0, -100(s0)
	bne t0, x0, .LFourWhile_34
.LFourWhile_33:
	j .LFourWhile_37
.LFourWhile_34:
	lw t0, -24(s0)
	li t1, 3
	add t2, t0, t1
	sw t2, -104(s0)
.LFourWhile_35:
	lw t0, -104(s0)
	sw t0, -24(s0)
.LFourWhile_36:
	j .LFourWhile_28
.LFourWhile_37:
	lw t0, -24(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -108(s0)
.LFourWhile_38:
	lw t0, -108(s0)
	sw t0, -24(s0)
.LFourWhile_39:
	j .LFourWhile_20
.LFourWhile_40:
	lw t0, -20(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -112(s0)
.LFourWhile_41:
	lw t0, -112(s0)
	sw t0, -20(s0)
.LFourWhile_42:
	j .LFourWhile_12
.LFourWhile_43:
	lw t0, -16(s0)
	li t1, 2
	sub t2, t0, t1
	sw t2, -116(s0)
.LFourWhile_44:
	lw t0, -116(s0)
	sw t0, -16(s0)
.LFourWhile_45:
	j .LFourWhile_4
.LFourWhile_46:
	lw t0, -16(s0)
	lw t1, -24(s0)
	add t2, t0, t1
	sw t2, -120(s0)
.LFourWhile_47:
	lw t0, -12(s0)
	lw t1, -120(s0)
	add t2, t0, t1
	sw t2, -124(s0)
.LFourWhile_48:
	lw t0, -124(s0)
	lw t1, -20(s0)
	add t2, t0, t1
	sw t2, -128(s0)
.LFourWhile_49:
	lw a0, -128(s0)
	j .LFourWhile_epilogue
.LFourWhile_epilogue:
	lw ra, 124(sp)
	lw s0, 120(sp)
	addi sp, sp, 128
	jr ra
.globl main
main:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lmain_0:
	call FourWhile
	sw a0, -12(s0)
.Lmain_1:
	lw a0, -12(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
