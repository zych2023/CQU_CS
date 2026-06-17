.data
.globl n
n:
	.word 0
.text
.globl bubblesort
bubblesort:
	addi sp, sp, -144
	sw ra, 140(sp)
	sw s0, 136(sp)
	addi s0, sp, 144
	sw a0, -12(s0)
.Lbubblesort_0:
	li t0, 0
	sw t0, -16(s0)
.Lbubblesort_1:
	lw t0, n
	li t1, 1
	sub t2, t0, t1
	sw t2, -20(s0)
.Lbubblesort_2:
	lw t0, -16(s0)
	lw t1, -20(s0)
	slt t2, t0, t1
	sw t2, -24(s0)
.Lbubblesort_3:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lbubblesort_4:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lbubblesort_5:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lbubblesort_6:
	lw t0, -36(s0)
	bne t0, x0, .Lbubblesort_8
.Lbubblesort_7:
	j .Lbubblesort_45
.Lbubblesort_8:
	li t0, 0
	sw t0, -40(s0)
.Lbubblesort_9:
	lw t0, n
	lw t1, -16(s0)
	sub t2, t0, t1
	sw t2, -44(s0)
.Lbubblesort_10:
	lw t0, -44(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -48(s0)
.Lbubblesort_11:
	lw t0, -40(s0)
	lw t1, -48(s0)
	slt t2, t0, t1
	sw t2, -52(s0)
.Lbubblesort_12:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.Lbubblesort_13:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lbubblesort_14:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lbubblesort_15:
	lw t0, -64(s0)
	bne t0, x0, .Lbubblesort_17
.Lbubblesort_16:
	j .Lbubblesort_42
.Lbubblesort_17:
	li t0, 0
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -68(s0)
.Lbubblesort_18:
	lw t0, -12(s0)
	lw t1, -68(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -72(s0)
.Lbubblesort_19:
	lw t0, -40(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -76(s0)
.Lbubblesort_20:
	li t0, 0
	lw t1, -76(s0)
	add t2, t0, t1
	sw t2, -80(s0)
.Lbubblesort_21:
	lw t0, -12(s0)
	lw t1, -80(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -84(s0)
.Lbubblesort_22:
	lw t0, -72(s0)
	lw t1, -84(s0)
	slt t2, t1, t0
	sw t2, -88(s0)
.Lbubblesort_23:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -92(s0)
.Lbubblesort_24:
	lw t0, -92(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -96(s0)
.Lbubblesort_25:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lbubblesort_26:
	lw t0, -100(s0)
	bne t0, x0, .Lbubblesort_28
.Lbubblesort_27:
	j .Lbubblesort_39
.Lbubblesort_28:
	lw t0, -40(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -104(s0)
.Lbubblesort_29:
	li t0, 0
	lw t1, -104(s0)
	add t2, t0, t1
	sw t2, -108(s0)
.Lbubblesort_30:
	lw t0, -12(s0)
	lw t1, -108(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -112(s0)
.Lbubblesort_31:
	lw t0, -112(s0)
	sw t0, -116(s0)
.Lbubblesort_32:
	lw t0, -40(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -120(s0)
.Lbubblesort_33:
	li t0, 0
	lw t1, -120(s0)
	add t2, t0, t1
	sw t2, -124(s0)
.Lbubblesort_34:
	li t0, 0
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -128(s0)
.Lbubblesort_35:
	lw t0, -12(s0)
	lw t1, -128(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -132(s0)
.Lbubblesort_36:
	lw t0, -12(s0)
	lw t1, -124(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -132(s0)
	sw t2, 0(t0)
.Lbubblesort_37:
	li t0, 0
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -136(s0)
.Lbubblesort_38:
	lw t0, -12(s0)
	lw t1, -136(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -116(s0)
	sw t2, 0(t0)
.Lbubblesort_39:
	lw t0, -40(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -140(s0)
.Lbubblesort_40:
	lw t0, -140(s0)
	sw t0, -40(s0)
.Lbubblesort_41:
	j .Lbubblesort_9
.Lbubblesort_42:
	lw t0, -16(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -144(s0)
.Lbubblesort_43:
	lw t0, -144(s0)
	sw t0, -16(s0)
.Lbubblesort_44:
	j .Lbubblesort_1
.Lbubblesort_45:
	li a0, 0
	j .Lbubblesort_epilogue
.Lbubblesort_epilogue:
	lw ra, 140(sp)
	lw s0, 136(sp)
	addi sp, sp, 144
	jr ra
.globl main
main:
	addi sp, sp, -144
	sw ra, 140(sp)
	sw s0, 136(sp)
	addi s0, sp, 144
.Lmain_0:
	li t0, 10
	sw t0, n
.Lmain_1:
	addi t0, s0, -52
	sw t0, -12(s0)
.Lmain_2:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -56(s0)
.Lmain_3:
	lw t0, -12(s0)
	lw t1, -56(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 4
	sw t2, 0(t0)
.Lmain_4:
	li t0, 0
	li t1, 1
	add t2, t0, t1
	sw t2, -60(s0)
.Lmain_5:
	lw t0, -12(s0)
	lw t1, -60(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 3
	sw t2, 0(t0)
.Lmain_6:
	li t0, 0
	li t1, 2
	add t2, t0, t1
	sw t2, -64(s0)
.Lmain_7:
	lw t0, -12(s0)
	lw t1, -64(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 9
	sw t2, 0(t0)
.Lmain_8:
	li t0, 0
	li t1, 3
	add t2, t0, t1
	sw t2, -68(s0)
.Lmain_9:
	lw t0, -12(s0)
	lw t1, -68(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 2
	sw t2, 0(t0)
.Lmain_10:
	li t0, 0
	li t1, 4
	add t2, t0, t1
	sw t2, -72(s0)
.Lmain_11:
	lw t0, -12(s0)
	lw t1, -72(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lmain_12:
	li t0, 0
	li t1, 5
	add t2, t0, t1
	sw t2, -76(s0)
.Lmain_13:
	lw t0, -12(s0)
	lw t1, -76(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.Lmain_14:
	li t0, 0
	li t1, 6
	add t2, t0, t1
	sw t2, -80(s0)
.Lmain_15:
	lw t0, -12(s0)
	lw t1, -80(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 6
	sw t2, 0(t0)
.Lmain_16:
	li t0, 0
	li t1, 7
	add t2, t0, t1
	sw t2, -84(s0)
.Lmain_17:
	lw t0, -12(s0)
	lw t1, -84(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 5
	sw t2, 0(t0)
.Lmain_18:
	li t0, 0
	li t1, 8
	add t2, t0, t1
	sw t2, -88(s0)
.Lmain_19:
	lw t0, -12(s0)
	lw t1, -88(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 7
	sw t2, 0(t0)
.Lmain_20:
	li t0, 0
	li t1, 9
	add t2, t0, t1
	sw t2, -92(s0)
.Lmain_21:
	lw t0, -12(s0)
	lw t1, -92(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 8
	sw t2, 0(t0)
.Lmain_22:
	lw t0, -12(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	sw t0, -96(s0)
.Lmain_23:
	lw a0, -96(s0)
	call bubblesort
	sw a0, -100(s0)
.Lmain_24:
	lw t0, -100(s0)
	sw t0, -104(s0)
.Lmain_25:
	lw t0, -104(s0)
	lw t1, n
	slt t2, t0, t1
	sw t2, -108(s0)
.Lmain_26:
	lw t0, -108(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.Lmain_27:
	lw t0, -112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -116(s0)
.Lmain_28:
	lw t0, -116(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -120(s0)
.Lmain_29:
	lw t0, -120(s0)
	bne t0, x0, .Lmain_31
.Lmain_30:
	j .Lmain_40
.Lmain_31:
	li t0, 0
	lw t1, -104(s0)
	add t2, t0, t1
	sw t2, -124(s0)
.Lmain_32:
	lw t0, -12(s0)
	lw t1, -124(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -128(s0)
.Lmain_33:
	lw t0, -128(s0)
	sw t0, -132(s0)
.Lmain_34:
	lw a0, -132(s0)
	call putint
.Lmain_35:
	li t0, 10
	sw t0, -132(s0)
.Lmain_36:
	lw a0, -132(s0)
	call putch
.Lmain_37:
	lw t0, -104(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -136(s0)
.Lmain_38:
	lw t0, -136(s0)
	sw t0, -104(s0)
.Lmain_39:
	j .Lmain_25
.Lmain_40:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 140(sp)
	lw s0, 136(sp)
	addi sp, sp, 144
	jr ra
