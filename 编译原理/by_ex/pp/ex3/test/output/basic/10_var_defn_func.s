.text
.globl defn
defn:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Ldefn_0:
	li a0, 4
	j .Ldefn_epilogue
.Ldefn_epilogue:
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
	call defn
	sw a0, -12(s0)
.Lmain_1:
	lw t0, -12(s0)
	sw t0, -16(s0)
.Lmain_2:
	lw a0, -16(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
