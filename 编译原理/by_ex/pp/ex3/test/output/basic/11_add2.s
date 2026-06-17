.text
.globl main
main:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
.Lmain_0:
	li t0, 0
	sw t0, -12(s0)
.Lmain_1:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -16(s0)
.Lmain_2:
	lw t0, -16(s0)
	sw t0, -12(s0)
.Lmain_3:
	lw t0, -12(s0)
	li t1, 2
	add t2, t0, t1
	sw t2, -20(s0)
.Lmain_4:
	lw t0, -20(s0)
	sw t0, -12(s0)
.Lmain_5:
	lw t0, -12(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -24(s0)
.Lmain_6:
	lw t0, -24(s0)
	sw t0, -12(s0)
.Lmain_7:
	lw t0, -12(s0)
	li t1, 3
	sub t2, t0, t1
	sw t2, -28(s0)
.Lmain_8:
	lw t0, -28(s0)
	sw t0, -12(s0)
.Lmain_9:
	lw t0, -12(s0)
	li t1, 2
	add t2, t0, t1
	sw t2, -32(s0)
.Lmain_10:
	lw t0, -32(s0)
	sw t0, -12(s0)
.Lmain_11:
	li t0, 2
	sw t0, -36(s0)
.Lmain_12:
	lw t0, -12(s0)
	lw t1, -36(s0)
	div t2, t0, t1
	sw t2, -40(s0)
.Lmain_13:
	lw a0, -40(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
