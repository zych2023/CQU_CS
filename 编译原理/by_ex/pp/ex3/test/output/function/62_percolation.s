.data
.globl array
array:
	.zero 440
.globl n
n:
	.word 0
.text
.globl init
init:
	addi sp, sp, -64
	sw ra, 60(sp)
	sw s0, 56(sp)
	addi s0, sp, 64
	sw a0, -12(s0)
.Linit_0:
	li t0, 1
	sw t0, -16(s0)
.Linit_1:
	lw t0, -12(s0)
	lw t1, -12(s0)
	mul t2, t0, t1
	sw t2, -20(s0)
.Linit_2:
	lw t0, -20(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -24(s0)
.Linit_3:
	lw t0, -16(s0)
	lw t1, -24(s0)
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -28(s0)
.Linit_4:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Linit_5:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Linit_6:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Linit_7:
	lw t0, -40(s0)
	bne t0, x0, .Linit_9
.Linit_8:
	j .Linit_15
.Linit_9:
	li t0, 0
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -44(s0)
.Linit_10:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -48(s0)
.Linit_11:
	la t0, array
	lw t1, -44(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -48(s0)
	sw t2, 0(t0)
.Linit_12:
	lw t0, -16(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -52(s0)
.Linit_13:
	lw t0, -52(s0)
	sw t0, -16(s0)
.Linit_14:
	j .Linit_1
.Linit_15:
	j .Linit_epilogue
.Linit_epilogue:
	lw ra, 60(sp)
	lw s0, 56(sp)
	addi sp, sp, 64
	jr ra
.globl findfa
findfa:
	addi sp, sp, -64
	sw ra, 60(sp)
	sw s0, 56(sp)
	addi s0, sp, 64
	sw a0, -12(s0)
.Lfindfa_0:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -16(s0)
.Lfindfa_1:
	la t0, array
	lw t1, -16(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -20(s0)
.Lfindfa_2:
	lw t0, -20(s0)
	lw t1, -12(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -24(s0)
.Lfindfa_3:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lfindfa_4:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lfindfa_5:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lfindfa_6:
	lw t0, -36(s0)
	bne t0, x0, .Lfindfa_16
.Lfindfa_7:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -40(s0)
.Lfindfa_8:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -44(s0)
.Lfindfa_9:
	la t0, array
	lw t1, -44(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -48(s0)
.Lfindfa_10:
	lw a0, -48(s0)
	call findfa
	sw a0, -52(s0)
.Lfindfa_11:
	la t0, array
	lw t1, -40(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -52(s0)
	sw t2, 0(t0)
.Lfindfa_12:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -56(s0)
.Lfindfa_13:
	la t0, array
	lw t1, -56(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -60(s0)
.Lfindfa_14:
	lw a0, -60(s0)
	j .Lfindfa_epilogue
.Lfindfa_15:
	j .Lfindfa_epilogue
.Lfindfa_16:
	lw a0, -12(s0)
	j .Lfindfa_epilogue
.Lfindfa_epilogue:
	lw ra, 60(sp)
	lw s0, 56(sp)
	addi sp, sp, 64
	jr ra
.globl mmerge
mmerge:
	addi sp, sp, -64
	sw ra, 60(sp)
	sw s0, 56(sp)
	addi s0, sp, 64
	sw a0, -12(s0)
	sw a1, -16(s0)
.Lmmerge_0:
	lw a0, -12(s0)
	call findfa
	sw a0, -20(s0)
.Lmmerge_1:
	lw t0, -20(s0)
	sw t0, -24(s0)
.Lmmerge_2:
	lw a0, -16(s0)
	call findfa
	sw a0, -28(s0)
.Lmmerge_3:
	lw t0, -28(s0)
	sw t0, -32(s0)
.Lmmerge_4:
	lw t0, -24(s0)
	lw t1, -32(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lmmerge_5:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lmmerge_6:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lmmerge_7:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmmerge_8:
	lw t0, -48(s0)
	bne t0, x0, .Lmmerge_10
.Lmmerge_9:
	j .Lmmerge_12
.Lmmerge_10:
	li t0, 0
	lw t1, -24(s0)
	add t2, t0, t1
	sw t2, -52(s0)
.Lmmerge_11:
	la t0, array
	lw t1, -52(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -32(s0)
	sw t2, 0(t0)
.Lmmerge_12:
	j .Lmmerge_epilogue
.Lmmerge_epilogue:
	lw ra, 60(sp)
	lw s0, 56(sp)
	addi sp, sp, 64
	jr ra
.globl main
main:
	addi sp, sp, -496
	sw ra, 492(sp)
	sw s0, 488(sp)
	addi s0, sp, 496
.Lmain_0:
	li t0, 1
	sw t0, -12(s0)
.Lmain_1:
	lw t0, -12(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -16(s0)
.Lmain_2:
	lw t0, -16(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -20(s0)
.Lmain_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lmain_4:
	lw t0, -24(s0)
	bne t0, x0, .Lmain_6
.Lmain_5:
	j .Lmain_180
.Lmain_6:
	lw t0, -12(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -28(s0)
.Lmain_7:
	lw t0, -28(s0)
	sw t0, -12(s0)
.Lmain_8:
	li t0, 4
	sw t0, n
.Lmain_9:
	li t0, 10
	sw t0, -32(s0)
.Lmain_10:
	li t0, 0
	sw t0, -36(s0)
.Lmain_11:
	li t0, 0
	sw t0, -40(s0)
.Lmain_12:
	lw a0, n
	call init
.Lmain_13:
	lw t0, n
	lw t1, n
	mul t2, t0, t1
	sw t2, -44(s0)
.Lmain_14:
	lw t0, -44(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -48(s0)
.Lmain_15:
	lw t0, -48(s0)
	sw t0, -52(s0)
.Lmain_16:
	lw t0, -36(s0)
	lw t1, -32(s0)
	slt t2, t0, t1
	sw t2, -56(s0)
.Lmain_17:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lmain_18:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lmain_19:
	lw t0, -64(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_20:
	lw t0, -68(s0)
	bne t0, x0, .Lmain_22
.Lmain_21:
	j .Lmain_169
.Lmain_22:
	call getint
	sw a0, -72(s0)
.Lmain_23:
	lw t0, -72(s0)
	sw t0, -76(s0)
.Lmain_24:
	call getint
	sw a0, -80(s0)
.Lmain_25:
	lw t0, -80(s0)
	sw t0, -84(s0)
.Lmain_26:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -88(s0)
.Lmain_27:
	lw t0, -88(s0)
	seqz t2, t0
	sw t2, -92(s0)
.Lmain_28:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.Lmain_29:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lmain_30:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.Lmain_31:
	lw t0, -104(s0)
	bne t0, x0, .Lmain_33
.Lmain_32:
	j .Lmain_166
.Lmain_33:
	lw t0, -76(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -108(s0)
.Lmain_34:
	lw t0, n
	lw t1, -108(s0)
	mul t2, t0, t1
	sw t2, -112(s0)
.Lmain_35:
	lw t0, -112(s0)
	lw t1, -84(s0)
	add t2, t0, t1
	sw t2, -116(s0)
.Lmain_36:
	lw t0, -116(s0)
	sw t0, -120(s0)
.Lmain_37:
	li t0, 0
	lw t1, -120(s0)
	add t2, t0, t1
	sw t2, -124(s0)
.Lmain_38:
	la t0, array
	lw t1, -124(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -120(s0)
	sw t2, 0(t0)
.Lmain_39:
	lw t0, -76(s0)
	li t1, 1
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -128(s0)
.Lmain_40:
	lw t0, -128(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -132(s0)
.Lmain_41:
	lw t0, -132(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -136(s0)
.Lmain_42:
	lw t0, -136(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -140(s0)
.Lmain_43:
	lw t0, -140(s0)
	bne t0, x0, .Lmain_45
.Lmain_44:
	j .Lmain_48
.Lmain_45:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -144(s0)
.Lmain_46:
	la t0, array
	lw t1, -144(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_47:
	lw a0, -120(s0)
	li a1, 0
	call mmerge
.Lmain_48:
	lw t0, -76(s0)
	lw t1, n
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -148(s0)
.Lmain_49:
	lw t0, -148(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -152(s0)
.Lmain_50:
	lw t0, -152(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -156(s0)
.Lmain_51:
	lw t0, -156(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -160(s0)
.Lmain_52:
	lw t0, -160(s0)
	bne t0, x0, .Lmain_54
.Lmain_53:
	j .Lmain_57
.Lmain_54:
	li t0, 0
	lw t1, -52(s0)
	add t2, t0, t1
	sw t2, -164(s0)
.Lmain_55:
	la t0, array
	lw t1, -164(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -52(s0)
	sw t2, 0(t0)
.Lmain_56:
	lw a0, -120(s0)
	lw a1, -52(s0)
	call mmerge
.Lmain_57:
	lw t0, -84(s0)
	lw t1, n
	slt t2, t0, t1
	sw t2, -168(s0)
.Lmain_58:
	lw t0, -168(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -172(s0)
.Lmain_59:
	li t0, 0
	sw t0, -176(s0)
.Lmain_60:
	lw t0, -172(s0)
	bne t0, x0, .Lmain_62
.Lmain_61:
	j .Lmain_70
.Lmain_62:
	lw t0, -120(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -180(s0)
.Lmain_63:
	li t0, 0
	lw t1, -180(s0)
	add t2, t0, t1
	sw t2, -184(s0)
.Lmain_64:
	la t0, array
	lw t1, -184(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -188(s0)
.Lmain_65:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -192(s0)
.Lmain_66:
	lw t0, -188(s0)
	lw t1, -192(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -196(s0)
.Lmain_67:
	lw t0, -196(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -200(s0)
.Lmain_68:
	lw t0, -200(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -204(s0)
.Lmain_69:
	lw t0, -204(s0)
	sw t0, -176(s0)
.Lmain_70:
	lw t0, -176(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -208(s0)
.Lmain_71:
	lw t0, -208(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -212(s0)
.Lmain_72:
	lw t0, -212(s0)
	bne t0, x0, .Lmain_74
.Lmain_73:
	j .Lmain_76
.Lmain_74:
	lw t0, -120(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -216(s0)
.Lmain_75:
	lw a0, -120(s0)
	lw a1, -216(s0)
	call mmerge
.Lmain_76:
	lw t0, -84(s0)
	li t1, 1
	slt t2, t1, t0
	sw t2, -220(s0)
.Lmain_77:
	lw t0, -220(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -224(s0)
.Lmain_78:
	li t0, 0
	sw t0, -228(s0)
.Lmain_79:
	lw t0, -224(s0)
	bne t0, x0, .Lmain_81
.Lmain_80:
	j .Lmain_89
.Lmain_81:
	lw t0, -120(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -232(s0)
.Lmain_82:
	li t0, 0
	lw t1, -232(s0)
	add t2, t0, t1
	sw t2, -236(s0)
.Lmain_83:
	la t0, array
	lw t1, -236(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -240(s0)
.Lmain_84:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -244(s0)
.Lmain_85:
	lw t0, -240(s0)
	lw t1, -244(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -248(s0)
.Lmain_86:
	lw t0, -248(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -252(s0)
.Lmain_87:
	lw t0, -252(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -256(s0)
.Lmain_88:
	lw t0, -256(s0)
	sw t0, -228(s0)
.Lmain_89:
	lw t0, -228(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -260(s0)
.Lmain_90:
	lw t0, -260(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -264(s0)
.Lmain_91:
	lw t0, -264(s0)
	bne t0, x0, .Lmain_93
.Lmain_92:
	j .Lmain_95
.Lmain_93:
	lw t0, -120(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -268(s0)
.Lmain_94:
	lw a0, -120(s0)
	lw a1, -268(s0)
	call mmerge
.Lmain_95:
	lw t0, -76(s0)
	lw t1, n
	slt t2, t0, t1
	sw t2, -272(s0)
.Lmain_96:
	lw t0, -272(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -276(s0)
.Lmain_97:
	li t0, 0
	sw t0, -280(s0)
.Lmain_98:
	lw t0, -276(s0)
	bne t0, x0, .Lmain_100
.Lmain_99:
	j .Lmain_108
.Lmain_100:
	lw t0, -120(s0)
	lw t1, n
	add t2, t0, t1
	sw t2, -284(s0)
.Lmain_101:
	li t0, 0
	lw t1, -284(s0)
	add t2, t0, t1
	sw t2, -288(s0)
.Lmain_102:
	la t0, array
	lw t1, -288(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -292(s0)
.Lmain_103:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -296(s0)
.Lmain_104:
	lw t0, -292(s0)
	lw t1, -296(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -300(s0)
.Lmain_105:
	lw t0, -300(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -304(s0)
.Lmain_106:
	lw t0, -304(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -308(s0)
.Lmain_107:
	lw t0, -308(s0)
	sw t0, -280(s0)
.Lmain_108:
	lw t0, -280(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -312(s0)
.Lmain_109:
	lw t0, -312(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -316(s0)
.Lmain_110:
	lw t0, -316(s0)
	bne t0, x0, .Lmain_112
.Lmain_111:
	j .Lmain_114
.Lmain_112:
	lw t0, -120(s0)
	lw t1, n
	add t2, t0, t1
	sw t2, -320(s0)
.Lmain_113:
	lw a0, -120(s0)
	lw a1, -320(s0)
	call mmerge
.Lmain_114:
	lw t0, -76(s0)
	li t1, 1
	slt t2, t1, t0
	sw t2, -324(s0)
.Lmain_115:
	lw t0, -324(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -328(s0)
.Lmain_116:
	li t0, 0
	sw t0, -332(s0)
.Lmain_117:
	lw t0, -328(s0)
	bne t0, x0, .Lmain_119
.Lmain_118:
	j .Lmain_127
.Lmain_119:
	lw t0, -120(s0)
	lw t1, n
	sub t2, t0, t1
	sw t2, -336(s0)
.Lmain_120:
	li t0, 0
	lw t1, -336(s0)
	add t2, t0, t1
	sw t2, -340(s0)
.Lmain_121:
	la t0, array
	lw t1, -340(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -344(s0)
.Lmain_122:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -348(s0)
.Lmain_123:
	lw t0, -344(s0)
	lw t1, -348(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -352(s0)
.Lmain_124:
	lw t0, -352(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -356(s0)
.Lmain_125:
	lw t0, -356(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -360(s0)
.Lmain_126:
	lw t0, -360(s0)
	sw t0, -332(s0)
.Lmain_127:
	lw t0, -332(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -364(s0)
.Lmain_128:
	lw t0, -364(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -368(s0)
.Lmain_129:
	lw t0, -368(s0)
	bne t0, x0, .Lmain_131
.Lmain_130:
	j .Lmain_133
.Lmain_131:
	lw t0, -120(s0)
	lw t1, n
	sub t2, t0, t1
	sw t2, -372(s0)
.Lmain_132:
	lw a0, -120(s0)
	lw a1, -372(s0)
	call mmerge
.Lmain_133:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -376(s0)
.Lmain_134:
	la t0, array
	lw t1, -376(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -380(s0)
.Lmain_135:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -384(s0)
.Lmain_136:
	lw t0, -380(s0)
	lw t1, -384(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -388(s0)
.Lmain_137:
	lw t0, -388(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -392(s0)
.Lmain_138:
	li t0, 0
	sw t0, -396(s0)
.Lmain_139:
	lw t0, -392(s0)
	bne t0, x0, .Lmain_141
.Lmain_140:
	j .Lmain_157
.Lmain_141:
	li t0, 0
	lw t1, -52(s0)
	add t2, t0, t1
	sw t2, -400(s0)
.Lmain_142:
	la t0, array
	lw t1, -400(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -404(s0)
.Lmain_143:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -408(s0)
.Lmain_144:
	lw t0, -404(s0)
	lw t1, -408(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -412(s0)
.Lmain_145:
	lw t0, -412(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -416(s0)
.Lmain_146:
	li t0, 0
	sw t0, -420(s0)
.Lmain_147:
	lw t0, -416(s0)
	bne t0, x0, .Lmain_149
.Lmain_148:
	j .Lmain_155
.Lmain_149:
	li a0, 0
	call findfa
	sw a0, -424(s0)
.Lmain_150:
	lw a0, -52(s0)
	call findfa
	sw a0, -428(s0)
.Lmain_151:
	lw t0, -424(s0)
	lw t1, -428(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -432(s0)
.Lmain_152:
	lw t0, -432(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -436(s0)
.Lmain_153:
	lw t0, -436(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -440(s0)
.Lmain_154:
	lw t0, -440(s0)
	sw t0, -420(s0)
.Lmain_155:
	lw t0, -420(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -444(s0)
.Lmain_156:
	lw t0, -444(s0)
	sw t0, -396(s0)
.Lmain_157:
	lw t0, -396(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -448(s0)
.Lmain_158:
	lw t0, -448(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -452(s0)
.Lmain_159:
	lw t0, -452(s0)
	bne t0, x0, .Lmain_161
.Lmain_160:
	j .Lmain_166
.Lmain_161:
	li t0, 1
	sw t0, -40(s0)
.Lmain_162:
	lw t0, -36(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -456(s0)
.Lmain_163:
	lw t0, -456(s0)
	sw t0, -460(s0)
.Lmain_164:
	lw a0, -460(s0)
	call putint
.Lmain_165:
	li a0, 10
	call putch
.Lmain_166:
	lw t0, -36(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -464(s0)
.Lmain_167:
	lw t0, -464(s0)
	sw t0, -36(s0)
.Lmain_168:
	j .Lmain_16
.Lmain_169:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -468(s0)
.Lmain_170:
	lw t0, -468(s0)
	seqz t2, t0
	sw t2, -472(s0)
.Lmain_171:
	lw t0, -472(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -476(s0)
.Lmain_172:
	lw t0, -476(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -480(s0)
.Lmain_173:
	lw t0, -480(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -484(s0)
.Lmain_174:
	lw t0, -484(s0)
	bne t0, x0, .Lmain_176
.Lmain_175:
	j .Lmain_179
.Lmain_176:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -488(s0)
.Lmain_177:
	lw a0, -488(s0)
	call putint
.Lmain_178:
	li a0, 10
	call putch
.Lmain_179:
	j .Lmain_1
.Lmain_180:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 492(sp)
	lw s0, 488(sp)
	addi sp, sp, 496
	jr ra
