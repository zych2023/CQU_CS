.data
.globl e
e:
	.zero 1024
.globl book
book:
	.zero 64
.globl dis
dis:
	.zero 64
.globl n
n:
	.word 0
.globl m
m:
	.word 0
.globl v1
v1:
	.word 0
.globl v2
v2:
	.word 0
.globl w
w:
	.word 0
.text
.globl Dijkstra
Dijkstra:
	addi sp, sp, -320
	sw ra, 316(sp)
	sw s0, 312(sp)
	addi s0, sp, 320
.LDijkstra_0:
	li t0, 1
	sw t0, -12(s0)
.LDijkstra_1:
	lw t0, -12(s0)
	lw t1, n
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -16(s0)
.LDijkstra_2:
	lw t0, -16(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -20(s0)
.LDijkstra_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.LDijkstra_4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.LDijkstra_5:
	lw t0, -28(s0)
	bne t0, x0, .LDijkstra_7
.LDijkstra_6:
	j .LDijkstra_18
.LDijkstra_7:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -32(s0)
.LDijkstra_8:
	li t0, 1
	li t1, 16
	mul t2, t0, t1
	sw t2, -36(s0)
.LDijkstra_9:
	li t0, 0
	lw t1, -36(s0)
	add t2, t0, t1
	sw t2, -40(s0)
.LDijkstra_10:
	lw t0, -40(s0)
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -44(s0)
.LDijkstra_11:
	la t0, e
	lw t1, -44(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -48(s0)
.LDijkstra_12:
	la t0, dis
	lw t1, -32(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -48(s0)
	sw t2, 0(t0)
.LDijkstra_13:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -52(s0)
.LDijkstra_14:
	la t0, book
	lw t1, -52(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.LDijkstra_15:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -56(s0)
.LDijkstra_16:
	lw t0, -56(s0)
	sw t0, -12(s0)
.LDijkstra_17:
	j .LDijkstra_1
.LDijkstra_18:
	li t0, 0
	li t1, 1
	add t2, t0, t1
	sw t2, -60(s0)
.LDijkstra_19:
	la t0, book
	lw t1, -60(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.LDijkstra_20:
	li t0, 1
	sw t0, -12(s0)
.LDijkstra_21:
	lw t0, n
	li t1, 1
	sub t2, t0, t1
	sw t2, -64(s0)
.LDijkstra_22:
	lw t0, -12(s0)
	lw t1, -64(s0)
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -68(s0)
.LDijkstra_23:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.LDijkstra_24:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.LDijkstra_25:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.LDijkstra_26:
	lw t0, -80(s0)
	bne t0, x0, .LDijkstra_28
.LDijkstra_27:
	j .LDijkstra_110
.LDijkstra_28:
	li t0, 65535
	sw t0, -84(s0)
.LDijkstra_29:
	li t0, 0
	sw t0, -88(s0)
.LDijkstra_30:
	li t0, 1
	sw t0, -92(s0)
.LDijkstra_31:
	lw t0, -92(s0)
	lw t1, n
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -96(s0)
.LDijkstra_32:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.LDijkstra_33:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.LDijkstra_34:
	lw t0, -104(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -108(s0)
.LDijkstra_35:
	lw t0, -108(s0)
	bne t0, x0, .LDijkstra_37
.LDijkstra_36:
	j .LDijkstra_61
.LDijkstra_37:
	li t0, 0
	lw t1, -92(s0)
	add t2, t0, t1
	sw t2, -112(s0)
.LDijkstra_38:
	la t0, dis
	lw t1, -112(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -116(s0)
.LDijkstra_39:
	lw t0, -84(s0)
	lw t1, -116(s0)
	slt t2, t1, t0
	sw t2, -120(s0)
.LDijkstra_40:
	lw t0, -120(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -124(s0)
.LDijkstra_41:
	li t0, 0
	sw t0, -128(s0)
.LDijkstra_42:
	lw t0, -124(s0)
	bne t0, x0, .LDijkstra_44
.LDijkstra_43:
	j .LDijkstra_50
.LDijkstra_44:
	li t0, 0
	lw t1, -92(s0)
	add t2, t0, t1
	sw t2, -132(s0)
.LDijkstra_45:
	la t0, book
	lw t1, -132(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -136(s0)
.LDijkstra_46:
	lw t0, -136(s0)
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -140(s0)
.LDijkstra_47:
	lw t0, -140(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -144(s0)
.LDijkstra_48:
	lw t0, -144(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -148(s0)
.LDijkstra_49:
	lw t0, -148(s0)
	sw t0, -128(s0)
.LDijkstra_50:
	lw t0, -128(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -152(s0)
.LDijkstra_51:
	lw t0, -152(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -156(s0)
.LDijkstra_52:
	lw t0, -156(s0)
	bne t0, x0, .LDijkstra_54
.LDijkstra_53:
	j .LDijkstra_58
.LDijkstra_54:
	li t0, 0
	lw t1, -92(s0)
	add t2, t0, t1
	sw t2, -160(s0)
.LDijkstra_55:
	la t0, dis
	lw t1, -160(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -164(s0)
.LDijkstra_56:
	lw t0, -164(s0)
	sw t0, -84(s0)
.LDijkstra_57:
	lw t0, -92(s0)
	sw t0, -88(s0)
.LDijkstra_58:
	lw t0, -92(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -168(s0)
.LDijkstra_59:
	lw t0, -168(s0)
	sw t0, -92(s0)
.LDijkstra_60:
	j .LDijkstra_31
.LDijkstra_61:
	li t0, 0
	lw t1, -88(s0)
	add t2, t0, t1
	sw t2, -172(s0)
.LDijkstra_62:
	la t0, book
	lw t1, -172(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.LDijkstra_63:
	li t0, 1
	sw t0, -176(s0)
.LDijkstra_64:
	lw t0, -176(s0)
	lw t1, n
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -180(s0)
.LDijkstra_65:
	lw t0, -180(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -184(s0)
.LDijkstra_66:
	lw t0, -184(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -188(s0)
.LDijkstra_67:
	lw t0, -188(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -192(s0)
.LDijkstra_68:
	lw t0, -192(s0)
	bne t0, x0, .LDijkstra_70
.LDijkstra_69:
	j .LDijkstra_107
.LDijkstra_70:
	lw t0, -88(s0)
	li t1, 16
	mul t2, t0, t1
	sw t2, -196(s0)
.LDijkstra_71:
	li t0, 0
	lw t1, -196(s0)
	add t2, t0, t1
	sw t2, -200(s0)
.LDijkstra_72:
	lw t0, -200(s0)
	lw t1, -176(s0)
	add t2, t0, t1
	sw t2, -204(s0)
.LDijkstra_73:
	la t0, e
	lw t1, -204(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -208(s0)
.LDijkstra_74:
	lw t0, -208(s0)
	li t1, 65535
	slt t2, t0, t1
	sw t2, -212(s0)
.LDijkstra_75:
	lw t0, -212(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -216(s0)
.LDijkstra_76:
	lw t0, -216(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -220(s0)
.LDijkstra_77:
	lw t0, -220(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -224(s0)
.LDijkstra_78:
	lw t0, -224(s0)
	bne t0, x0, .LDijkstra_80
.LDijkstra_79:
	j .LDijkstra_104
.LDijkstra_80:
	li t0, 0
	lw t1, -176(s0)
	add t2, t0, t1
	sw t2, -228(s0)
.LDijkstra_81:
	la t0, dis
	lw t1, -228(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -232(s0)
.LDijkstra_82:
	li t0, 0
	lw t1, -88(s0)
	add t2, t0, t1
	sw t2, -236(s0)
.LDijkstra_83:
	la t0, dis
	lw t1, -236(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -240(s0)
.LDijkstra_84:
	lw t0, -88(s0)
	li t1, 16
	mul t2, t0, t1
	sw t2, -244(s0)
.LDijkstra_85:
	li t0, 0
	lw t1, -244(s0)
	add t2, t0, t1
	sw t2, -248(s0)
.LDijkstra_86:
	lw t0, -248(s0)
	lw t1, -176(s0)
	add t2, t0, t1
	sw t2, -252(s0)
.LDijkstra_87:
	la t0, e
	lw t1, -252(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -256(s0)
.LDijkstra_88:
	lw t0, -240(s0)
	lw t1, -256(s0)
	add t2, t0, t1
	sw t2, -260(s0)
.LDijkstra_89:
	lw t0, -232(s0)
	lw t1, -260(s0)
	slt t2, t1, t0
	sw t2, -264(s0)
.LDijkstra_90:
	lw t0, -264(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -268(s0)
.LDijkstra_91:
	lw t0, -268(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -272(s0)
.LDijkstra_92:
	lw t0, -272(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -276(s0)
.LDijkstra_93:
	lw t0, -276(s0)
	bne t0, x0, .LDijkstra_95
.LDijkstra_94:
	j .LDijkstra_104
.LDijkstra_95:
	li t0, 0
	lw t1, -176(s0)
	add t2, t0, t1
	sw t2, -280(s0)
.LDijkstra_96:
	li t0, 0
	lw t1, -88(s0)
	add t2, t0, t1
	sw t2, -284(s0)
.LDijkstra_97:
	la t0, dis
	lw t1, -284(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -288(s0)
.LDijkstra_98:
	lw t0, -88(s0)
	li t1, 16
	mul t2, t0, t1
	sw t2, -292(s0)
.LDijkstra_99:
	li t0, 0
	lw t1, -292(s0)
	add t2, t0, t1
	sw t2, -296(s0)
.LDijkstra_100:
	lw t0, -296(s0)
	lw t1, -176(s0)
	add t2, t0, t1
	sw t2, -300(s0)
.LDijkstra_101:
	la t0, e
	lw t1, -300(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -304(s0)
.LDijkstra_102:
	lw t0, -288(s0)
	lw t1, -304(s0)
	add t2, t0, t1
	sw t2, -308(s0)
.LDijkstra_103:
	la t0, dis
	lw t1, -280(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -308(s0)
	sw t2, 0(t0)
.LDijkstra_104:
	lw t0, -176(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -312(s0)
.LDijkstra_105:
	lw t0, -312(s0)
	sw t0, -176(s0)
.LDijkstra_106:
	j .LDijkstra_64
.LDijkstra_107:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -316(s0)
.LDijkstra_108:
	lw t0, -316(s0)
	sw t0, -12(s0)
.LDijkstra_109:
	j .LDijkstra_21
.LDijkstra_110:
	j .LDijkstra_epilogue
.LDijkstra_epilogue:
	lw ra, 316(sp)
	lw s0, 312(sp)
	addi sp, sp, 320
	jr ra
.globl main
main:
	addi sp, sp, -192
	sw ra, 188(sp)
	sw s0, 184(sp)
	addi s0, sp, 192
.Lmain_0:
	call getint
	sw a0, -12(s0)
.Lmain_1:
	lw t0, -12(s0)
	sw t0, n
.Lmain_2:
	call getint
	sw a0, -16(s0)
.Lmain_3:
	lw t0, -16(s0)
	sw t0, m
.Lmain_4:
	li t0, 1
	sw t0, -20(s0)
.Lmain_5:
	lw t0, -20(s0)
	lw t1, n
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -24(s0)
.Lmain_6:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lmain_7:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmain_8:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lmain_9:
	lw t0, -36(s0)
	bne t0, x0, .Lmain_11
.Lmain_10:
	j .Lmain_38
.Lmain_11:
	li t0, 1
	sw t0, -40(s0)
.Lmain_12:
	lw t0, -40(s0)
	lw t1, n
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -44(s0)
.Lmain_13:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmain_14:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.Lmain_15:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.Lmain_16:
	lw t0, -56(s0)
	bne t0, x0, .Lmain_18
.Lmain_17:
	j .Lmain_35
.Lmain_18:
	lw t0, -20(s0)
	lw t1, -40(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -60(s0)
.Lmain_19:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lmain_20:
	lw t0, -64(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_21:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.Lmain_22:
	lw t0, -72(s0)
	bne t0, x0, .Lmain_28
.Lmain_23:
	lw t0, -20(s0)
	li t1, 16
	mul t2, t0, t1
	sw t2, -76(s0)
.Lmain_24:
	li t0, 0
	lw t1, -76(s0)
	add t2, t0, t1
	sw t2, -80(s0)
.Lmain_25:
	lw t0, -80(s0)
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -84(s0)
.Lmain_26:
	la t0, e
	lw t1, -84(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 65535
	sw t2, 0(t0)
.Lmain_27:
	j .Lmain_32
.Lmain_28:
	lw t0, -20(s0)
	li t1, 16
	mul t2, t0, t1
	sw t2, -88(s0)
.Lmain_29:
	li t0, 0
	lw t1, -88(s0)
	add t2, t0, t1
	sw t2, -92(s0)
.Lmain_30:
	lw t0, -92(s0)
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -96(s0)
.Lmain_31:
	la t0, e
	lw t1, -96(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_32:
	lw t0, -40(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -100(s0)
.Lmain_33:
	lw t0, -100(s0)
	sw t0, -40(s0)
.Lmain_34:
	j .Lmain_12
.Lmain_35:
	lw t0, -20(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -104(s0)
.Lmain_36:
	lw t0, -104(s0)
	sw t0, -20(s0)
.Lmain_37:
	j .Lmain_5
.Lmain_38:
	li t0, 1
	sw t0, -20(s0)
.Lmain_39:
	lw t0, -20(s0)
	lw t1, m
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -108(s0)
.Lmain_40:
	lw t0, -108(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.Lmain_41:
	lw t0, -112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -116(s0)
.Lmain_42:
	lw t0, -116(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -120(s0)
.Lmain_43:
	lw t0, -120(s0)
	bne t0, x0, .Lmain_45
.Lmain_44:
	j .Lmain_57
.Lmain_45:
	call getint
	sw a0, -124(s0)
.Lmain_46:
	lw t0, -124(s0)
	sw t0, -128(s0)
.Lmain_47:
	call getint
	sw a0, -132(s0)
.Lmain_48:
	lw t0, -132(s0)
	sw t0, -136(s0)
.Lmain_49:
	lw t0, -128(s0)
	li t1, 16
	mul t2, t0, t1
	sw t2, -140(s0)
.Lmain_50:
	li t0, 0
	lw t1, -140(s0)
	add t2, t0, t1
	sw t2, -144(s0)
.Lmain_51:
	lw t0, -144(s0)
	lw t1, -136(s0)
	add t2, t0, t1
	sw t2, -148(s0)
.Lmain_52:
	call getint
	sw a0, -152(s0)
.Lmain_53:
	la t0, e
	lw t1, -148(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -152(s0)
	sw t2, 0(t0)
.Lmain_54:
	lw t0, -20(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -156(s0)
.Lmain_55:
	lw t0, -156(s0)
	sw t0, -20(s0)
.Lmain_56:
	j .Lmain_39
.Lmain_57:
	call Dijkstra
.Lmain_58:
	li t0, 1
	sw t0, -20(s0)
.Lmain_59:
	lw t0, -20(s0)
	lw t1, n
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -160(s0)
.Lmain_60:
	lw t0, -160(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -164(s0)
.Lmain_61:
	lw t0, -164(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -168(s0)
.Lmain_62:
	lw t0, -168(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -172(s0)
.Lmain_63:
	lw t0, -172(s0)
	bne t0, x0, .Lmain_65
.Lmain_64:
	j .Lmain_72
.Lmain_65:
	li t0, 0
	lw t1, -20(s0)
	add t2, t0, t1
	sw t2, -176(s0)
.Lmain_66:
	la t0, dis
	lw t1, -176(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -180(s0)
.Lmain_67:
	lw a0, -180(s0)
	call putint
.Lmain_68:
	li a0, 32
	call putch
.Lmain_69:
	lw t0, -20(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -184(s0)
.Lmain_70:
	lw t0, -184(s0)
	sw t0, -20(s0)
.Lmain_71:
	j .Lmain_59
.Lmain_72:
	li a0, 10
	call putch
.Lmain_73:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 188(sp)
	lw s0, 184(sp)
	addi sp, sp, 192
	jr ra
