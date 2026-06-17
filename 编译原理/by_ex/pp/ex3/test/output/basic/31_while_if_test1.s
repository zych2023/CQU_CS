.text
.globl whileIf
whileIf:
	addi sp, sp, -80
	sw ra, 76(sp)
	sw s0, 72(sp)
	addi s0, sp, 80
.LwhileIf_0:
	li t0, 0
	sw t0, -12(s0)
.LwhileIf_1:
	li t0, 0
	sw t0, -16(s0)
.LwhileIf_2:
	lw t0, -12(s0)
	li t1, 100
	slt t2, t0, t1
	sw t2, -20(s0)
.LwhileIf_3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.LwhileIf_4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.LwhileIf_5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.LwhileIf_6:
	lw t0, -32(s0)
	bne t0, x0, .LwhileIf_8
.LwhileIf_7:
	j .LwhileIf_27
.LwhileIf_8:
	lw t0, -12(s0)
	li t1, 5
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -36(s0)
.LwhileIf_9:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.LwhileIf_10:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.LwhileIf_11:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.LwhileIf_12:
	lw t0, -48(s0)
	bne t0, x0, .LwhileIf_23
.LwhileIf_13:
	lw t0, -12(s0)
	li t1, 10
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -52(s0)
.LwhileIf_14:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.LwhileIf_15:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.LwhileIf_16:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.LwhileIf_17:
	lw t0, -64(s0)
	bne t0, x0, .LwhileIf_21
.LwhileIf_18:
	lw t0, -12(s0)
	li t1, 2
	mul t2, t0, t1
	sw t2, -68(s0)
.LwhileIf_19:
	lw t0, -68(s0)
	sw t0, -16(s0)
.LwhileIf_20:
	j .LwhileIf_22
.LwhileIf_21:
	li t0, 42
	sw t0, -16(s0)
.LwhileIf_22:
	j .LwhileIf_24
.LwhileIf_23:
	li t0, 25
	sw t0, -16(s0)
.LwhileIf_24:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -72(s0)
.LwhileIf_25:
	lw t0, -72(s0)
	sw t0, -12(s0)
.LwhileIf_26:
	j .LwhileIf_2
.LwhileIf_27:
	lw a0, -16(s0)
	j .LwhileIf_epilogue
.LwhileIf_epilogue:
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
	call whileIf
	sw a0, -12(s0)
.Lmain_1:
	lw a0, -12(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
