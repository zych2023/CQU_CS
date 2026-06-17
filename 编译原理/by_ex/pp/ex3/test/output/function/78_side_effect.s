.data
.globl a
a:
	.word 0
.globl b
b:
	.word 0
.text
.globl inc_a
inc_a:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Linc_a_0:
	lw t0, a
	sw t0, -12(s0)
.Linc_a_1:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -16(s0)
.Linc_a_2:
	lw t0, -16(s0)
	sw t0, -12(s0)
.Linc_a_3:
	lw t0, -12(s0)
	sw t0, a
.Linc_a_4:
	lw a0, a
	j .Linc_a_epilogue
.Linc_a_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl main
main:
	addi sp, sp, -160
	sw ra, 156(sp)
	sw s0, 152(sp)
	addi s0, sp, 160
.Lmain_0:
	call __global_init
.Lmain_1:
	li t0, 5
	sw t0, -12(s0)
.Lmain_2:
	lw t0, -12(s0)
	li t1, 0
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -16(s0)
.Lmain_3:
	lw t0, -16(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -20(s0)
.Lmain_4:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lmain_5:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lmain_6:
	lw t0, -28(s0)
	bne t0, x0, .Lmain_8
.Lmain_7:
	j .Lmain_66
.Lmain_8:
	call inc_a
	sw a0, -32(s0)
.Lmain_9:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lmain_10:
	li t0, 0
	sw t0, -40(s0)
.Lmain_11:
	lw t0, -36(s0)
	bne t0, x0, .Lmain_13
.Lmain_12:
	j .Lmain_24
.Lmain_13:
	call inc_a
	sw a0, -44(s0)
.Lmain_14:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lmain_15:
	li t0, 0
	sw t0, -52(s0)
.Lmain_16:
	lw t0, -48(s0)
	bne t0, x0, .Lmain_18
.Lmain_17:
	j .Lmain_22
.Lmain_18:
	call inc_a
	sw a0, -56(s0)
.Lmain_19:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lmain_20:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lmain_21:
	lw t0, -64(s0)
	sw t0, -52(s0)
.Lmain_22:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_23:
	lw t0, -68(s0)
	sw t0, -40(s0)
.Lmain_24:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.Lmain_25:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.Lmain_26:
	lw t0, -76(s0)
	bne t0, x0, .Lmain_28
.Lmain_27:
	j .Lmain_32
.Lmain_28:
	lw a0, a
	call putint
.Lmain_29:
	li a0, 32
	call putch
.Lmain_30:
	lw a0, b
	call putint
.Lmain_31:
	li a0, 10
	call putch
.Lmain_32:
	call inc_a
	sw a0, -80(s0)
.Lmain_33:
	lw t0, -80(s0)
	li t1, 14
	slt t2, t0, t1
	sw t2, -84(s0)
.Lmain_34:
	lw t0, -84(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -88(s0)
.Lmain_35:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -92(s0)
.Lmain_36:
	li t0, 1
	sw t0, -96(s0)
.Lmain_37:
	lw t0, -92(s0)
	seqz t2, t0
	sw t2, -100(s0)
.Lmain_38:
	lw t0, -100(s0)
	bne t0, x0, .Lmain_40
.Lmain_39:
	j .Lmain_55
.Lmain_40:
	call inc_a
	sw a0, -104(s0)
.Lmain_41:
	lw t0, -104(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -108(s0)
.Lmain_42:
	li t0, 0
	sw t0, -112(s0)
.Lmain_43:
	lw t0, -108(s0)
	bne t0, x0, .Lmain_45
.Lmain_44:
	j .Lmain_52
.Lmain_45:
	call inc_a
	sw a0, -116(s0)
.Lmain_46:
	call inc_a
	sw a0, -120(s0)
.Lmain_47:
	lw t0, -116(s0)
	lw t1, -120(s0)
	sub t2, t0, t1
	sw t2, -124(s0)
.Lmain_48:
	lw t0, -124(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -128(s0)
.Lmain_49:
	lw t0, -128(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -132(s0)
.Lmain_50:
	lw t0, -132(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -136(s0)
.Lmain_51:
	lw t0, -136(s0)
	sw t0, -112(s0)
.Lmain_52:
	lw t0, -112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -140(s0)
.Lmain_53:
	lw t0, -140(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -144(s0)
.Lmain_54:
	lw t0, -144(s0)
	sw t0, -96(s0)
.Lmain_55:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -148(s0)
.Lmain_56:
	lw t0, -148(s0)
	bne t0, x0, .Lmain_59
.Lmain_57:
	call inc_a
	sw a0, -152(s0)
.Lmain_58:
	j .Lmain_63
.Lmain_59:
	lw a0, a
	call putint
.Lmain_60:
	li a0, 10
	call putch
.Lmain_61:
	lw t0, b
	li t1, 2
	mul t2, t0, t1
	sw t2, -156(s0)
.Lmain_62:
	lw t0, -156(s0)
	sw t0, b
.Lmain_63:
	lw t0, -12(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -160(s0)
.Lmain_64:
	lw t0, -160(s0)
	sw t0, -12(s0)
.Lmain_65:
	j .Lmain_2
.Lmain_66:
	lw a0, a
	call putint
.Lmain_67:
	li a0, 32
	call putch
.Lmain_68:
	lw a0, b
	call putint
.Lmain_69:
	li a0, 10
	call putch
.Lmain_70:
	lw a0, a
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 156(sp)
	lw s0, 152(sp)
	addi sp, sp, 160
	jr ra
.globl __global_init
__global_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.L__global_init_0:
	li t0, 0
	li t1, 1
	sub t2, t0, t1
	sw t2, -12(s0)
.L__global_init_1:
	lw t0, -12(s0)
	sw t0, a
.L__global_init_2:
	li t0, 1
	sw t0, b
.L__global_init_3:
	j .L__global_init_epilogue
.L__global_init_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
