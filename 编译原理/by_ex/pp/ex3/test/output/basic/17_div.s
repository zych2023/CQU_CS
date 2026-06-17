.text
.globl main
main:
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	addi s0, sp, 32
.Lmain_0:
	li t0, 10
	sw t0, -12(s0)
.Lmain_1:
	li t0, 5
	sw t0, -16(s0)
.Lmain_2:
	lw t0, -12(s0)
	lw t1, -16(s0)
	div t2, t0, t1
	sw t2, -20(s0)
.Lmain_3:
	lw a0, -20(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 28(sp)
	lw s0, 24(sp)
	addi sp, sp, 32
	jr ra
