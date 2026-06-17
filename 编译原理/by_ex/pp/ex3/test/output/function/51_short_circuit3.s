.data
.globl a
a:
	.word 0
.globl b
b:
	.word 0
.globl d
d:
	.word 0
.text
.globl set_a
set_a:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
	sw a0, -12(s0)
.Lset_a_0:
	lw t0, -12(s0)
	sw t0, a
.Lset_a_1:
	lw a0, a
	j .Lset_a_epilogue
.Lset_a_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl set_b
set_b:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
	sw a0, -12(s0)
.Lset_b_0:
	lw t0, -12(s0)
	sw t0, b
.Lset_b_1:
	lw a0, b
	j .Lset_b_epilogue
.Lset_b_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl set_d
set_d:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
	sw a0, -12(s0)
.Lset_d_0:
	lw t0, -12(s0)
	sw t0, d
.Lset_d_1:
	lw a0, d
	j .Lset_d_epilogue
.Lset_d_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl main
main:
	addi sp, sp, -576
	sw ra, 572(sp)
	sw s0, 568(sp)
	addi s0, sp, 576
.Lmain_0:
	li t0, 2
	sw t0, a
.Lmain_1:
	li t0, 3
	sw t0, b
.Lmain_2:
	li a0, 0
	call set_a
	sw a0, -12(s0)
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
	li a0, 1
	call set_b
	sw a0, -24(s0)
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
	bne t0, x0, .Lmain_15
.Lmain_14:
	j .Lmain_15
.Lmain_15:
	lw a0, a
	call putint
.Lmain_16:
	li a0, 32
	call putch
.Lmain_17:
	lw a0, b
	call putint
.Lmain_18:
	li a0, 32
	call putch
.Lmain_19:
	li t0, 2
	sw t0, a
.Lmain_20:
	li t0, 3
	sw t0, b
.Lmain_21:
	li a0, 0
	call set_a
	sw a0, -44(s0)
.Lmain_22:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmain_23:
	li t0, 0
	sw t0, -52(s0)
.Lmain_24:
	lw t0, -48(s0)
	bne t0, x0, .Lmain_26
.Lmain_25:
	j .Lmain_30
.Lmain_26:
	li a0, 1
	call set_b
	sw a0, -56(s0)
.Lmain_27:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lmain_28:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lmain_29:
	lw t0, -64(s0)
	sw t0, -52(s0)
.Lmain_30:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_31:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.Lmain_32:
	lw t0, -72(s0)
	bne t0, x0, .Lmain_34
.Lmain_33:
	j .Lmain_34
.Lmain_34:
	lw a0, a
	call putint
.Lmain_35:
	li a0, 32
	call putch
.Lmain_36:
	lw a0, b
	call putint
.Lmain_37:
	li a0, 10
	call putch
.Lmain_38:
	li t0, 2
	sw t0, d
.Lmain_39:
	li t0, 1
	li t1, 1
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -76(s0)
.Lmain_40:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.Lmain_41:
	li t0, 0
	sw t0, -84(s0)
.Lmain_42:
	lw t0, -80(s0)
	bne t0, x0, .Lmain_44
.Lmain_43:
	j .Lmain_48
.Lmain_44:
	li a0, 3
	call set_d
	sw a0, -88(s0)
.Lmain_45:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -92(s0)
.Lmain_46:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.Lmain_47:
	lw t0, -96(s0)
	sw t0, -84(s0)
.Lmain_48:
	lw t0, -84(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lmain_49:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.Lmain_50:
	lw t0, -104(s0)
	bne t0, x0, .Lmain_52
.Lmain_51:
	j .Lmain_52
.Lmain_52:
	lw a0, d
	call putint
.Lmain_53:
	li a0, 32
	call putch
.Lmain_54:
	li t0, 1
	li t1, 1
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -108(s0)
.Lmain_55:
	lw t0, -108(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.Lmain_56:
	lw t0, -112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -116(s0)
.Lmain_57:
	li t0, 1
	sw t0, -120(s0)
.Lmain_58:
	lw t0, -116(s0)
	seqz t2, t0
	sw t2, -124(s0)
.Lmain_59:
	lw t0, -124(s0)
	bne t0, x0, .Lmain_61
.Lmain_60:
	j .Lmain_66
.Lmain_61:
	li a0, 4
	call set_d
	sw a0, -128(s0)
.Lmain_62:
	lw t0, -128(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -132(s0)
.Lmain_63:
	lw t0, -132(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -136(s0)
.Lmain_64:
	lw t0, -136(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -140(s0)
.Lmain_65:
	lw t0, -140(s0)
	sw t0, -120(s0)
.Lmain_66:
	lw t0, -120(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -144(s0)
.Lmain_67:
	lw t0, -144(s0)
	bne t0, x0, .Lmain_69
.Lmain_68:
	j .Lmain_69
.Lmain_69:
	lw a0, d
	call putint
.Lmain_70:
	li a0, 10
	call putch
.Lmain_71:
	li t0, 2
	li t1, 1
	add t2, t0, t1
	sw t2, -148(s0)
.Lmain_72:
	li t0, 3
	lw t1, -148(s0)
	sub t2, t0, t1
	sw t2, -152(s0)
.Lmain_73:
	li t0, 16
	lw t1, -152(s0)
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -156(s0)
.Lmain_74:
	lw t0, -156(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -160(s0)
.Lmain_75:
	lw t0, -160(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -164(s0)
.Lmain_76:
	lw t0, -164(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -168(s0)
.Lmain_77:
	lw t0, -168(s0)
	bne t0, x0, .Lmain_79
.Lmain_78:
	j .Lmain_80
.Lmain_79:
	li a0, 65
	call putch
.Lmain_80:
	li t0, 25
	li t1, 7
	sub t2, t0, t1
	sw t2, -172(s0)
.Lmain_81:
	li t0, 6
	li t1, 3
	mul t2, t0, t1
	sw t2, -176(s0)
.Lmain_82:
	li t0, 36
	lw t1, -176(s0)
	sub t2, t0, t1
	sw t2, -180(s0)
.Lmain_83:
	lw t0, -172(s0)
	lw t1, -180(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -184(s0)
.Lmain_84:
	lw t0, -184(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -188(s0)
.Lmain_85:
	lw t0, -188(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -192(s0)
.Lmain_86:
	lw t0, -192(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -196(s0)
.Lmain_87:
	lw t0, -196(s0)
	bne t0, x0, .Lmain_89
.Lmain_88:
	j .Lmain_90
.Lmain_89:
	li a0, 66
	call putch
.Lmain_90:
	li t0, 1
	li t1, 8
	slt t2, t0, t1
	sw t2, -200(s0)
.Lmain_91:
	li t0, 7
	li t1, 2
	rem t2, t0, t1
	sw t2, -204(s0)
.Lmain_92:
	lw t0, -200(s0)
	lw t1, -204(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -208(s0)
.Lmain_93:
	lw t0, -208(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -212(s0)
.Lmain_94:
	lw t0, -212(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -216(s0)
.Lmain_95:
	lw t0, -216(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -220(s0)
.Lmain_96:
	lw t0, -220(s0)
	bne t0, x0, .Lmain_98
.Lmain_97:
	j .Lmain_99
.Lmain_98:
	li a0, 67
	call putch
.Lmain_99:
	li t0, 3
	li t1, 4
	slt t2, t1, t0
	sw t2, -224(s0)
.Lmain_100:
	lw t0, -224(s0)
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -228(s0)
.Lmain_101:
	lw t0, -228(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -232(s0)
.Lmain_102:
	lw t0, -232(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -236(s0)
.Lmain_103:
	lw t0, -236(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -240(s0)
.Lmain_104:
	lw t0, -240(s0)
	bne t0, x0, .Lmain_106
.Lmain_105:
	j .Lmain_107
.Lmain_106:
	li a0, 68
	call putch
.Lmain_107:
	li t0, 102
	li t1, 63
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -244(s0)
.Lmain_108:
	li t0, 1
	lw t1, -244(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -248(s0)
.Lmain_109:
	lw t0, -248(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -252(s0)
.Lmain_110:
	lw t0, -252(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -256(s0)
.Lmain_111:
	lw t0, -256(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -260(s0)
.Lmain_112:
	lw t0, -260(s0)
	bne t0, x0, .Lmain_114
.Lmain_113:
	j .Lmain_115
.Lmain_114:
	li a0, 69
	call putch
.Lmain_115:
	li t0, 5
	li t1, 6
	sub t2, t0, t1
	sw t2, -264(s0)
.Lmain_116:
	li t0, 0
	seqz t2, t0
	sw t2, -268(s0)
.Lmain_117:
	li t0, 0
	lw t1, -268(s0)
	sub t2, t0, t1
	sw t2, -272(s0)
.Lmain_118:
	lw t0, -264(s0)
	lw t1, -272(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -276(s0)
.Lmain_119:
	lw t0, -276(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -280(s0)
.Lmain_120:
	lw t0, -280(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -284(s0)
.Lmain_121:
	lw t0, -284(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -288(s0)
.Lmain_122:
	lw t0, -288(s0)
	bne t0, x0, .Lmain_124
.Lmain_123:
	j .Lmain_125
.Lmain_124:
	li a0, 70
	call putch
.Lmain_125:
	li a0, 10
	call putch
.Lmain_126:
	li t0, 0
	sw t0, -292(s0)
.Lmain_127:
	li t0, 1
	sw t0, -296(s0)
.Lmain_128:
	li t0, 2
	sw t0, -300(s0)
.Lmain_129:
	li t0, 3
	sw t0, -304(s0)
.Lmain_130:
	li t0, 4
	sw t0, -308(s0)
.Lmain_131:
	lw t0, -292(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -312(s0)
.Lmain_132:
	li t0, 0
	sw t0, -316(s0)
.Lmain_133:
	lw t0, -312(s0)
	bne t0, x0, .Lmain_135
.Lmain_134:
	j .Lmain_138
.Lmain_135:
	lw t0, -296(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -320(s0)
.Lmain_136:
	lw t0, -320(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -324(s0)
.Lmain_137:
	lw t0, -324(s0)
	sw t0, -316(s0)
.Lmain_138:
	lw t0, -316(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -328(s0)
.Lmain_139:
	lw t0, -328(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -332(s0)
.Lmain_140:
	lw t0, -332(s0)
	bne t0, x0, .Lmain_142
.Lmain_141:
	j .Lmain_144
.Lmain_142:
	li a0, 32
	call putch
.Lmain_143:
	j .Lmain_131
.Lmain_144:
	lw t0, -292(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -336(s0)
.Lmain_145:
	lw t0, -336(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -340(s0)
.Lmain_146:
	li t0, 1
	sw t0, -344(s0)
.Lmain_147:
	lw t0, -340(s0)
	seqz t2, t0
	sw t2, -348(s0)
.Lmain_148:
	lw t0, -348(s0)
	bne t0, x0, .Lmain_150
.Lmain_149:
	j .Lmain_154
.Lmain_150:
	lw t0, -296(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -352(s0)
.Lmain_151:
	lw t0, -352(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -356(s0)
.Lmain_152:
	lw t0, -356(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -360(s0)
.Lmain_153:
	lw t0, -360(s0)
	sw t0, -344(s0)
.Lmain_154:
	lw t0, -344(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -364(s0)
.Lmain_155:
	lw t0, -364(s0)
	bne t0, x0, .Lmain_157
.Lmain_156:
	j .Lmain_158
.Lmain_157:
	li a0, 67
	call putch
.Lmain_158:
	lw t0, -292(s0)
	lw t1, -296(s0)
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -368(s0)
.Lmain_159:
	lw t0, -368(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -372(s0)
.Lmain_160:
	lw t0, -372(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -376(s0)
.Lmain_161:
	li t0, 1
	sw t0, -380(s0)
.Lmain_162:
	lw t0, -376(s0)
	seqz t2, t0
	sw t2, -384(s0)
.Lmain_163:
	lw t0, -384(s0)
	bne t0, x0, .Lmain_165
.Lmain_164:
	j .Lmain_170
.Lmain_165:
	lw t0, -296(s0)
	lw t1, -292(s0)
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -388(s0)
.Lmain_166:
	lw t0, -388(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -392(s0)
.Lmain_167:
	lw t0, -392(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -396(s0)
.Lmain_168:
	lw t0, -396(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -400(s0)
.Lmain_169:
	lw t0, -400(s0)
	sw t0, -380(s0)
.Lmain_170:
	lw t0, -380(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -404(s0)
.Lmain_171:
	lw t0, -404(s0)
	bne t0, x0, .Lmain_173
.Lmain_172:
	j .Lmain_174
.Lmain_173:
	li a0, 72
	call putch
.Lmain_174:
	lw t0, -300(s0)
	lw t1, -296(s0)
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -408(s0)
.Lmain_175:
	lw t0, -408(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -412(s0)
.Lmain_176:
	li t0, 0
	sw t0, -416(s0)
.Lmain_177:
	lw t0, -412(s0)
	bne t0, x0, .Lmain_179
.Lmain_178:
	j .Lmain_183
.Lmain_179:
	lw t0, -308(s0)
	lw t1, -304(s0)
	xor t2, t0, t1
	snez t2, t2
	sw t2, -420(s0)
.Lmain_180:
	lw t0, -420(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -424(s0)
.Lmain_181:
	lw t0, -424(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -428(s0)
.Lmain_182:
	lw t0, -428(s0)
	sw t0, -416(s0)
.Lmain_183:
	lw t0, -416(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -432(s0)
.Lmain_184:
	lw t0, -432(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -436(s0)
.Lmain_185:
	lw t0, -436(s0)
	bne t0, x0, .Lmain_187
.Lmain_186:
	j .Lmain_188
.Lmain_187:
	li a0, 73
	call putch
.Lmain_188:
	lw t0, -296(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -440(s0)
.Lmain_189:
	lw t0, -440(s0)
	seqz t2, t0
	sw t2, -444(s0)
.Lmain_190:
	lw t0, -292(s0)
	lw t1, -444(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -448(s0)
.Lmain_191:
	lw t0, -448(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -452(s0)
.Lmain_192:
	li t0, 0
	sw t0, -456(s0)
.Lmain_193:
	lw t0, -452(s0)
	bne t0, x0, .Lmain_195
.Lmain_194:
	j .Lmain_199
.Lmain_195:
	lw t0, -304(s0)
	lw t1, -304(s0)
	slt t2, t0, t1
	sw t2, -460(s0)
.Lmain_196:
	lw t0, -460(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -464(s0)
.Lmain_197:
	lw t0, -464(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -468(s0)
.Lmain_198:
	lw t0, -468(s0)
	sw t0, -456(s0)
.Lmain_199:
	lw t0, -456(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -472(s0)
.Lmain_200:
	li t0, 1
	sw t0, -476(s0)
.Lmain_201:
	lw t0, -472(s0)
	seqz t2, t0
	sw t2, -480(s0)
.Lmain_202:
	lw t0, -480(s0)
	bne t0, x0, .Lmain_204
.Lmain_203:
	j .Lmain_209
.Lmain_204:
	lw t0, -308(s0)
	lw t1, -308(s0)
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -484(s0)
.Lmain_205:
	lw t0, -484(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -488(s0)
.Lmain_206:
	lw t0, -488(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -492(s0)
.Lmain_207:
	lw t0, -492(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -496(s0)
.Lmain_208:
	lw t0, -496(s0)
	sw t0, -476(s0)
.Lmain_209:
	lw t0, -476(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -500(s0)
.Lmain_210:
	lw t0, -500(s0)
	bne t0, x0, .Lmain_212
.Lmain_211:
	j .Lmain_213
.Lmain_212:
	li a0, 74
	call putch
.Lmain_213:
	lw t0, -296(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -504(s0)
.Lmain_214:
	lw t0, -504(s0)
	seqz t2, t0
	sw t2, -508(s0)
.Lmain_215:
	lw t0, -292(s0)
	lw t1, -508(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -512(s0)
.Lmain_216:
	lw t0, -512(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -516(s0)
.Lmain_217:
	lw t0, -516(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -520(s0)
.Lmain_218:
	li t0, 1
	sw t0, -524(s0)
.Lmain_219:
	lw t0, -520(s0)
	seqz t2, t0
	sw t2, -528(s0)
.Lmain_220:
	lw t0, -528(s0)
	bne t0, x0, .Lmain_222
.Lmain_221:
	j .Lmain_234
.Lmain_222:
	lw t0, -304(s0)
	lw t1, -304(s0)
	slt t2, t0, t1
	sw t2, -532(s0)
.Lmain_223:
	lw t0, -532(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -536(s0)
.Lmain_224:
	li t0, 0
	sw t0, -540(s0)
.Lmain_225:
	lw t0, -536(s0)
	bne t0, x0, .Lmain_227
.Lmain_226:
	j .Lmain_231
.Lmain_227:
	lw t0, -308(s0)
	lw t1, -308(s0)
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -544(s0)
.Lmain_228:
	lw t0, -544(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -548(s0)
.Lmain_229:
	lw t0, -548(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -552(s0)
.Lmain_230:
	lw t0, -552(s0)
	sw t0, -540(s0)
.Lmain_231:
	lw t0, -540(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -556(s0)
.Lmain_232:
	lw t0, -556(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -560(s0)
.Lmain_233:
	lw t0, -560(s0)
	sw t0, -524(s0)
.Lmain_234:
	lw t0, -524(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -564(s0)
.Lmain_235:
	lw t0, -564(s0)
	bne t0, x0, .Lmain_237
.Lmain_236:
	j .Lmain_238
.Lmain_237:
	li a0, 75
	call putch
.Lmain_238:
	li a0, 10
	call putch
.Lmain_239:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 572(sp)
	lw s0, 568(sp)
	addi sp, sp, 576
	jr ra
