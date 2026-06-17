.text
.globl doubleWhile
doubleWhile:
	addi sp, sp, -64
	sw ra, 60(sp)
	sw s0, 56(sp)
	addi s0, sp, 64
.LdoubleWhile_0:
	li t0, 5
	sw t0, -12(s0)
.LdoubleWhile_1:
	li t0, 7
	sw t0, -16(s0)
.LdoubleWhile_2:
	lw t0, -12(s0)
	li t1, 100
	slt t2, t0, t1
	sw t2, -20(s0)
.LdoubleWhile_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.LdoubleWhile_4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.LdoubleWhile_5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.LdoubleWhile_6:
	lw t0, -32(s0)
	bne t0, x0, .LdoubleWhile_8
.LdoubleWhile_7:
	j .LdoubleWhile_22
.LdoubleWhile_8:
	lw t0, -12(s0)
	li t1, 30
	add t2, t0, t1
	sw t2, -36(s0)
.LdoubleWhile_9:
	lw t0, -36(s0)
	sw t0, -12(s0)
.LdoubleWhile_10:
	lw t0, -16(s0)
	li t1, 100
	slt t2, t0, t1
	sw t2, -40(s0)
.LdoubleWhile_11:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.LdoubleWhile_12:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.LdoubleWhile_13:
	lw t0, -48(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.LdoubleWhile_14:
	lw t0, -52(s0)
	bne t0, x0, .LdoubleWhile_16
.LdoubleWhile_15:
	j .LdoubleWhile_19
.LdoubleWhile_16:
	lw t0, -16(s0)
	li t1, 6
	add t2, t0, t1
	sw t2, -56(s0)
.LdoubleWhile_17:
	lw t0, -56(s0)
	sw t0, -16(s0)
.LdoubleWhile_18:
	j .LdoubleWhile_10
.LdoubleWhile_19:
	lw t0, -16(s0)
	li t1, 100
	sub t2, t0, t1
	sw t2, -60(s0)
.LdoubleWhile_20:
	lw t0, -60(s0)
	sw t0, -16(s0)
.LdoubleWhile_21:
	j .LdoubleWhile_2
.LdoubleWhile_22:
	lw a0, -16(s0)
	j .LdoubleWhile_epilogue
.LdoubleWhile_epilogue:
	lw ra, 60(sp)
	lw s0, 56(sp)
	addi sp, sp, 64
	jr ra
.globl main
main:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lmain_0:
	call doubleWhile
	sw a0, -12(s0)
.Lmain_1:
	lw a0, -12(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
