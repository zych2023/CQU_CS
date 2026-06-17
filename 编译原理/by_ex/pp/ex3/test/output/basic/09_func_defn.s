.data
.globl a
a:
	.word 0
.text
.globl func
func:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
	sw a0, -12(s0)
.Lfunc_0:
	lw t0, -12(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -16(s0)
.Lfunc_1:
	lw t0, -16(s0)
	sw t0, -12(s0)
.Lfunc_2:
	lw a0, -12(s0)
	j .Lfunc_epilogue
.Lfunc_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl main
main:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lmain_0:
	li t0, 10
	sw t0, a
.Lmain_1:
	lw a0, a
	call func
	sw a0, -12(s0)
.Lmain_2:
	lw t0, -12(s0)
	sw t0, -16(s0)
.Lmain_3:
	lw a0, -16(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
