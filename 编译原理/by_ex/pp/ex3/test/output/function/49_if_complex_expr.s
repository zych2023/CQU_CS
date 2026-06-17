.text
.globl main
main:
	addi sp, sp, -192
	sw ra, 188(sp)
	sw s0, 184(sp)
	addi s0, sp, 192
.Lmain_0:
	li t0, 5
	sw t0, -12(s0)
.Lmain_1:
	li t0, 5
	sw t0, -16(s0)
.Lmain_2:
	li t0, 1
	sw t0, -20(s0)
.Lmain_3:
	li t0, 0
	li t1, 2
	sub t2, t0, t1
	sw t2, -24(s0)
.Lmain_4:
	lw t0, -24(s0)
	sw t0, -28(s0)
.Lmain_5:
	li t0, 2
	sw t0, -32(s0)
.Lmain_6:
	lw t0, -28(s0)
	li t1, 1
	mul t2, t0, t1
	sw t2, -36(s0)
.Lmain_7:
	lw t0, -36(s0)
	li t1, 2
	div t2, t0, t1
	sw t2, -40(s0)
.Lmain_8:
	lw t0, -40(s0)
	li t1, 0
	slt t2, t0, t1
	sw t2, -44(s0)
.Lmain_9:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmain_10:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.Lmain_11:
	li t0, 1
	sw t0, -56(s0)
.Lmain_12:
	lw t0, -52(s0)
	seqz t2, t0
	sw t2, -60(s0)
.Lmain_13:
	lw t0, -60(s0)
	bne t0, x0, .Lmain_15
.Lmain_14:
	j .Lmain_30
.Lmain_15:
	lw t0, -12(s0)
	lw t1, -16(s0)
	sub t2, t0, t1
	sw t2, -64(s0)
.Lmain_16:
	lw t0, -64(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_17:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.Lmain_18:
	li t0, 0
	sw t0, -76(s0)
.Lmain_19:
	lw t0, -72(s0)
	bne t0, x0, .Lmain_21
.Lmain_20:
	j .Lmain_27
.Lmain_21:
	lw t0, -20(s0)
	li t1, 3
	add t2, t0, t1
	sw t2, -80(s0)
.Lmain_22:
	lw t0, -80(s0)
	li t1, 2
	rem t2, t0, t1
	sw t2, -84(s0)
.Lmain_23:
	lw t0, -84(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -88(s0)
.Lmain_24:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -92(s0)
.Lmain_25:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.Lmain_26:
	lw t0, -96(s0)
	sw t0, -76(s0)
.Lmain_27:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lmain_28:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.Lmain_29:
	lw t0, -104(s0)
	sw t0, -56(s0)
.Lmain_30:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -108(s0)
.Lmain_31:
	lw t0, -108(s0)
	bne t0, x0, .Lmain_33
.Lmain_32:
	j .Lmain_34
.Lmain_33:
	lw a0, -32(s0)
	call putint
.Lmain_34:
	lw t0, -28(s0)
	li t1, 2
	rem t2, t0, t1
	sw t2, -112(s0)
.Lmain_35:
	lw t0, -112(s0)
	li t1, 67
	add t2, t0, t1
	sw t2, -116(s0)
.Lmain_36:
	lw t0, -116(s0)
	li t1, 0
	slt t2, t0, t1
	sw t2, -120(s0)
.Lmain_37:
	lw t0, -120(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -124(s0)
.Lmain_38:
	lw t0, -124(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -128(s0)
.Lmain_39:
	li t0, 1
	sw t0, -132(s0)
.Lmain_40:
	lw t0, -128(s0)
	seqz t2, t0
	sw t2, -136(s0)
.Lmain_41:
	lw t0, -136(s0)
	bne t0, x0, .Lmain_43
.Lmain_42:
	j .Lmain_58
.Lmain_43:
	lw t0, -12(s0)
	lw t1, -16(s0)
	sub t2, t0, t1
	sw t2, -140(s0)
.Lmain_44:
	lw t0, -140(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -144(s0)
.Lmain_45:
	lw t0, -144(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -148(s0)
.Lmain_46:
	li t0, 0
	sw t0, -152(s0)
.Lmain_47:
	lw t0, -148(s0)
	bne t0, x0, .Lmain_49
.Lmain_48:
	j .Lmain_55
.Lmain_49:
	lw t0, -20(s0)
	li t1, 2
	add t2, t0, t1
	sw t2, -156(s0)
.Lmain_50:
	lw t0, -156(s0)
	li t1, 2
	rem t2, t0, t1
	sw t2, -160(s0)
.Lmain_51:
	lw t0, -160(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -164(s0)
.Lmain_52:
	lw t0, -164(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -168(s0)
.Lmain_53:
	lw t0, -168(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -172(s0)
.Lmain_54:
	lw t0, -172(s0)
	sw t0, -152(s0)
.Lmain_55:
	lw t0, -152(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -176(s0)
.Lmain_56:
	lw t0, -176(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -180(s0)
.Lmain_57:
	lw t0, -180(s0)
	sw t0, -132(s0)
.Lmain_58:
	lw t0, -132(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -184(s0)
.Lmain_59:
	lw t0, -184(s0)
	bne t0, x0, .Lmain_61
.Lmain_60:
	j .Lmain_63
.Lmain_61:
	li t0, 4
	sw t0, -32(s0)
.Lmain_62:
	lw a0, -32(s0)
	call putint
.Lmain_63:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 188(sp)
	lw s0, 184(sp)
	addi sp, sp, 192
	jr ra
