.text
.globl if_ifElse_
if_ifElse_:
	addi sp, sp, -64
	sw ra, 60(sp)
	sw s0, 56(sp)
	addi s0, sp, 64
.Lif_ifElse__0:
	li t0, 5
	sw t0, -12(s0)
.Lif_ifElse__1:
	li t0, 10
	sw t0, -16(s0)
.Lif_ifElse__2:
	lw t0, -12(s0)
	li t1, 5
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -20(s0)
.Lif_ifElse__3:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lif_ifElse__4:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lif_ifElse__5:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lif_ifElse__6:
	lw t0, -32(s0)
	bne t0, x0, .Lif_ifElse__8
.Lif_ifElse__7:
	j .Lif_ifElse__17
.Lif_ifElse__8:
	lw t0, -16(s0)
	li t1, 10
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -36(s0)
.Lif_ifElse__9:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lif_ifElse__10:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lif_ifElse__11:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lif_ifElse__12:
	lw t0, -48(s0)
	bne t0, x0, .Lif_ifElse__16
.Lif_ifElse__13:
	lw t0, -12(s0)
	li t1, 15
	add t2, t0, t1
	sw t2, -52(s0)
.Lif_ifElse__14:
	lw t0, -52(s0)
	sw t0, -12(s0)
.Lif_ifElse__15:
	j .Lif_ifElse__17
.Lif_ifElse__16:
	li t0, 25
	sw t0, -12(s0)
.Lif_ifElse__17:
	lw a0, -12(s0)
	j .Lif_ifElse__epilogue
.Lif_ifElse__epilogue:
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
	call if_ifElse_
	sw a0, -12(s0)
.Lmain_1:
	lw a0, -12(s0)
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
