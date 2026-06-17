.data
.globl g
g:
	.word 0
.text
.globl func
func:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
	sw a0, -12(s0)
.Lfunc_0:
	lw t0, g
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -16(s0)
.Lfunc_1:
	lw t0, -16(s0)
	sw t0, g
.Lfunc_2:
	lw a0, g
	call putint
.Lfunc_3:
	lw a0, g
	j .Lfunc_epilogue
.Lfunc_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl main
main:
	addi sp, sp, -224
	sw ra, 220(sp)
	sw s0, 216(sp)
	addi s0, sp, 224
.Lmain_0:
	call __global_init
.Lmain_1:
	call getint
	sw a0, -12(s0)
.Lmain_2:
	lw t0, -12(s0)
	sw t0, -16(s0)
.Lmain_3:
	lw t0, -16(s0)
	li t1, 10
	slt t2, t1, t0
	sw t2, -20(s0)
.Lmain_4:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lmain_5:
	li t0, 0
	sw t0, -28(s0)
.Lmain_6:
	lw t0, -24(s0)
	bne t0, x0, .Lmain_8
.Lmain_7:
	j .Lmain_12
.Lmain_8:
	lw a0, -16(s0)
	call func
	sw a0, -32(s0)
.Lmain_9:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lmain_10:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lmain_11:
	lw t0, -40(s0)
	sw t0, -28(s0)
.Lmain_12:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lmain_13:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmain_14:
	lw t0, -48(s0)
	bne t0, x0, .Lmain_17
.Lmain_15:
	li t0, 0
	sw t0, -16(s0)
.Lmain_16:
	j .Lmain_18
.Lmain_17:
	li t0, 1
	sw t0, -16(s0)
.Lmain_18:
	call getint
	sw a0, -52(s0)
.Lmain_19:
	lw t0, -52(s0)
	sw t0, -16(s0)
.Lmain_20:
	lw t0, -16(s0)
	li t1, 11
	slt t2, t1, t0
	sw t2, -56(s0)
.Lmain_21:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lmain_22:
	li t0, 0
	sw t0, -64(s0)
.Lmain_23:
	lw t0, -60(s0)
	bne t0, x0, .Lmain_25
.Lmain_24:
	j .Lmain_29
.Lmain_25:
	lw a0, -16(s0)
	call func
	sw a0, -68(s0)
.Lmain_26:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.Lmain_27:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.Lmain_28:
	lw t0, -76(s0)
	sw t0, -64(s0)
.Lmain_29:
	lw t0, -64(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.Lmain_30:
	lw t0, -80(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -84(s0)
.Lmain_31:
	lw t0, -84(s0)
	bne t0, x0, .Lmain_34
.Lmain_32:
	li t0, 0
	sw t0, -16(s0)
.Lmain_33:
	j .Lmain_35
.Lmain_34:
	li t0, 1
	sw t0, -16(s0)
.Lmain_35:
	call getint
	sw a0, -88(s0)
.Lmain_36:
	lw t0, -88(s0)
	sw t0, -16(s0)
.Lmain_37:
	lw t0, -16(s0)
	li t1, 99
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -92(s0)
.Lmain_38:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.Lmain_39:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lmain_40:
	li t0, 1
	sw t0, -104(s0)
.Lmain_41:
	lw t0, -100(s0)
	seqz t2, t0
	sw t2, -108(s0)
.Lmain_42:
	lw t0, -108(s0)
	bne t0, x0, .Lmain_44
.Lmain_43:
	j .Lmain_49
.Lmain_44:
	lw a0, -16(s0)
	call func
	sw a0, -112(s0)
.Lmain_45:
	lw t0, -112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -116(s0)
.Lmain_46:
	lw t0, -116(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -120(s0)
.Lmain_47:
	lw t0, -120(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -124(s0)
.Lmain_48:
	lw t0, -124(s0)
	sw t0, -104(s0)
.Lmain_49:
	lw t0, -104(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -128(s0)
.Lmain_50:
	lw t0, -128(s0)
	bne t0, x0, .Lmain_53
.Lmain_51:
	li t0, 0
	sw t0, -16(s0)
.Lmain_52:
	j .Lmain_54
.Lmain_53:
	li t0, 1
	sw t0, -16(s0)
.Lmain_54:
	call getint
	sw a0, -132(s0)
.Lmain_55:
	lw t0, -132(s0)
	sw t0, -16(s0)
.Lmain_56:
	lw t0, -16(s0)
	li t1, 100
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -136(s0)
.Lmain_57:
	lw t0, -136(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -140(s0)
.Lmain_58:
	lw t0, -140(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -144(s0)
.Lmain_59:
	li t0, 1
	sw t0, -148(s0)
.Lmain_60:
	lw t0, -144(s0)
	seqz t2, t0
	sw t2, -152(s0)
.Lmain_61:
	lw t0, -152(s0)
	bne t0, x0, .Lmain_63
.Lmain_62:
	j .Lmain_68
.Lmain_63:
	lw a0, -16(s0)
	call func
	sw a0, -156(s0)
.Lmain_64:
	lw t0, -156(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -160(s0)
.Lmain_65:
	lw t0, -160(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -164(s0)
.Lmain_66:
	lw t0, -164(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -168(s0)
.Lmain_67:
	lw t0, -168(s0)
	sw t0, -148(s0)
.Lmain_68:
	lw t0, -148(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -172(s0)
.Lmain_69:
	lw t0, -172(s0)
	bne t0, x0, .Lmain_72
.Lmain_70:
	li t0, 0
	sw t0, -16(s0)
.Lmain_71:
	j .Lmain_73
.Lmain_72:
	li t0, 1
	sw t0, -16(s0)
.Lmain_73:
	li a0, 99
	call func
	sw a0, -176(s0)
.Lmain_74:
	lw t0, -176(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -180(s0)
.Lmain_75:
	lw t0, -180(s0)
	seqz t2, t0
	sw t2, -184(s0)
.Lmain_76:
	lw t0, -184(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -188(s0)
.Lmain_77:
	li t0, 0
	sw t0, -192(s0)
.Lmain_78:
	lw t0, -188(s0)
	bne t0, x0, .Lmain_80
.Lmain_79:
	j .Lmain_84
.Lmain_80:
	li a0, 100
	call func
	sw a0, -196(s0)
.Lmain_81:
	lw t0, -196(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -200(s0)
.Lmain_82:
	lw t0, -200(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -204(s0)
.Lmain_83:
	lw t0, -204(s0)
	sw t0, -192(s0)
.Lmain_84:
	lw t0, -192(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -208(s0)
.Lmain_85:
	lw t0, -208(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -212(s0)
.Lmain_86:
	lw t0, -212(s0)
	bne t0, x0, .Lmain_89
.Lmain_87:
	li t0, 0
	sw t0, -16(s0)
.Lmain_88:
	j .Lmain_90
.Lmain_89:
	li t0, 1
	sw t0, -16(s0)
.Lmain_90:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 220(sp)
	lw s0, 216(sp)
	addi sp, sp, 224
	jr ra
.globl __global_init
__global_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.L__global_init_0:
	li t0, 0
	sw t0, g
.L__global_init_1:
	j .L__global_init_epilogue
.L__global_init_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
