.data
.globl a0
a0:
	.word 0
.globl a1
a1:
	.word 0
.globl a2
a2:
	.word 0
.globl a3
a3:
	.word 0
.globl a4
a4:
	.word 0
.globl a5
a5:
	.word 0
.globl a6
a6:
	.word 0
.globl a7
a7:
	.word 0
.globl a8
a8:
	.word 0
.globl a9
a9:
	.word 0
.globl a10
a10:
	.word 0
.globl a11
a11:
	.word 0
.globl a12
a12:
	.word 0
.globl a13
a13:
	.word 0
.globl a14
a14:
	.word 0
.globl a15
a15:
	.word 0
.globl a16
a16:
	.word 0
.globl a17
a17:
	.word 0
.globl a18
a18:
	.word 0
.globl a19
a19:
	.word 0
.globl a20
a20:
	.word 0
.globl a21
a21:
	.word 0
.globl a22
a22:
	.word 0
.globl a23
a23:
	.word 0
.globl a24
a24:
	.word 0
.globl a25
a25:
	.word 0
.globl a26
a26:
	.word 0
.globl a27
a27:
	.word 0
.globl a28
a28:
	.word 0
.globl a29
a29:
	.word 0
.globl a30
a30:
	.word 0
.globl a31
a31:
	.word 0
.globl a32
a32:
	.word 0
.globl a33
a33:
	.word 0
.globl a34
a34:
	.word 0
.globl a35
a35:
	.word 0
.globl a36
a36:
	.word 0
.globl a37
a37:
	.word 0
.globl a38
a38:
	.word 0
.globl a39
a39:
	.word 0
.text
.globl testParam8
testParam8:
	addi sp, sp, -80
	sw ra, 76(sp)
	sw s0, 72(sp)
	addi s0, sp, 80
	sw a0, -12(s0)
	sw a1, -16(s0)
	sw a2, -20(s0)
	sw a3, -24(s0)
	sw a4, -28(s0)
	sw a5, -32(s0)
	sw a6, -36(s0)
	sw a7, -40(s0)
.LtestParam8_0:
	lw t0, -12(s0)
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -44(s0)
.LtestParam8_1:
	lw t0, -44(s0)
	lw t1, -20(s0)
	add t2, t0, t1
	sw t2, -48(s0)
.LtestParam8_2:
	lw t0, -48(s0)
	lw t1, -24(s0)
	add t2, t0, t1
	sw t2, -52(s0)
.LtestParam8_3:
	lw t0, -52(s0)
	lw t1, -28(s0)
	add t2, t0, t1
	sw t2, -56(s0)
.LtestParam8_4:
	lw t0, -56(s0)
	lw t1, -32(s0)
	add t2, t0, t1
	sw t2, -60(s0)
.LtestParam8_5:
	lw t0, -60(s0)
	lw t1, -36(s0)
	add t2, t0, t1
	sw t2, -64(s0)
.LtestParam8_6:
	lw t0, -64(s0)
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -68(s0)
.LtestParam8_7:
	lw a0, -68(s0)
	j .LtestParam8_epilogue
.LtestParam8_epilogue:
	lw ra, 76(sp)
	lw s0, 72(sp)
	addi sp, sp, 80
	jr ra
.globl testParam16
testParam16:
	addi sp, sp, -144
	sw ra, 140(sp)
	sw s0, 136(sp)
	addi s0, sp, 144
	sw a0, -12(s0)
	sw a1, -16(s0)
	sw a2, -20(s0)
	sw a3, -24(s0)
	sw a4, -28(s0)
	sw a5, -32(s0)
	sw a6, -36(s0)
	sw a7, -40(s0)
	lw t0, 0(s0)
	sw t0, -44(s0)
	lw t0, 4(s0)
	sw t0, -48(s0)
	lw t0, 8(s0)
	sw t0, -52(s0)
	lw t0, 12(s0)
	sw t0, -56(s0)
	lw t0, 16(s0)
	sw t0, -60(s0)
	lw t0, 20(s0)
	sw t0, -64(s0)
	lw t0, 24(s0)
	sw t0, -68(s0)
	lw t0, 28(s0)
	sw t0, -72(s0)
.LtestParam16_0:
	lw t0, -12(s0)
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -76(s0)
.LtestParam16_1:
	lw t0, -76(s0)
	lw t1, -20(s0)
	add t2, t0, t1
	sw t2, -80(s0)
.LtestParam16_2:
	lw t0, -80(s0)
	lw t1, -24(s0)
	sub t2, t0, t1
	sw t2, -84(s0)
.LtestParam16_3:
	lw t0, -84(s0)
	lw t1, -28(s0)
	sub t2, t0, t1
	sw t2, -88(s0)
.LtestParam16_4:
	lw t0, -88(s0)
	lw t1, -32(s0)
	sub t2, t0, t1
	sw t2, -92(s0)
.LtestParam16_5:
	lw t0, -92(s0)
	lw t1, -36(s0)
	sub t2, t0, t1
	sw t2, -96(s0)
.LtestParam16_6:
	lw t0, -96(s0)
	lw t1, -40(s0)
	sub t2, t0, t1
	sw t2, -100(s0)
.LtestParam16_7:
	lw t0, -100(s0)
	lw t1, -44(s0)
	add t2, t0, t1
	sw t2, -104(s0)
.LtestParam16_8:
	lw t0, -104(s0)
	lw t1, -48(s0)
	add t2, t0, t1
	sw t2, -108(s0)
.LtestParam16_9:
	lw t0, -108(s0)
	lw t1, -52(s0)
	add t2, t0, t1
	sw t2, -112(s0)
.LtestParam16_10:
	lw t0, -112(s0)
	lw t1, -56(s0)
	add t2, t0, t1
	sw t2, -116(s0)
.LtestParam16_11:
	lw t0, -116(s0)
	lw t1, -60(s0)
	add t2, t0, t1
	sw t2, -120(s0)
.LtestParam16_12:
	lw t0, -120(s0)
	lw t1, -64(s0)
	add t2, t0, t1
	sw t2, -124(s0)
.LtestParam16_13:
	lw t0, -124(s0)
	lw t1, -68(s0)
	add t2, t0, t1
	sw t2, -128(s0)
.LtestParam16_14:
	lw t0, -128(s0)
	lw t1, -72(s0)
	add t2, t0, t1
	sw t2, -132(s0)
.LtestParam16_15:
	lw a0, -132(s0)
	j .LtestParam16_epilogue
.LtestParam16_epilogue:
	lw ra, 140(sp)
	lw s0, 136(sp)
	addi sp, sp, 144
	jr ra
.globl testParam32
testParam32:
	addi sp, sp, -272
	sw ra, 268(sp)
	sw s0, 264(sp)
	addi s0, sp, 272
	sw a0, -12(s0)
	sw a1, -16(s0)
	sw a2, -20(s0)
	sw a3, -24(s0)
	sw a4, -28(s0)
	sw a5, -32(s0)
	sw a6, -36(s0)
	sw a7, -40(s0)
	lw t0, 0(s0)
	sw t0, -44(s0)
	lw t0, 4(s0)
	sw t0, -48(s0)
	lw t0, 8(s0)
	sw t0, -52(s0)
	lw t0, 12(s0)
	sw t0, -56(s0)
	lw t0, 16(s0)
	sw t0, -60(s0)
	lw t0, 20(s0)
	sw t0, -64(s0)
	lw t0, 24(s0)
	sw t0, -68(s0)
	lw t0, 28(s0)
	sw t0, -72(s0)
	lw t0, 32(s0)
	sw t0, -76(s0)
	lw t0, 36(s0)
	sw t0, -80(s0)
	lw t0, 40(s0)
	sw t0, -84(s0)
	lw t0, 44(s0)
	sw t0, -88(s0)
	lw t0, 48(s0)
	sw t0, -92(s0)
	lw t0, 52(s0)
	sw t0, -96(s0)
	lw t0, 56(s0)
	sw t0, -100(s0)
	lw t0, 60(s0)
	sw t0, -104(s0)
	lw t0, 64(s0)
	sw t0, -108(s0)
	lw t0, 68(s0)
	sw t0, -112(s0)
	lw t0, 72(s0)
	sw t0, -116(s0)
	lw t0, 76(s0)
	sw t0, -120(s0)
	lw t0, 80(s0)
	sw t0, -124(s0)
	lw t0, 84(s0)
	sw t0, -128(s0)
	lw t0, 88(s0)
	sw t0, -132(s0)
	lw t0, 92(s0)
	sw t0, -136(s0)
.LtestParam32_0:
	lw t0, -12(s0)
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -140(s0)
.LtestParam32_1:
	lw t0, -140(s0)
	lw t1, -20(s0)
	add t2, t0, t1
	sw t2, -144(s0)
.LtestParam32_2:
	lw t0, -144(s0)
	lw t1, -24(s0)
	add t2, t0, t1
	sw t2, -148(s0)
.LtestParam32_3:
	lw t0, -148(s0)
	lw t1, -28(s0)
	add t2, t0, t1
	sw t2, -152(s0)
.LtestParam32_4:
	lw t0, -152(s0)
	lw t1, -32(s0)
	add t2, t0, t1
	sw t2, -156(s0)
.LtestParam32_5:
	lw t0, -156(s0)
	lw t1, -36(s0)
	add t2, t0, t1
	sw t2, -160(s0)
.LtestParam32_6:
	lw t0, -160(s0)
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -164(s0)
.LtestParam32_7:
	lw t0, -164(s0)
	lw t1, -44(s0)
	add t2, t0, t1
	sw t2, -168(s0)
.LtestParam32_8:
	lw t0, -168(s0)
	lw t1, -48(s0)
	add t2, t0, t1
	sw t2, -172(s0)
.LtestParam32_9:
	lw t0, -172(s0)
	lw t1, -52(s0)
	add t2, t0, t1
	sw t2, -176(s0)
.LtestParam32_10:
	lw t0, -176(s0)
	lw t1, -56(s0)
	add t2, t0, t1
	sw t2, -180(s0)
.LtestParam32_11:
	lw t0, -180(s0)
	lw t1, -60(s0)
	add t2, t0, t1
	sw t2, -184(s0)
.LtestParam32_12:
	lw t0, -184(s0)
	lw t1, -64(s0)
	add t2, t0, t1
	sw t2, -188(s0)
.LtestParam32_13:
	lw t0, -188(s0)
	lw t1, -68(s0)
	add t2, t0, t1
	sw t2, -192(s0)
.LtestParam32_14:
	lw t0, -192(s0)
	lw t1, -72(s0)
	add t2, t0, t1
	sw t2, -196(s0)
.LtestParam32_15:
	lw t0, -196(s0)
	lw t1, -76(s0)
	add t2, t0, t1
	sw t2, -200(s0)
.LtestParam32_16:
	lw t0, -200(s0)
	lw t1, -80(s0)
	add t2, t0, t1
	sw t2, -204(s0)
.LtestParam32_17:
	lw t0, -204(s0)
	lw t1, -84(s0)
	sub t2, t0, t1
	sw t2, -208(s0)
.LtestParam32_18:
	lw t0, -208(s0)
	lw t1, -88(s0)
	sub t2, t0, t1
	sw t2, -212(s0)
.LtestParam32_19:
	lw t0, -212(s0)
	lw t1, -92(s0)
	sub t2, t0, t1
	sw t2, -216(s0)
.LtestParam32_20:
	lw t0, -216(s0)
	lw t1, -96(s0)
	sub t2, t0, t1
	sw t2, -220(s0)
.LtestParam32_21:
	lw t0, -220(s0)
	lw t1, -100(s0)
	sub t2, t0, t1
	sw t2, -224(s0)
.LtestParam32_22:
	lw t0, -224(s0)
	lw t1, -104(s0)
	add t2, t0, t1
	sw t2, -228(s0)
.LtestParam32_23:
	lw t0, -228(s0)
	lw t1, -108(s0)
	add t2, t0, t1
	sw t2, -232(s0)
.LtestParam32_24:
	lw t0, -232(s0)
	lw t1, -112(s0)
	add t2, t0, t1
	sw t2, -236(s0)
.LtestParam32_25:
	lw t0, -236(s0)
	lw t1, -116(s0)
	add t2, t0, t1
	sw t2, -240(s0)
.LtestParam32_26:
	lw t0, -240(s0)
	lw t1, -120(s0)
	add t2, t0, t1
	sw t2, -244(s0)
.LtestParam32_27:
	lw t0, -244(s0)
	lw t1, -124(s0)
	add t2, t0, t1
	sw t2, -248(s0)
.LtestParam32_28:
	lw t0, -248(s0)
	lw t1, -128(s0)
	add t2, t0, t1
	sw t2, -252(s0)
.LtestParam32_29:
	lw t0, -252(s0)
	lw t1, -132(s0)
	add t2, t0, t1
	sw t2, -256(s0)
.LtestParam32_30:
	lw t0, -256(s0)
	lw t1, -136(s0)
	add t2, t0, t1
	sw t2, -260(s0)
.LtestParam32_31:
	lw a0, -260(s0)
	j .LtestParam32_epilogue
.LtestParam32_epilogue:
	lw ra, 268(sp)
	lw s0, 264(sp)
	addi sp, sp, 272
	jr ra
.globl main
main:
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	addi s0, sp, 32
.Lmain_0:
	li t0, 0
	sw t0, a0
.Lmain_1:
	li t0, 1
	sw t0, a1
.Lmain_2:
	li t0, 2
	sw t0, a2
.Lmain_3:
	li t0, 3
	sw t0, a3
.Lmain_4:
	li t0, 4
	sw t0, a4
.Lmain_5:
	li t0, 5
	sw t0, a5
.Lmain_6:
	li t0, 6
	sw t0, a6
.Lmain_7:
	li t0, 7
	sw t0, a7
.Lmain_8:
	li t0, 8
	sw t0, a8
.Lmain_9:
	li t0, 9
	sw t0, a9
.Lmain_10:
	li t0, 0
	sw t0, a10
.Lmain_11:
	li t0, 1
	sw t0, a11
.Lmain_12:
	li t0, 2
	sw t0, a12
.Lmain_13:
	li t0, 3
	sw t0, a13
.Lmain_14:
	li t0, 4
	sw t0, a14
.Lmain_15:
	li t0, 5
	sw t0, a15
.Lmain_16:
	li t0, 6
	sw t0, a16
.Lmain_17:
	li t0, 7
	sw t0, a17
.Lmain_18:
	li t0, 8
	sw t0, a18
.Lmain_19:
	li t0, 9
	sw t0, a19
.Lmain_20:
	li t0, 0
	sw t0, a20
.Lmain_21:
	li t0, 1
	sw t0, a21
.Lmain_22:
	li t0, 2
	sw t0, a22
.Lmain_23:
	li t0, 3
	sw t0, a23
.Lmain_24:
	li t0, 4
	sw t0, a24
.Lmain_25:
	li t0, 5
	sw t0, a25
.Lmain_26:
	li t0, 6
	sw t0, a26
.Lmain_27:
	li t0, 7
	sw t0, a27
.Lmain_28:
	li t0, 8
	sw t0, a28
.Lmain_29:
	li t0, 9
	sw t0, a29
.Lmain_30:
	li t0, 0
	sw t0, a30
.Lmain_31:
	li t0, 1
	sw t0, a31
.Lmain_32:
	li t0, 4
	sw t0, a32
.Lmain_33:
	li t0, 5
	sw t0, a33
.Lmain_34:
	li t0, 6
	sw t0, a34
.Lmain_35:
	li t0, 7
	sw t0, a35
.Lmain_36:
	li t0, 8
	sw t0, a36
.Lmain_37:
	li t0, 9
	sw t0, a37
.Lmain_38:
	li t0, 0
	sw t0, a38
.Lmain_39:
	li t0, 1
	sw t0, a39
.Lmain_40:
	lw a0, a0
	lw a1, a1
	lw a2, a2
	lw a3, a3
	lw a4, a4
	lw a5, a5
	lw a6, a6
	lw a7, a7
	call testParam8
	sw a0, -12(s0)
.Lmain_41:
	lw t0, -12(s0)
	sw t0, a0
.Lmain_42:
	lw a0, a0
	call putint
.Lmain_43:
	addi sp, sp, -32
	lw a0, a32
	lw a1, a33
	lw a2, a34
	lw a3, a35
	lw a4, a36
	lw a5, a37
	lw a6, a38
	lw a7, a39
	lw t0, a8
	sw t0, 0(sp)
	lw t0, a9
	sw t0, 4(sp)
	lw t0, a10
	sw t0, 8(sp)
	lw t0, a11
	sw t0, 12(sp)
	lw t0, a12
	sw t0, 16(sp)
	lw t0, a13
	sw t0, 20(sp)
	lw t0, a14
	sw t0, 24(sp)
	lw t0, a15
	sw t0, 28(sp)
	call testParam16
	addi sp, sp, 32
	sw a0, -16(s0)
.Lmain_44:
	lw t0, -16(s0)
	sw t0, a0
.Lmain_45:
	lw a0, a0
	call putint
.Lmain_46:
	addi sp, sp, -96
	lw a0, a0
	lw a1, a1
	lw a2, a2
	lw a3, a3
	lw a4, a4
	lw a5, a5
	lw a6, a6
	lw a7, a7
	lw t0, a8
	sw t0, 0(sp)
	lw t0, a9
	sw t0, 4(sp)
	lw t0, a10
	sw t0, 8(sp)
	lw t0, a11
	sw t0, 12(sp)
	lw t0, a12
	sw t0, 16(sp)
	lw t0, a13
	sw t0, 20(sp)
	lw t0, a14
	sw t0, 24(sp)
	lw t0, a15
	sw t0, 28(sp)
	lw t0, a16
	sw t0, 32(sp)
	lw t0, a17
	sw t0, 36(sp)
	lw t0, a18
	sw t0, 40(sp)
	lw t0, a19
	sw t0, 44(sp)
	lw t0, a20
	sw t0, 48(sp)
	lw t0, a21
	sw t0, 52(sp)
	lw t0, a22
	sw t0, 56(sp)
	lw t0, a23
	sw t0, 60(sp)
	lw t0, a24
	sw t0, 64(sp)
	lw t0, a25
	sw t0, 68(sp)
	lw t0, a26
	sw t0, 72(sp)
	lw t0, a27
	sw t0, 76(sp)
	lw t0, a28
	sw t0, 80(sp)
	lw t0, a29
	sw t0, 84(sp)
	lw t0, a30
	sw t0, 88(sp)
	lw t0, a31
	sw t0, 92(sp)
	call testParam32
	addi sp, sp, 96
	sw a0, -20(s0)
.Lmain_47:
	lw t0, -20(s0)
	sw t0, a0
.Lmain_48:
	lw a0, a0
	call putint
.Lmain_49:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 28(sp)
	lw s0, 24(sp)
	addi sp, sp, 32
	jr ra
