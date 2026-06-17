.data
.globl g
g:
	.word 0
.globl h
h:
	.word 0
.globl f
f:
	.word 0
.globl e
e:
	.word 0
.text
.globl EightWhile
EightWhile:
	addi sp, sp, -240
	sw ra, 236(sp)
	sw s0, 232(sp)
	addi s0, sp, 240
.LEightWhile_0:
	li t0, 5
	sw t0, -12(s0)
.LEightWhile_1:
	li t0, 6
	sw t0, -16(s0)
.LEightWhile_2:
	li t0, 7
	sw t0, -20(s0)
.LEightWhile_3:
	li t0, 10
	sw t0, -24(s0)
.LEightWhile_4:
	lw t0, -12(s0)
	li t1, 20
	slt t2, t0, t1
	sw t2, -28(s0)
.LEightWhile_5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.LEightWhile_6:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.LEightWhile_7:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.LEightWhile_8:
	lw t0, -40(s0)
	bne t0, x0, .LEightWhile_10
.LEightWhile_9:
	j .LEightWhile_90
.LEightWhile_10:
	lw t0, -12(s0)
	li t1, 3
	add t2, t0, t1
	sw t2, -44(s0)
.LEightWhile_11:
	lw t0, -44(s0)
	sw t0, -12(s0)
.LEightWhile_12:
	lw t0, -16(s0)
	li t1, 10
	slt t2, t0, t1
	sw t2, -48(s0)
.LEightWhile_13:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.LEightWhile_14:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.LEightWhile_15:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.LEightWhile_16:
	lw t0, -60(s0)
	bne t0, x0, .LEightWhile_18
.LEightWhile_17:
	j .LEightWhile_87
.LEightWhile_18:
	lw t0, -16(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -64(s0)
.LEightWhile_19:
	lw t0, -64(s0)
	sw t0, -16(s0)
.LEightWhile_20:
	lw t0, -20(s0)
	li t1, 7
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -68(s0)
.LEightWhile_21:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.LEightWhile_22:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.LEightWhile_23:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.LEightWhile_24:
	lw t0, -80(s0)
	bne t0, x0, .LEightWhile_26
.LEightWhile_25:
	j .LEightWhile_84
.LEightWhile_26:
	lw t0, -20(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -84(s0)
.LEightWhile_27:
	lw t0, -84(s0)
	sw t0, -20(s0)
.LEightWhile_28:
	lw t0, -24(s0)
	li t1, 20
	slt t2, t0, t1
	sw t2, -88(s0)
.LEightWhile_29:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -92(s0)
.LEightWhile_30:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.LEightWhile_31:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.LEightWhile_32:
	lw t0, -100(s0)
	bne t0, x0, .LEightWhile_34
.LEightWhile_33:
	j .LEightWhile_81
.LEightWhile_34:
	lw t0, -24(s0)
	li t1, 3
	add t2, t0, t1
	sw t2, -104(s0)
.LEightWhile_35:
	lw t0, -104(s0)
	sw t0, -24(s0)
.LEightWhile_36:
	lw t0, e
	li t1, 1
	slt t2, t1, t0
	sw t2, -108(s0)
.LEightWhile_37:
	lw t0, -108(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.LEightWhile_38:
	lw t0, -112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -116(s0)
.LEightWhile_39:
	lw t0, -116(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -120(s0)
.LEightWhile_40:
	lw t0, -120(s0)
	bne t0, x0, .LEightWhile_42
.LEightWhile_41:
	j .LEightWhile_78
.LEightWhile_42:
	lw t0, e
	li t1, 1
	sub t2, t0, t1
	sw t2, -124(s0)
.LEightWhile_43:
	lw t0, -124(s0)
	sw t0, e
.LEightWhile_44:
	lw t0, f
	li t1, 2
	slt t2, t1, t0
	sw t2, -128(s0)
.LEightWhile_45:
	lw t0, -128(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -132(s0)
.LEightWhile_46:
	lw t0, -132(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -136(s0)
.LEightWhile_47:
	lw t0, -136(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -140(s0)
.LEightWhile_48:
	lw t0, -140(s0)
	bne t0, x0, .LEightWhile_50
.LEightWhile_49:
	j .LEightWhile_75
.LEightWhile_50:
	lw t0, f
	li t1, 2
	sub t2, t0, t1
	sw t2, -144(s0)
.LEightWhile_51:
	lw t0, -144(s0)
	sw t0, f
.LEightWhile_52:
	lw t0, g
	li t1, 3
	slt t2, t0, t1
	sw t2, -148(s0)
.LEightWhile_53:
	lw t0, -148(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -152(s0)
.LEightWhile_54:
	lw t0, -152(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -156(s0)
.LEightWhile_55:
	lw t0, -156(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -160(s0)
.LEightWhile_56:
	lw t0, -160(s0)
	bne t0, x0, .LEightWhile_58
.LEightWhile_57:
	j .LEightWhile_72
.LEightWhile_58:
	lw t0, g
	li t1, 10
	add t2, t0, t1
	sw t2, -164(s0)
.LEightWhile_59:
	lw t0, -164(s0)
	sw t0, g
.LEightWhile_60:
	lw t0, h
	li t1, 10
	slt t2, t0, t1
	sw t2, -168(s0)
.LEightWhile_61:
	lw t0, -168(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -172(s0)
.LEightWhile_62:
	lw t0, -172(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -176(s0)
.LEightWhile_63:
	lw t0, -176(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -180(s0)
.LEightWhile_64:
	lw t0, -180(s0)
	bne t0, x0, .LEightWhile_66
.LEightWhile_65:
	j .LEightWhile_69
.LEightWhile_66:
	lw t0, h
	li t1, 8
	add t2, t0, t1
	sw t2, -184(s0)
.LEightWhile_67:
	lw t0, -184(s0)
	sw t0, h
.LEightWhile_68:
	j .LEightWhile_60
.LEightWhile_69:
	lw t0, h
	li t1, 1
	sub t2, t0, t1
	sw t2, -188(s0)
.LEightWhile_70:
	lw t0, -188(s0)
	sw t0, h
.LEightWhile_71:
	j .LEightWhile_52
.LEightWhile_72:
	lw t0, g
	li t1, 8
	sub t2, t0, t1
	sw t2, -192(s0)
.LEightWhile_73:
	lw t0, -192(s0)
	sw t0, g
.LEightWhile_74:
	j .LEightWhile_44
.LEightWhile_75:
	lw t0, f
	li t1, 1
	add t2, t0, t1
	sw t2, -196(s0)
.LEightWhile_76:
	lw t0, -196(s0)
	sw t0, f
.LEightWhile_77:
	j .LEightWhile_36
.LEightWhile_78:
	lw t0, e
	li t1, 1
	add t2, t0, t1
	sw t2, -200(s0)
.LEightWhile_79:
	lw t0, -200(s0)
	sw t0, e
.LEightWhile_80:
	j .LEightWhile_28
.LEightWhile_81:
	lw t0, -24(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -204(s0)
.LEightWhile_82:
	lw t0, -204(s0)
	sw t0, -24(s0)
.LEightWhile_83:
	j .LEightWhile_20
.LEightWhile_84:
	lw t0, -20(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -208(s0)
.LEightWhile_85:
	lw t0, -208(s0)
	sw t0, -20(s0)
.LEightWhile_86:
	j .LEightWhile_12
.LEightWhile_87:
	lw t0, -16(s0)
	li t1, 2
	sub t2, t0, t1
	sw t2, -212(s0)
.LEightWhile_88:
	lw t0, -212(s0)
	sw t0, -16(s0)
.LEightWhile_89:
	j .LEightWhile_4
.LEightWhile_90:
	lw t0, -16(s0)
	lw t1, -24(s0)
	add t2, t0, t1
	sw t2, -216(s0)
.LEightWhile_91:
	lw t0, -12(s0)
	lw t1, -216(s0)
	add t2, t0, t1
	sw t2, -220(s0)
.LEightWhile_92:
	lw t0, -220(s0)
	lw t1, -20(s0)
	add t2, t0, t1
	sw t2, -224(s0)
.LEightWhile_93:
	lw t0, e
	lw t1, -24(s0)
	add t2, t0, t1
	sw t2, -228(s0)
.LEightWhile_94:
	lw t0, -228(s0)
	lw t1, g
	sub t2, t0, t1
	sw t2, -232(s0)
.LEightWhile_95:
	lw t0, -232(s0)
	lw t1, h
	add t2, t0, t1
	sw t2, -236(s0)
.LEightWhile_96:
	lw t0, -224(s0)
	lw t1, -236(s0)
	sub t2, t0, t1
	sw t2, -240(s0)
.LEightWhile_97:
	lw a0, -240(s0)
	j .LEightWhile_epilogue
.LEightWhile_epilogue:
	lw ra, 236(sp)
	lw s0, 232(sp)
	addi sp, sp, 240
	jr ra
.globl main
main:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lmain_0:
	li t0, 1
	sw t0, g
.Lmain_1:
	li t0, 2
	sw t0, h
.Lmain_2:
	li t0, 4
	sw t0, e
.Lmain_3:
	li t0, 6
	sw t0, f
.Lmain_4:
	call EightWhile
	sw a0, -12(s0)
.Lmain_5:
	lw a0, -12(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
