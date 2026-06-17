.text
.globl my_getint
my_getint:
	addi sp, sp, -112
	sw ra, 108(sp)
	sw s0, 104(sp)
	addi s0, sp, 112
.Lmy_getint_0:
	li t0, 0
	sw t0, -12(s0)
.Lmy_getint_1:
	li t0, 1
	bne t0, x0, .Lmy_getint_3
.Lmy_getint_2:
	j .Lmy_getint_24
.Lmy_getint_3:
	call getch
	sw a0, -16(s0)
.Lmy_getint_4:
	lw t0, -16(s0)
	li t1, 48
	sub t2, t0, t1
	sw t2, -20(s0)
.Lmy_getint_5:
	lw t0, -20(s0)
	sw t0, -24(s0)
.Lmy_getint_6:
	lw t0, -24(s0)
	li t1, 0
	slt t2, t0, t1
	sw t2, -28(s0)
.Lmy_getint_7:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmy_getint_8:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lmy_getint_9:
	li t0, 1
	sw t0, -40(s0)
.Lmy_getint_10:
	lw t0, -36(s0)
	seqz t2, t0
	sw t2, -44(s0)
.Lmy_getint_11:
	lw t0, -44(s0)
	bne t0, x0, .Lmy_getint_13
.Lmy_getint_12:
	j .Lmy_getint_18
.Lmy_getint_13:
	lw t0, -24(s0)
	li t1, 9
	slt t2, t1, t0
	sw t2, -48(s0)
.Lmy_getint_14:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.Lmy_getint_15:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.Lmy_getint_16:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lmy_getint_17:
	lw t0, -60(s0)
	sw t0, -40(s0)
.Lmy_getint_18:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lmy_getint_19:
	lw t0, -64(s0)
	bne t0, x0, .Lmy_getint_22
.Lmy_getint_20:
	j .Lmy_getint_24
.Lmy_getint_21:
	j .Lmy_getint_23
.Lmy_getint_22:
	j .Lmy_getint_1
.Lmy_getint_23:
	j .Lmy_getint_1
.Lmy_getint_24:
	lw t0, -24(s0)
	sw t0, -12(s0)
.Lmy_getint_25:
	li t0, 1
	bne t0, x0, .Lmy_getint_27
.Lmy_getint_26:
	j .Lmy_getint_48
.Lmy_getint_27:
	call getch
	sw a0, -68(s0)
.Lmy_getint_28:
	lw t0, -68(s0)
	li t1, 48
	sub t2, t0, t1
	sw t2, -72(s0)
.Lmy_getint_29:
	lw t0, -72(s0)
	sw t0, -24(s0)
.Lmy_getint_30:
	lw t0, -24(s0)
	li t1, 0
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -76(s0)
.Lmy_getint_31:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.Lmy_getint_32:
	li t0, 0
	sw t0, -84(s0)
.Lmy_getint_33:
	lw t0, -80(s0)
	bne t0, x0, .Lmy_getint_35
.Lmy_getint_34:
	j .Lmy_getint_39
.Lmy_getint_35:
	lw t0, -24(s0)
	li t1, 9
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -88(s0)
.Lmy_getint_36:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -92(s0)
.Lmy_getint_37:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.Lmy_getint_38:
	lw t0, -96(s0)
	sw t0, -84(s0)
.Lmy_getint_39:
	lw t0, -84(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lmy_getint_40:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.Lmy_getint_41:
	lw t0, -104(s0)
	bne t0, x0, .Lmy_getint_44
.Lmy_getint_42:
	j .Lmy_getint_48
.Lmy_getint_43:
	j .Lmy_getint_47
.Lmy_getint_44:
	lw t0, -12(s0)
	li t1, 10
	mul t2, t0, t1
	sw t2, -108(s0)
.Lmy_getint_45:
	lw t0, -108(s0)
	lw t1, -24(s0)
	add t2, t0, t1
	sw t2, -112(s0)
.Lmy_getint_46:
	lw t0, -112(s0)
	sw t0, -12(s0)
.Lmy_getint_47:
	j .Lmy_getint_25
.Lmy_getint_48:
	lw a0, -12(s0)
	j .Lmy_getint_epilogue
.Lmy_getint_epilogue:
	lw ra, 108(sp)
	lw s0, 104(sp)
	addi sp, sp, 112
	jr ra
.globl my_putint
my_putint:
	addi sp, sp, -160
	sw ra, 156(sp)
	sw s0, 152(sp)
	addi s0, sp, 160
	sw a0, -12(s0)
.Lmy_putint_0:
	addi t0, s0, -80
	sw t0, -16(s0)
.Lmy_putint_1:
	li t0, 0
	sw t0, -84(s0)
.Lmy_putint_2:
	lw t0, -12(s0)
	li t1, 0
	slt t2, t1, t0
	sw t2, -88(s0)
.Lmy_putint_3:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -92(s0)
.Lmy_putint_4:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.Lmy_putint_5:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lmy_putint_6:
	lw t0, -100(s0)
	bne t0, x0, .Lmy_putint_8
.Lmy_putint_7:
	j .Lmy_putint_17
.Lmy_putint_8:
	li t0, 0
	lw t1, -84(s0)
	add t2, t0, t1
	sw t2, -104(s0)
.Lmy_putint_9:
	lw t0, -12(s0)
	li t1, 10
	rem t2, t0, t1
	sw t2, -108(s0)
.Lmy_putint_10:
	lw t0, -108(s0)
	li t1, 48
	add t2, t0, t1
	sw t2, -112(s0)
.Lmy_putint_11:
	lw t0, -16(s0)
	lw t1, -104(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -112(s0)
	sw t2, 0(t0)
.Lmy_putint_12:
	lw t0, -12(s0)
	li t1, 10
	div t2, t0, t1
	sw t2, -116(s0)
.Lmy_putint_13:
	lw t0, -116(s0)
	sw t0, -12(s0)
.Lmy_putint_14:
	lw t0, -84(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -120(s0)
.Lmy_putint_15:
	lw t0, -120(s0)
	sw t0, -84(s0)
.Lmy_putint_16:
	j .Lmy_putint_2
.Lmy_putint_17:
	lw t0, -84(s0)
	li t1, 0
	slt t2, t1, t0
	sw t2, -124(s0)
.Lmy_putint_18:
	lw t0, -124(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -128(s0)
.Lmy_putint_19:
	lw t0, -128(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -132(s0)
.Lmy_putint_20:
	lw t0, -132(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -136(s0)
.Lmy_putint_21:
	lw t0, -136(s0)
	bne t0, x0, .Lmy_putint_23
.Lmy_putint_22:
	j .Lmy_putint_29
.Lmy_putint_23:
	lw t0, -84(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -140(s0)
.Lmy_putint_24:
	lw t0, -140(s0)
	sw t0, -84(s0)
.Lmy_putint_25:
	li t0, 0
	lw t1, -84(s0)
	add t2, t0, t1
	sw t2, -144(s0)
.Lmy_putint_26:
	lw t0, -16(s0)
	lw t1, -144(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -148(s0)
.Lmy_putint_27:
	lw a0, -148(s0)
	call putch
.Lmy_putint_28:
	j .Lmy_putint_17
.Lmy_putint_29:
	j .Lmy_putint_epilogue
.Lmy_putint_epilogue:
	lw ra, 156(sp)
	lw s0, 152(sp)
	addi sp, sp, 160
	jr ra
.globl main
main:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
.Lmain_0:
	call my_getint
	sw a0, -12(s0)
.Lmain_1:
	lw t0, -12(s0)
	sw t0, -16(s0)
.Lmain_2:
	lw t0, -16(s0)
	li t1, 0
	slt t2, t1, t0
	sw t2, -20(s0)
.Lmain_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lmain_4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lmain_5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmain_6:
	lw t0, -32(s0)
	bne t0, x0, .Lmain_8
.Lmain_7:
	j .Lmain_15
.Lmain_8:
	call my_getint
	sw a0, -36(s0)
.Lmain_9:
	lw t0, -36(s0)
	sw t0, -40(s0)
.Lmain_10:
	lw a0, -40(s0)
	call my_putint
.Lmain_11:
	li a0, 10
	call putch
.Lmain_12:
	lw t0, -16(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -44(s0)
.Lmain_13:
	lw t0, -44(s0)
	sw t0, -16(s0)
.Lmain_14:
	j .Lmain_2
.Lmain_15:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
