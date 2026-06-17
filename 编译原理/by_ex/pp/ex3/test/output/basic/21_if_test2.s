.text
.globl ifElseIf
ifElseIf:
	addi sp, sp, -144
	sw ra, 140(sp)
	sw s0, 136(sp)
	addi s0, sp, 144
.LifElseIf_0:
	li t0, 5
	sw t0, -12(s0)
.LifElseIf_1:
	li t0, 10
	sw t0, -16(s0)
.LifElseIf_2:
	lw t0, -12(s0)
	li t1, 6
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -20(s0)
.LifElseIf_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.LifElseIf_4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.LifElseIf_5:
	li t0, 1
	sw t0, -32(s0)
.LifElseIf_6:
	lw t0, -28(s0)
	seqz t2, t0
	sw t2, -36(s0)
.LifElseIf_7:
	lw t0, -36(s0)
	bne t0, x0, .LifElseIf_9
.LifElseIf_8:
	j .LifElseIf_14
.LifElseIf_9:
	lw t0, -16(s0)
	li t1, 11
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -40(s0)
.LifElseIf_10:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.LifElseIf_11:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.LifElseIf_12:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.LifElseIf_13:
	lw t0, -52(s0)
	sw t0, -32(s0)
.LifElseIf_14:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.LifElseIf_15:
	lw t0, -56(s0)
	bne t0, x0, .LifElseIf_49
.LifElseIf_16:
	lw t0, -16(s0)
	li t1, 10
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -60(s0)
.LifElseIf_17:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.LifElseIf_18:
	li t0, 0
	sw t0, -68(s0)
.LifElseIf_19:
	lw t0, -64(s0)
	bne t0, x0, .LifElseIf_21
.LifElseIf_20:
	j .LifElseIf_25
.LifElseIf_21:
	lw t0, -12(s0)
	li t1, 1
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -72(s0)
.LifElseIf_22:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.LifElseIf_23:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.LifElseIf_24:
	lw t0, -80(s0)
	sw t0, -68(s0)
.LifElseIf_25:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -84(s0)
.LifElseIf_26:
	lw t0, -84(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -88(s0)
.LifElseIf_27:
	lw t0, -88(s0)
	bne t0, x0, .LifElseIf_47
.LifElseIf_28:
	lw t0, -16(s0)
	li t1, 10
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -92(s0)
.LifElseIf_29:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.LifElseIf_30:
	li t0, 0
	sw t0, -100(s0)
.LifElseIf_31:
	lw t0, -96(s0)
	bne t0, x0, .LifElseIf_33
.LifElseIf_32:
	j .LifElseIf_38
.LifElseIf_33:
	li t0, 0
	li t1, 5
	sub t2, t0, t1
	sw t2, -104(s0)
.LifElseIf_34:
	lw t0, -12(s0)
	lw t1, -104(s0)
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -108(s0)
.LifElseIf_35:
	lw t0, -108(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.LifElseIf_36:
	lw t0, -112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -116(s0)
.LifElseIf_37:
	lw t0, -116(s0)
	sw t0, -100(s0)
.LifElseIf_38:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -120(s0)
.LifElseIf_39:
	lw t0, -120(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -124(s0)
.LifElseIf_40:
	lw t0, -124(s0)
	bne t0, x0, .LifElseIf_44
.LifElseIf_41:
	li t0, 0
	lw t1, -12(s0)
	sub t2, t0, t1
	sw t2, -128(s0)
.LifElseIf_42:
	lw t0, -128(s0)
	sw t0, -12(s0)
.LifElseIf_43:
	j .LifElseIf_46
.LifElseIf_44:
	lw t0, -12(s0)
	li t1, 15
	add t2, t0, t1
	sw t2, -132(s0)
.LifElseIf_45:
	lw t0, -132(s0)
	sw t0, -12(s0)
.LifElseIf_46:
	j .LifElseIf_48
.LifElseIf_47:
	li t0, 25
	sw t0, -12(s0)
.LifElseIf_48:
	j .LifElseIf_50
.LifElseIf_49:
	lw a0, -12(s0)
	j .LifElseIf_epilogue
.LifElseIf_50:
	lw a0, -12(s0)
	j .LifElseIf_epilogue
.LifElseIf_epilogue:
	lw ra, 140(sp)
	lw s0, 136(sp)
	addi sp, sp, 144
	jr ra
.globl main
main:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lmain_0:
	call ifElseIf
	sw a0, -12(s0)
.Lmain_1:
	lw a0, -12(s0)
	call putint
.Lmain_2:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
