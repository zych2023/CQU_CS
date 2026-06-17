.text
.globl main
main:
	addi sp, sp, -160
	sw ra, 156(sp)
	sw s0, 152(sp)
	addi s0, sp, 160
.Lmain_0:
	addi t0, s0, -44
	sw t0, -12(s0)
.Lmain_1:
	lw t0, -12(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_2:
	lw t0, -12(s0)
	li t1, 1
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_3:
	lw t0, -12(s0)
	li t1, 2
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_4:
	lw t0, -12(s0)
	li t1, 3
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_5:
	lw t0, -12(s0)
	li t1, 4
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_6:
	lw t0, -12(s0)
	li t1, 5
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_7:
	lw t0, -12(s0)
	li t1, 6
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_8:
	lw t0, -12(s0)
	li t1, 7
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_9:
	addi t0, s0, -80
	sw t0, -48(s0)
.Lmain_10:
	lw t0, -48(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.Lmain_11:
	lw t0, -48(s0)
	li t1, 1
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 2
	sw t2, 0(t0)
.Lmain_12:
	lw t0, -48(s0)
	li t1, 2
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 3
	sw t2, 0(t0)
.Lmain_13:
	lw t0, -48(s0)
	li t1, 3
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 4
	sw t2, 0(t0)
.Lmain_14:
	lw t0, -48(s0)
	li t1, 4
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 5
	sw t2, 0(t0)
.Lmain_15:
	lw t0, -48(s0)
	li t1, 5
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 6
	sw t2, 0(t0)
.Lmain_16:
	lw t0, -48(s0)
	li t1, 6
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 7
	sw t2, 0(t0)
.Lmain_17:
	lw t0, -48(s0)
	li t1, 7
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 8
	sw t2, 0(t0)
.Lmain_18:
	li t0, 3
	li t1, 2
	mul t2, t0, t1
	sw t2, -84(s0)
.Lmain_19:
	li t0, 0
	lw t1, -84(s0)
	add t2, t0, t1
	sw t2, -88(s0)
.Lmain_20:
	lw t0, -88(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -92(s0)
.Lmain_21:
	lw t0, -48(s0)
	lw t1, -92(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -96(s0)
.Lmain_22:
	li t0, 0
	li t1, 2
	mul t2, t0, t1
	sw t2, -100(s0)
.Lmain_23:
	li t0, 0
	lw t1, -100(s0)
	add t2, t0, t1
	sw t2, -104(s0)
.Lmain_24:
	lw t0, -104(s0)
	li t1, 0
	add t2, t0, t1
	sw t2, -108(s0)
.Lmain_25:
	lw t0, -48(s0)
	lw t1, -108(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -112(s0)
.Lmain_26:
	lw t0, -96(s0)
	lw t1, -112(s0)
	add t2, t0, t1
	sw t2, -116(s0)
.Lmain_27:
	li t0, 0
	li t1, 2
	mul t2, t0, t1
	sw t2, -120(s0)
.Lmain_28:
	li t0, 0
	lw t1, -120(s0)
	add t2, t0, t1
	sw t2, -124(s0)
.Lmain_29:
	lw t0, -124(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -128(s0)
.Lmain_30:
	lw t0, -48(s0)
	lw t1, -128(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -132(s0)
.Lmain_31:
	lw t0, -116(s0)
	lw t1, -132(s0)
	add t2, t0, t1
	sw t2, -136(s0)
.Lmain_32:
	li t0, 2
	li t1, 2
	mul t2, t0, t1
	sw t2, -140(s0)
.Lmain_33:
	li t0, 0
	lw t1, -140(s0)
	add t2, t0, t1
	sw t2, -144(s0)
.Lmain_34:
	lw t0, -144(s0)
	li t1, 0
	add t2, t0, t1
	sw t2, -148(s0)
.Lmain_35:
	lw t0, -48(s0)
	lw t1, -148(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -152(s0)
.Lmain_36:
	lw t0, -136(s0)
	lw t1, -152(s0)
	add t2, t0, t1
	sw t2, -156(s0)
.Lmain_37:
	lw a0, -156(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 156(sp)
	lw s0, 152(sp)
	addi sp, sp, 160
	jr ra
