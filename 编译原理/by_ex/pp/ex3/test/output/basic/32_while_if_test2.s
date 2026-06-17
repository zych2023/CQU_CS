.text
.globl ifWhile
ifWhile:
	addi sp, sp, -80
	sw ra, 76(sp)
	sw s0, 72(sp)
	addi s0, sp, 80
.LifWhile_0:
	li t0, 0
	sw t0, -12(s0)
.LifWhile_1:
	li t0, 3
	sw t0, -16(s0)
.LifWhile_2:
	lw t0, -12(s0)
	li t1, 5
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -20(s0)
.LifWhile_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.LifWhile_4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.LifWhile_5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.LifWhile_6:
	lw t0, -32(s0)
	bne t0, x0, .LifWhile_19
.LifWhile_7:
	lw t0, -12(s0)
	li t1, 5
	slt t2, t0, t1
	sw t2, -36(s0)
.LifWhile_8:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.LifWhile_9:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.LifWhile_10:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.LifWhile_11:
	lw t0, -48(s0)
	bne t0, x0, .LifWhile_13
.LifWhile_12:
	j .LifWhile_18
.LifWhile_13:
	lw t0, -16(s0)
	li t1, 2
	mul t2, t0, t1
	sw t2, -52(s0)
.LifWhile_14:
	lw t0, -52(s0)
	sw t0, -16(s0)
.LifWhile_15:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -56(s0)
.LifWhile_16:
	lw t0, -56(s0)
	sw t0, -12(s0)
.LifWhile_17:
	j .LifWhile_7
.LifWhile_18:
	j .LifWhile_30
.LifWhile_19:
	lw t0, -16(s0)
	li t1, 2
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -60(s0)
.LifWhile_20:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.LifWhile_21:
	lw t0, -64(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.LifWhile_22:
	lw t0, -68(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -72(s0)
.LifWhile_23:
	lw t0, -72(s0)
	bne t0, x0, .LifWhile_25
.LifWhile_24:
	j .LifWhile_28
.LifWhile_25:
	lw t0, -16(s0)
	li t1, 2
	add t2, t0, t1
	sw t2, -76(s0)
.LifWhile_26:
	lw t0, -76(s0)
	sw t0, -16(s0)
.LifWhile_27:
	j .LifWhile_19
.LifWhile_28:
	lw t0, -16(s0)
	li t1, 25
	add t2, t0, t1
	sw t2, -80(s0)
.LifWhile_29:
	lw t0, -80(s0)
	sw t0, -16(s0)
.LifWhile_30:
	lw a0, -16(s0)
	j .LifWhile_epilogue
.LifWhile_epilogue:
	lw ra, 76(sp)
	lw s0, 72(sp)
	addi sp, sp, 80
	jr ra
.globl main
main:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lmain_0:
	call ifWhile
	sw a0, -12(s0)
.Lmain_1:
	lw a0, -12(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
