.text
.globl main
main:
	addi sp, sp, -112
	sw ra, 108(sp)
	sw s0, 104(sp)
	addi s0, sp, 112
.Lmain_0:
	li t0, 5
	sw t0, -12(s0)
.Lmain_1:
	li t0, 5
	sw t0, -16(s0)
.Lmain_2:
	li t0, 1
	sw t0, -20(s0)
.Lmain_3:
	li t0, 0
	li t1, 2
	sub t2, t0, t1
	sw t2, -24(s0)
.Lmain_4:
	lw t0, -24(s0)
	sw t0, -28(s0)
.Lmain_5:
	lw t0, -28(s0)
	li t1, 1
	mul t2, t0, t1
	sw t2, -32(s0)
.Lmain_6:
	lw t0, -32(s0)
	li t1, 2
	div t2, t0, t1
	sw t2, -36(s0)
.Lmain_7:
	lw t0, -12(s0)
	lw t1, -16(s0)
	sub t2, t0, t1
	sw t2, -40(s0)
.Lmain_8:
	lw t0, -36(s0)
	lw t1, -40(s0)
	add t2, t0, t1
	sw t2, -44(s0)
.Lmain_9:
	lw t0, -20(s0)
	li t1, 3
	add t2, t0, t1
	sw t2, -48(s0)
.Lmain_10:
	li t0, 0
	lw t1, -48(s0)
	sub t2, t0, t1
	sw t2, -52(s0)
.Lmain_11:
	lw t0, -52(s0)
	li t1, 2
	rem t2, t0, t1
	sw t2, -56(s0)
.Lmain_12:
	lw t0, -44(s0)
	lw t1, -56(s0)
	sub t2, t0, t1
	sw t2, -60(s0)
.Lmain_13:
	lw t0, -60(s0)
	sw t0, -64(s0)
.Lmain_14:
	lw a0, -64(s0)
	call putint
.Lmain_15:
	lw t0, -28(s0)
	li t1, 2
	rem t2, t0, t1
	sw t2, -68(s0)
.Lmain_16:
	lw t0, -68(s0)
	li t1, 67
	add t2, t0, t1
	sw t2, -72(s0)
.Lmain_17:
	lw t0, -12(s0)
	lw t1, -16(s0)
	sub t2, t0, t1
	sw t2, -76(s0)
.Lmain_18:
	li t0, 0
	lw t1, -76(s0)
	sub t2, t0, t1
	sw t2, -80(s0)
.Lmain_19:
	lw t0, -72(s0)
	lw t1, -80(s0)
	add t2, t0, t1
	sw t2, -84(s0)
.Lmain_20:
	lw t0, -20(s0)
	li t1, 2
	add t2, t0, t1
	sw t2, -88(s0)
.Lmain_21:
	lw t0, -88(s0)
	li t1, 2
	rem t2, t0, t1
	sw t2, -92(s0)
.Lmain_22:
	li t0, 0
	lw t1, -92(s0)
	sub t2, t0, t1
	sw t2, -96(s0)
.Lmain_23:
	lw t0, -84(s0)
	lw t1, -96(s0)
	sub t2, t0, t1
	sw t2, -100(s0)
.Lmain_24:
	lw t0, -100(s0)
	sw t0, -64(s0)
.Lmain_25:
	lw t0, -64(s0)
	li t1, 3
	add t2, t0, t1
	sw t2, -104(s0)
.Lmain_26:
	lw t0, -104(s0)
	sw t0, -64(s0)
.Lmain_27:
	lw a0, -64(s0)
	call putint
.Lmain_28:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 108(sp)
	lw s0, 104(sp)
	addi sp, sp, 112
	jr ra
