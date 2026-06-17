.text
.globl exgcd
exgcd:
	addi sp, sp, -128
	sw ra, 124(sp)
	sw s0, 120(sp)
	addi s0, sp, 128
	sw a0, -12(s0)
	sw a1, -16(s0)
	sw a2, -20(s0)
	sw a3, -24(s0)
.Lexgcd_0:
	lw t0, -16(s0)
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -28(s0)
.Lexgcd_1:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lexgcd_2:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lexgcd_3:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lexgcd_4:
	lw t0, -40(s0)
	bne t0, x0, .Lexgcd_26
.Lexgcd_5:
	lw t0, -12(s0)
	lw t1, -16(s0)
	rem t2, t0, t1
	sw t2, -44(s0)
.Lexgcd_6:
	lw t0, -20(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	sw t0, -48(s0)
.Lexgcd_7:
	lw t0, -24(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	sw t0, -52(s0)
.Lexgcd_8:
	lw a0, -16(s0)
	lw a1, -44(s0)
	lw a2, -48(s0)
	lw a3, -52(s0)
	call exgcd
	sw a0, -56(s0)
.Lexgcd_9:
	lw t0, -56(s0)
	sw t0, -60(s0)
.Lexgcd_10:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -64(s0)
.Lexgcd_11:
	lw t0, -20(s0)
	lw t1, -64(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -68(s0)
.Lexgcd_12:
	lw t0, -68(s0)
	sw t0, -72(s0)
.Lexgcd_13:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -76(s0)
.Lexgcd_14:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -80(s0)
.Lexgcd_15:
	lw t0, -24(s0)
	lw t1, -80(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -84(s0)
.Lexgcd_16:
	lw t0, -20(s0)
	lw t1, -76(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -84(s0)
	sw t2, 0(t0)
.Lexgcd_17:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -88(s0)
.Lexgcd_18:
	lw t0, -12(s0)
	lw t1, -16(s0)
	div t2, t0, t1
	sw t2, -92(s0)
.Lexgcd_19:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -96(s0)
.Lexgcd_20:
	lw t0, -24(s0)
	lw t1, -96(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -100(s0)
.Lexgcd_21:
	lw t0, -92(s0)
	lw t1, -100(s0)
	mul t2, t0, t1
	sw t2, -104(s0)
.Lexgcd_22:
	lw t0, -72(s0)
	lw t1, -104(s0)
	sub t2, t0, t1
	sw t2, -108(s0)
.Lexgcd_23:
	lw t0, -24(s0)
	lw t1, -88(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -108(s0)
	sw t2, 0(t0)
.Lexgcd_24:
	lw a0, -60(s0)
	j .Lexgcd_epilogue
.Lexgcd_25:
	j .Lexgcd_epilogue
.Lexgcd_26:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -112(s0)
.Lexgcd_27:
	lw t0, -20(s0)
	lw t1, -112(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.Lexgcd_28:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -116(s0)
.Lexgcd_29:
	lw t0, -24(s0)
	lw t1, -116(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	sw t2, 0(t0)
.Lexgcd_30:
	lw a0, -12(s0)
	j .Lexgcd_epilogue
.Lexgcd_epilogue:
	lw ra, 124(sp)
	lw s0, 120(sp)
	addi sp, sp, 128
	jr ra
.globl main
main:
	addi sp, sp, -80
	sw ra, 76(sp)
	sw s0, 72(sp)
	addi s0, sp, 80
.Lmain_0:
	li t0, 7
	sw t0, -12(s0)
.Lmain_1:
	li t0, 15
	sw t0, -16(s0)
.Lmain_2:
	addi t0, s0, -24
	sw t0, -20(s0)
.Lmain_3:
	lw t0, -20(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.Lmain_4:
	addi t0, s0, -32
	sw t0, -28(s0)
.Lmain_5:
	lw t0, -28(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1
	sw t2, 0(t0)
.Lmain_6:
	lw t0, -20(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	sw t0, -36(s0)
.Lmain_7:
	lw t0, -28(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	sw t0, -40(s0)
.Lmain_8:
	lw a0, -12(s0)
	lw a1, -16(s0)
	lw a2, -36(s0)
	lw a3, -40(s0)
	call exgcd
	sw a0, -44(s0)
.Lmain_9:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -48(s0)
.Lmain_10:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -52(s0)
.Lmain_11:
	lw t0, -20(s0)
	lw t1, -52(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -56(s0)
.Lmain_12:
	lw t0, -56(s0)
	lw t1, -16(s0)
	rem t2, t0, t1
	sw t2, -60(s0)
.Lmain_13:
	lw t0, -60(s0)
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -64(s0)
.Lmain_14:
	lw t0, -64(s0)
	lw t1, -16(s0)
	rem t2, t0, t1
	sw t2, -68(s0)
.Lmain_15:
	lw t0, -20(s0)
	lw t1, -48(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -68(s0)
	sw t2, 0(t0)
.Lmain_16:
	li t0, 0
	li t1, 0
	add t2, t0, t1
	sw t2, -72(s0)
.Lmain_17:
	lw t0, -20(s0)
	lw t1, -72(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -76(s0)
.Lmain_18:
	lw a0, -76(s0)
	call putint
.Lmain_19:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 76(sp)
	lw s0, 72(sp)
	addi sp, sp, 80
	jr ra
