.text
.globl main
main:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
.Lmain_0:
	li t0, 10
	sw t0, -12(s0)
.Lmain_1:
	li t0, 30
	sw t0, -16(s0)
.Lmain_2:
	li t0, 0
	li t1, 5
	sub t2, t0, t1
	sw t2, -20(s0)
.Lmain_3:
	lw t0, -12(s0)
	lw t1, -20(s0)
	sub t2, t0, t1
	sw t2, -24(s0)
.Lmain_4:
	lw t0, -24(s0)
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -28(s0)
.Lmain_5:
	li t0, 0
	li t1, 5
	sub t2, t0, t1
	sw t2, -32(s0)
.Lmain_6:
	lw t0, -28(s0)
	lw t1, -32(s0)
	add t2, t0, t1
	sw t2, -36(s0)
.Lmain_7:
	lw a0, -36(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
