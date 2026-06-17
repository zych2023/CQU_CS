.text
.globl main
main:
	addi sp, sp, -192
	sw ra, 188(sp)
	sw s0, 184(sp)
	addi s0, sp, 192
.Lmain_0:
	li t0, 2
	sw t0, -12(s0)
.Lmain_1:
	addi t0, s0, -96
	sw t0, -16(s0)
.Lmain_2:
	lw t0, -16(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.Lmain_3:
	lw t0, -16(s0)
	li t1, 1
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 2
	sw t2, 0(t0)
.Lmain_4:
	lw t0, -16(s0)
	li t1, 2
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_5:
	lw t0, -16(s0)
	li t1, 3
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_6:
	lw t0, -16(s0)
	li t1, 4
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_7:
	lw t0, -16(s0)
	li t1, 5
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_8:
	lw t0, -16(s0)
	li t1, 6
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_9:
	lw t0, -16(s0)
	li t1, 7
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_10:
	lw t0, -16(s0)
	li t1, 8
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_11:
	lw t0, -16(s0)
	li t1, 9
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_12:
	lw t0, -16(s0)
	li t1, 10
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_13:
	lw t0, -16(s0)
	li t1, 11
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_14:
	lw t0, -16(s0)
	li t1, 12
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_15:
	lw t0, -16(s0)
	li t1, 13
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_16:
	lw t0, -16(s0)
	li t1, 14
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_17:
	lw t0, -16(s0)
	li t1, 15
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_18:
	lw t0, -16(s0)
	li t1, 16
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_19:
	lw t0, -16(s0)
	li t1, 17
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_20:
	lw t0, -16(s0)
	li t1, 18
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_21:
	lw t0, -16(s0)
	li t1, 19
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_22:
	li t0, 0
	sw t0, -100(s0)
.Lmain_23:
	lw t0, -12(s0)
	li t1, 20
	slt t2, t0, t1
	sw t2, -104(s0)
.Lmain_24:
	lw t0, -104(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -108(s0)
.Lmain_25:
	lw t0, -108(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.Lmain_26:
	lw t0, -112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -116(s0)
.Lmain_27:
	lw t0, -116(s0)
	bne t0, x0, .Lmain_29
.Lmain_28:
	j .Lmain_52
.Lmain_29:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -120(s0)
.Lmain_30:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -124(s0)
.Lmain_31:
	lw t0, -16(s0)
	lw t1, -124(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -128(s0)
.Lmain_32:
	lw t0, -12(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -132(s0)
.Lmain_33:
	li t0, 0
	lw t1, -132(s0)
	add t2, t0, t1
	sw t2, -136(s0)
.Lmain_34:
	lw t0, -16(s0)
	lw t1, -136(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -140(s0)
.Lmain_35:
	lw t0, -128(s0)
	lw t1, -140(s0)
	add t2, t0, t1
	sw t2, -144(s0)
.Lmain_36:
	lw t0, -12(s0)
	li t1, 2
	sub t2, t0, t1
	sw t2, -148(s0)
.Lmain_37:
	li t0, 0
	lw t1, -148(s0)
	add t2, t0, t1
	sw t2, -152(s0)
.Lmain_38:
	lw t0, -16(s0)
	lw t1, -152(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -156(s0)
.Lmain_39:
	lw t0, -144(s0)
	lw t1, -156(s0)
	add t2, t0, t1
	sw t2, -160(s0)
.Lmain_40:
	lw t0, -16(s0)
	lw t1, -120(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -160(s0)
	sw t2, 0(t0)
.Lmain_41:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -164(s0)
.Lmain_42:
	lw t0, -16(s0)
	lw t1, -164(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -168(s0)
.Lmain_43:
	lw t0, -100(s0)
	lw t1, -168(s0)
	add t2, t0, t1
	sw t2, -172(s0)
.Lmain_44:
	lw t0, -172(s0)
	sw t0, -100(s0)
.Lmain_45:
	li t0, 0
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -176(s0)
.Lmain_46:
	lw t0, -16(s0)
	lw t1, -176(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -180(s0)
.Lmain_47:
	lw a0, -180(s0)
	call putint
.Lmain_48:
	li a0, 10
	call putch
.Lmain_49:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -184(s0)
.Lmain_50:
	lw t0, -184(s0)
	sw t0, -12(s0)
.Lmain_51:
	j .Lmain_23
.Lmain_52:
	lw a0, -100(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 188(sp)
	lw s0, 184(sp)
	addi sp, sp, 192
	jr ra
