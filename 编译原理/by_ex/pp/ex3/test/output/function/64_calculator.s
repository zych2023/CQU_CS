.data
.globl ints
ints:
	.zero 40000
.globl intt
intt:
	.word 0
.globl chas
chas:
	.zero 40000
.globl chat
chat:
	.word 0
.globl i
i:
	.word 0
.globl ii
ii:
	.word 0
.globl c
c:
	.word 0
.globl get
get:
	.zero 40000
.globl get2
get2:
	.zero 40000
.text
.globl isdigit
isdigit:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
	sw a0, -12(s0)
.Lisdigit_0:
	lw t0, -12(s0)
	li t1, 48
	slt t2, t0, t1
	xori t2, t2, 1
	sw t2, -16(s0)
.Lisdigit_1:
	lw t0, -16(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -20(s0)
.Lisdigit_2:
	li t0, 0
	sw t0, -24(s0)
.Lisdigit_3:
	lw t0, -20(s0)
	bne t0, x0, .Lisdigit_5
.Lisdigit_4:
	j .Lisdigit_9
.Lisdigit_5:
	lw t0, -12(s0)
	li t1, 57
	slt t2, t1, t0
	xori t2, t2, 1
	sw t2, -28(s0)
.Lisdigit_6:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lisdigit_7:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lisdigit_8:
	lw t0, -36(s0)
	sw t0, -24(s0)
.Lisdigit_9:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lisdigit_10:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lisdigit_11:
	lw t0, -44(s0)
	bne t0, x0, .Lisdigit_13
.Lisdigit_12:
	j .Lisdigit_14
.Lisdigit_13:
	li a0, 1
	j .Lisdigit_epilogue
.Lisdigit_14:
	li a0, 0
	j .Lisdigit_epilogue
.Lisdigit_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
.globl power
power:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
	sw a0, -12(s0)
	sw a1, -16(s0)
.Lpower_0:
	li t0, 1
	sw t0, -20(s0)
.Lpower_1:
	lw t0, -16(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lpower_2:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lpower_3:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lpower_4:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lpower_5:
	lw t0, -36(s0)
	bne t0, x0, .Lpower_7
.Lpower_6:
	j .Lpower_12
.Lpower_7:
	lw t0, -20(s0)
	lw t1, -12(s0)
	mul t2, t0, t1
	sw t2, -40(s0)
.Lpower_8:
	lw t0, -40(s0)
	sw t0, -20(s0)
.Lpower_9:
	lw t0, -16(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -44(s0)
.Lpower_10:
	lw t0, -44(s0)
	sw t0, -16(s0)
.Lpower_11:
	j .Lpower_1
.Lpower_12:
	lw a0, -20(s0)
	j .Lpower_epilogue
.Lpower_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
.globl getstr
getstr:
	addi sp, sp, -80
	sw ra, 76(sp)
	sw s0, 72(sp)
	addi s0, sp, 80
	sw a0, -12(s0)
.Lgetstr_0:
	call getch
	sw a0, -16(s0)
.Lgetstr_1:
	lw t0, -16(s0)
	sw t0, -20(s0)
.Lgetstr_2:
	li t0, 0
	sw t0, -24(s0)
.Lgetstr_3:
	lw t0, -20(s0)
	li t1, 13
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lgetstr_4:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lgetstr_5:
	li t0, 0
	sw t0, -36(s0)
.Lgetstr_6:
	lw t0, -32(s0)
	bne t0, x0, .Lgetstr_8
.Lgetstr_7:
	j .Lgetstr_12
.Lgetstr_8:
	lw t0, -20(s0)
	li t1, 10
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lgetstr_9:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lgetstr_10:
	lw t0, -44(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -48(s0)
.Lgetstr_11:
	lw t0, -48(s0)
	sw t0, -36(s0)
.Lgetstr_12:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -52(s0)
.Lgetstr_13:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.Lgetstr_14:
	lw t0, -56(s0)
	bne t0, x0, .Lgetstr_16
.Lgetstr_15:
	j .Lgetstr_23
.Lgetstr_16:
	li t0, 0
	lw t1, -24(s0)
	add t2, t0, t1
	sw t2, -60(s0)
.Lgetstr_17:
	lw t0, -12(s0)
	lw t1, -60(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -20(s0)
	sw t2, 0(t0)
.Lgetstr_18:
	lw t0, -24(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -64(s0)
.Lgetstr_19:
	lw t0, -64(s0)
	sw t0, -24(s0)
.Lgetstr_20:
	call getch
	sw a0, -68(s0)
.Lgetstr_21:
	lw t0, -68(s0)
	sw t0, -20(s0)
.Lgetstr_22:
	j .Lgetstr_3
.Lgetstr_23:
	lw a0, -24(s0)
	j .Lgetstr_epilogue
.Lgetstr_epilogue:
	lw ra, 76(sp)
	lw s0, 72(sp)
	addi sp, sp, 80
	jr ra
.globl intpush
intpush:
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	addi s0, sp, 32
	sw a0, -12(s0)
.Lintpush_0:
	lw t0, intt
	li t1, 1
	add t2, t0, t1
	sw t2, -16(s0)
.Lintpush_1:
	lw t0, -16(s0)
	sw t0, intt
.Lintpush_2:
	li t0, 0
	lw t1, intt
	add t2, t0, t1
	sw t2, -20(s0)
.Lintpush_3:
	la t0, ints
	lw t1, -20(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -12(s0)
	sw t2, 0(t0)
.Lintpush_4:
	j .Lintpush_epilogue
.Lintpush_epilogue:
	lw ra, 28(sp)
	lw s0, 24(sp)
	addi sp, sp, 32
	jr ra
.globl chapush
chapush:
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	addi s0, sp, 32
	sw a0, -12(s0)
.Lchapush_0:
	lw t0, chat
	li t1, 1
	add t2, t0, t1
	sw t2, -16(s0)
.Lchapush_1:
	lw t0, -16(s0)
	sw t0, chat
.Lchapush_2:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -20(s0)
.Lchapush_3:
	la t0, chas
	lw t1, -20(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -12(s0)
	sw t2, 0(t0)
.Lchapush_4:
	j .Lchapush_epilogue
.Lchapush_epilogue:
	lw ra, 28(sp)
	lw s0, 24(sp)
	addi sp, sp, 32
	jr ra
.globl intpop
intpop:
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	addi s0, sp, 32
.Lintpop_0:
	lw t0, intt
	li t1, 1
	sub t2, t0, t1
	sw t2, -12(s0)
.Lintpop_1:
	lw t0, -12(s0)
	sw t0, intt
.Lintpop_2:
	lw t0, intt
	li t1, 1
	add t2, t0, t1
	sw t2, -16(s0)
.Lintpop_3:
	li t0, 0
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -20(s0)
.Lintpop_4:
	la t0, ints
	lw t1, -20(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -24(s0)
.Lintpop_5:
	lw a0, -24(s0)
	j .Lintpop_epilogue
.Lintpop_epilogue:
	lw ra, 28(sp)
	lw s0, 24(sp)
	addi sp, sp, 32
	jr ra
.globl chapop
chapop:
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	addi s0, sp, 32
.Lchapop_0:
	lw t0, chat
	li t1, 1
	sub t2, t0, t1
	sw t2, -12(s0)
.Lchapop_1:
	lw t0, -12(s0)
	sw t0, chat
.Lchapop_2:
	lw t0, chat
	li t1, 1
	add t2, t0, t1
	sw t2, -16(s0)
.Lchapop_3:
	li t0, 0
	lw t1, -16(s0)
	add t2, t0, t1
	sw t2, -20(s0)
.Lchapop_4:
	la t0, chas
	lw t1, -20(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -24(s0)
.Lchapop_5:
	lw a0, -24(s0)
	j .Lchapop_epilogue
.Lchapop_epilogue:
	lw ra, 28(sp)
	lw s0, 24(sp)
	addi sp, sp, 32
	jr ra
.globl intadd
intadd:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
	sw a0, -12(s0)
.Lintadd_0:
	li t0, 0
	lw t1, intt
	add t2, t0, t1
	sw t2, -16(s0)
.Lintadd_1:
	li t0, 0
	lw t1, intt
	add t2, t0, t1
	sw t2, -20(s0)
.Lintadd_2:
	la t0, ints
	lw t1, -20(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -24(s0)
.Lintadd_3:
	lw t0, -24(s0)
	li t1, 10
	mul t2, t0, t1
	sw t2, -28(s0)
.Lintadd_4:
	la t0, ints
	lw t1, -16(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -28(s0)
	sw t2, 0(t0)
.Lintadd_5:
	li t0, 0
	lw t1, intt
	add t2, t0, t1
	sw t2, -32(s0)
.Lintadd_6:
	li t0, 0
	lw t1, intt
	add t2, t0, t1
	sw t2, -36(s0)
.Lintadd_7:
	la t0, ints
	lw t1, -36(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -40(s0)
.Lintadd_8:
	lw t0, -40(s0)
	lw t1, -12(s0)
	add t2, t0, t1
	sw t2, -44(s0)
.Lintadd_9:
	la t0, ints
	lw t1, -32(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -44(s0)
	sw t2, 0(t0)
.Lintadd_10:
	j .Lintadd_epilogue
.Lintadd_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
.globl find
find:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
.Lfind_0:
	call chapop
	sw a0, -12(s0)
.Lfind_1:
	lw t0, -12(s0)
	sw t0, c
.Lfind_2:
	li t0, 0
	lw t1, ii
	add t2, t0, t1
	sw t2, -16(s0)
.Lfind_3:
	la t0, get2
	lw t1, -16(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 32
	sw t2, 0(t0)
.Lfind_4:
	lw t0, ii
	li t1, 1
	add t2, t0, t1
	sw t2, -20(s0)
.Lfind_5:
	li t0, 0
	lw t1, -20(s0)
	add t2, t0, t1
	sw t2, -24(s0)
.Lfind_6:
	la t0, get2
	lw t1, -24(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, c
	sw t2, 0(t0)
.Lfind_7:
	lw t0, ii
	li t1, 2
	add t2, t0, t1
	sw t2, -28(s0)
.Lfind_8:
	lw t0, -28(s0)
	sw t0, ii
.Lfind_9:
	lw t0, chat
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -32(s0)
.Lfind_10:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lfind_11:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lfind_12:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lfind_13:
	lw t0, -44(s0)
	bne t0, x0, .Lfind_15
.Lfind_14:
	j .Lfind_16
.Lfind_15:
	li a0, 0
	j .Lfind_epilogue
.Lfind_16:
	li a0, 1
	j .Lfind_epilogue
.Lfind_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
.globl main
main:
	addi sp, sp, -1696
	sw ra, 1692(sp)
	sw s0, 1688(sp)
	addi s0, sp, 1696
.Lmain_0:
	call __global_init
.Lmain_1:
	li t0, 0
	sw t0, intt
.Lmain_2:
	li t0, 0
	sw t0, chat
.Lmain_3:
	la t0, get
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	sw t0, -12(s0)
.Lmain_4:
	lw a0, -12(s0)
	call getstr
	sw a0, -16(s0)
.Lmain_5:
	lw t0, -16(s0)
	sw t0, -20(s0)
.Lmain_6:
	lw t0, i
	lw t1, -20(s0)
	slt t2, t0, t1
	sw t2, -24(s0)
.Lmain_7:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lmain_8:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lmain_9:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lmain_10:
	lw t0, -36(s0)
	bne t0, x0, .Lmain_12
.Lmain_11:
	j .Lmain_417
.Lmain_12:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -40(s0)
.Lmain_13:
	la t0, get
	lw t1, -40(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -44(s0)
.Lmain_14:
	lw a0, -44(s0)
	call isdigit
	sw a0, -48(s0)
.Lmain_15:
	lw t0, -48(s0)
	li t1, 1
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -52(s0)
.Lmain_16:
	lw t0, -52(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -56(s0)
.Lmain_17:
	lw t0, -56(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -60(s0)
.Lmain_18:
	lw t0, -60(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -64(s0)
.Lmain_19:
	lw t0, -64(s0)
	bne t0, x0, .Lmain_408
.Lmain_20:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -68(s0)
.Lmain_21:
	la t0, get
	lw t1, -68(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -72(s0)
.Lmain_22:
	lw t0, -72(s0)
	li t1, 40
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -76(s0)
.Lmain_23:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.Lmain_24:
	lw t0, -80(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -84(s0)
.Lmain_25:
	lw t0, -84(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -88(s0)
.Lmain_26:
	lw t0, -88(s0)
	bne t0, x0, .Lmain_28
.Lmain_27:
	j .Lmain_29
.Lmain_28:
	li a0, 40
	call chapush
.Lmain_29:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -92(s0)
.Lmain_30:
	la t0, get
	lw t1, -92(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -96(s0)
.Lmain_31:
	lw t0, -96(s0)
	li t1, 94
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -100(s0)
.Lmain_32:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.Lmain_33:
	lw t0, -104(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -108(s0)
.Lmain_34:
	lw t0, -108(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.Lmain_35:
	lw t0, -112(s0)
	bne t0, x0, .Lmain_37
.Lmain_36:
	j .Lmain_38
.Lmain_37:
	li a0, 94
	call chapush
.Lmain_38:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -116(s0)
.Lmain_39:
	la t0, get
	lw t1, -116(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -120(s0)
.Lmain_40:
	lw t0, -120(s0)
	li t1, 41
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -124(s0)
.Lmain_41:
	lw t0, -124(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -128(s0)
.Lmain_42:
	lw t0, -128(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -132(s0)
.Lmain_43:
	lw t0, -132(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -136(s0)
.Lmain_44:
	lw t0, -136(s0)
	bne t0, x0, .Lmain_46
.Lmain_45:
	j .Lmain_64
.Lmain_46:
	call chapop
	sw a0, -140(s0)
.Lmain_47:
	lw t0, -140(s0)
	sw t0, c
.Lmain_48:
	lw t0, c
	li t1, 40
	xor t2, t0, t1
	snez t2, t2
	sw t2, -144(s0)
.Lmain_49:
	lw t0, -144(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -148(s0)
.Lmain_50:
	lw t0, -148(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -152(s0)
.Lmain_51:
	lw t0, -152(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -156(s0)
.Lmain_52:
	lw t0, -156(s0)
	bne t0, x0, .Lmain_54
.Lmain_53:
	j .Lmain_64
.Lmain_54:
	li t0, 0
	lw t1, ii
	add t2, t0, t1
	sw t2, -160(s0)
.Lmain_55:
	la t0, get2
	lw t1, -160(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 32
	sw t2, 0(t0)
.Lmain_56:
	lw t0, ii
	li t1, 1
	add t2, t0, t1
	sw t2, -164(s0)
.Lmain_57:
	li t0, 0
	lw t1, -164(s0)
	add t2, t0, t1
	sw t2, -168(s0)
.Lmain_58:
	la t0, get2
	lw t1, -168(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, c
	sw t2, 0(t0)
.Lmain_59:
	lw t0, ii
	li t1, 2
	add t2, t0, t1
	sw t2, -172(s0)
.Lmain_60:
	lw t0, -172(s0)
	sw t0, ii
.Lmain_61:
	call chapop
	sw a0, -176(s0)
.Lmain_62:
	lw t0, -176(s0)
	sw t0, c
.Lmain_63:
	j .Lmain_48
.Lmain_64:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -180(s0)
.Lmain_65:
	la t0, get
	lw t1, -180(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -184(s0)
.Lmain_66:
	lw t0, -184(s0)
	li t1, 43
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -188(s0)
.Lmain_67:
	lw t0, -188(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -192(s0)
.Lmain_68:
	lw t0, -192(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -196(s0)
.Lmain_69:
	lw t0, -196(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -200(s0)
.Lmain_70:
	lw t0, -200(s0)
	bne t0, x0, .Lmain_72
.Lmain_71:
	j .Lmain_145
.Lmain_72:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -204(s0)
.Lmain_73:
	la t0, chas
	lw t1, -204(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -208(s0)
.Lmain_74:
	lw t0, -208(s0)
	li t1, 43
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -212(s0)
.Lmain_75:
	lw t0, -212(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -216(s0)
.Lmain_76:
	lw t0, -216(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -220(s0)
.Lmain_77:
	li t0, 1
	sw t0, -224(s0)
.Lmain_78:
	lw t0, -220(s0)
	seqz t2, t0
	sw t2, -228(s0)
.Lmain_79:
	lw t0, -228(s0)
	bne t0, x0, .Lmain_81
.Lmain_80:
	j .Lmain_132
.Lmain_81:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -232(s0)
.Lmain_82:
	la t0, chas
	lw t1, -232(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -236(s0)
.Lmain_83:
	lw t0, -236(s0)
	li t1, 45
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -240(s0)
.Lmain_84:
	lw t0, -240(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -244(s0)
.Lmain_85:
	lw t0, -244(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -248(s0)
.Lmain_86:
	li t0, 1
	sw t0, -252(s0)
.Lmain_87:
	lw t0, -248(s0)
	seqz t2, t0
	sw t2, -256(s0)
.Lmain_88:
	lw t0, -256(s0)
	bne t0, x0, .Lmain_90
.Lmain_89:
	j .Lmain_130
.Lmain_90:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -260(s0)
.Lmain_91:
	la t0, chas
	lw t1, -260(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -264(s0)
.Lmain_92:
	lw t0, -264(s0)
	li t1, 42
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -268(s0)
.Lmain_93:
	lw t0, -268(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -272(s0)
.Lmain_94:
	lw t0, -272(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -276(s0)
.Lmain_95:
	li t0, 1
	sw t0, -280(s0)
.Lmain_96:
	lw t0, -276(s0)
	seqz t2, t0
	sw t2, -284(s0)
.Lmain_97:
	lw t0, -284(s0)
	bne t0, x0, .Lmain_99
.Lmain_98:
	j .Lmain_128
.Lmain_99:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -288(s0)
.Lmain_100:
	la t0, chas
	lw t1, -288(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -292(s0)
.Lmain_101:
	lw t0, -292(s0)
	li t1, 47
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -296(s0)
.Lmain_102:
	lw t0, -296(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -300(s0)
.Lmain_103:
	lw t0, -300(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -304(s0)
.Lmain_104:
	li t0, 1
	sw t0, -308(s0)
.Lmain_105:
	lw t0, -304(s0)
	seqz t2, t0
	sw t2, -312(s0)
.Lmain_106:
	lw t0, -312(s0)
	bne t0, x0, .Lmain_108
.Lmain_107:
	j .Lmain_126
.Lmain_108:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -316(s0)
.Lmain_109:
	la t0, chas
	lw t1, -316(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -320(s0)
.Lmain_110:
	lw t0, -320(s0)
	li t1, 37
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -324(s0)
.Lmain_111:
	lw t0, -324(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -328(s0)
.Lmain_112:
	lw t0, -328(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -332(s0)
.Lmain_113:
	li t0, 1
	sw t0, -336(s0)
.Lmain_114:
	lw t0, -332(s0)
	seqz t2, t0
	sw t2, -340(s0)
.Lmain_115:
	lw t0, -340(s0)
	bne t0, x0, .Lmain_117
.Lmain_116:
	j .Lmain_124
.Lmain_117:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -344(s0)
.Lmain_118:
	la t0, chas
	lw t1, -344(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -348(s0)
.Lmain_119:
	lw t0, -348(s0)
	li t1, 94
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -352(s0)
.Lmain_120:
	lw t0, -352(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -356(s0)
.Lmain_121:
	lw t0, -356(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -360(s0)
.Lmain_122:
	lw t0, -360(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -364(s0)
.Lmain_123:
	lw t0, -364(s0)
	sw t0, -336(s0)
.Lmain_124:
	lw t0, -336(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -368(s0)
.Lmain_125:
	lw t0, -368(s0)
	sw t0, -308(s0)
.Lmain_126:
	lw t0, -308(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -372(s0)
.Lmain_127:
	lw t0, -372(s0)
	sw t0, -280(s0)
.Lmain_128:
	lw t0, -280(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -376(s0)
.Lmain_129:
	lw t0, -376(s0)
	sw t0, -252(s0)
.Lmain_130:
	lw t0, -252(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -380(s0)
.Lmain_131:
	lw t0, -380(s0)
	sw t0, -224(s0)
.Lmain_132:
	lw t0, -224(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -384(s0)
.Lmain_133:
	lw t0, -384(s0)
	bne t0, x0, .Lmain_135
.Lmain_134:
	j .Lmain_144
.Lmain_135:
	call find
	sw a0, -388(s0)
.Lmain_136:
	lw t0, -388(s0)
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -392(s0)
.Lmain_137:
	lw t0, -392(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -396(s0)
.Lmain_138:
	lw t0, -396(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -400(s0)
.Lmain_139:
	lw t0, -400(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -404(s0)
.Lmain_140:
	lw t0, -404(s0)
	bne t0, x0, .Lmain_142
.Lmain_141:
	j .Lmain_143
.Lmain_142:
	j .Lmain_144
.Lmain_143:
	j .Lmain_72
.Lmain_144:
	li a0, 43
	call chapush
.Lmain_145:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -408(s0)
.Lmain_146:
	la t0, get
	lw t1, -408(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -412(s0)
.Lmain_147:
	lw t0, -412(s0)
	li t1, 45
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -416(s0)
.Lmain_148:
	lw t0, -416(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -420(s0)
.Lmain_149:
	lw t0, -420(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -424(s0)
.Lmain_150:
	lw t0, -424(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -428(s0)
.Lmain_151:
	lw t0, -428(s0)
	bne t0, x0, .Lmain_153
.Lmain_152:
	j .Lmain_226
.Lmain_153:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -432(s0)
.Lmain_154:
	la t0, chas
	lw t1, -432(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -436(s0)
.Lmain_155:
	lw t0, -436(s0)
	li t1, 43
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -440(s0)
.Lmain_156:
	lw t0, -440(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -444(s0)
.Lmain_157:
	lw t0, -444(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -448(s0)
.Lmain_158:
	li t0, 1
	sw t0, -452(s0)
.Lmain_159:
	lw t0, -448(s0)
	seqz t2, t0
	sw t2, -456(s0)
.Lmain_160:
	lw t0, -456(s0)
	bne t0, x0, .Lmain_162
.Lmain_161:
	j .Lmain_213
.Lmain_162:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -460(s0)
.Lmain_163:
	la t0, chas
	lw t1, -460(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -464(s0)
.Lmain_164:
	lw t0, -464(s0)
	li t1, 45
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -468(s0)
.Lmain_165:
	lw t0, -468(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -472(s0)
.Lmain_166:
	lw t0, -472(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -476(s0)
.Lmain_167:
	li t0, 1
	sw t0, -480(s0)
.Lmain_168:
	lw t0, -476(s0)
	seqz t2, t0
	sw t2, -484(s0)
.Lmain_169:
	lw t0, -484(s0)
	bne t0, x0, .Lmain_171
.Lmain_170:
	j .Lmain_211
.Lmain_171:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -488(s0)
.Lmain_172:
	la t0, chas
	lw t1, -488(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -492(s0)
.Lmain_173:
	lw t0, -492(s0)
	li t1, 42
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -496(s0)
.Lmain_174:
	lw t0, -496(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -500(s0)
.Lmain_175:
	lw t0, -500(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -504(s0)
.Lmain_176:
	li t0, 1
	sw t0, -508(s0)
.Lmain_177:
	lw t0, -504(s0)
	seqz t2, t0
	sw t2, -512(s0)
.Lmain_178:
	lw t0, -512(s0)
	bne t0, x0, .Lmain_180
.Lmain_179:
	j .Lmain_209
.Lmain_180:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -516(s0)
.Lmain_181:
	la t0, chas
	lw t1, -516(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -520(s0)
.Lmain_182:
	lw t0, -520(s0)
	li t1, 47
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -524(s0)
.Lmain_183:
	lw t0, -524(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -528(s0)
.Lmain_184:
	lw t0, -528(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -532(s0)
.Lmain_185:
	li t0, 1
	sw t0, -536(s0)
.Lmain_186:
	lw t0, -532(s0)
	seqz t2, t0
	sw t2, -540(s0)
.Lmain_187:
	lw t0, -540(s0)
	bne t0, x0, .Lmain_189
.Lmain_188:
	j .Lmain_207
.Lmain_189:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -544(s0)
.Lmain_190:
	la t0, chas
	lw t1, -544(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -548(s0)
.Lmain_191:
	lw t0, -548(s0)
	li t1, 37
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -552(s0)
.Lmain_192:
	lw t0, -552(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -556(s0)
.Lmain_193:
	lw t0, -556(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -560(s0)
.Lmain_194:
	li t0, 1
	sw t0, -564(s0)
.Lmain_195:
	lw t0, -560(s0)
	seqz t2, t0
	sw t2, -568(s0)
.Lmain_196:
	lw t0, -568(s0)
	bne t0, x0, .Lmain_198
.Lmain_197:
	j .Lmain_205
.Lmain_198:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -572(s0)
.Lmain_199:
	la t0, chas
	lw t1, -572(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -576(s0)
.Lmain_200:
	lw t0, -576(s0)
	li t1, 94
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -580(s0)
.Lmain_201:
	lw t0, -580(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -584(s0)
.Lmain_202:
	lw t0, -584(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -588(s0)
.Lmain_203:
	lw t0, -588(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -592(s0)
.Lmain_204:
	lw t0, -592(s0)
	sw t0, -564(s0)
.Lmain_205:
	lw t0, -564(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -596(s0)
.Lmain_206:
	lw t0, -596(s0)
	sw t0, -536(s0)
.Lmain_207:
	lw t0, -536(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -600(s0)
.Lmain_208:
	lw t0, -600(s0)
	sw t0, -508(s0)
.Lmain_209:
	lw t0, -508(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -604(s0)
.Lmain_210:
	lw t0, -604(s0)
	sw t0, -480(s0)
.Lmain_211:
	lw t0, -480(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -608(s0)
.Lmain_212:
	lw t0, -608(s0)
	sw t0, -452(s0)
.Lmain_213:
	lw t0, -452(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -612(s0)
.Lmain_214:
	lw t0, -612(s0)
	bne t0, x0, .Lmain_216
.Lmain_215:
	j .Lmain_225
.Lmain_216:
	call find
	sw a0, -616(s0)
.Lmain_217:
	lw t0, -616(s0)
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -620(s0)
.Lmain_218:
	lw t0, -620(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -624(s0)
.Lmain_219:
	lw t0, -624(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -628(s0)
.Lmain_220:
	lw t0, -628(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -632(s0)
.Lmain_221:
	lw t0, -632(s0)
	bne t0, x0, .Lmain_223
.Lmain_222:
	j .Lmain_224
.Lmain_223:
	j .Lmain_225
.Lmain_224:
	j .Lmain_153
.Lmain_225:
	li a0, 45
	call chapush
.Lmain_226:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -636(s0)
.Lmain_227:
	la t0, get
	lw t1, -636(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -640(s0)
.Lmain_228:
	lw t0, -640(s0)
	li t1, 42
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -644(s0)
.Lmain_229:
	lw t0, -644(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -648(s0)
.Lmain_230:
	lw t0, -648(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -652(s0)
.Lmain_231:
	lw t0, -652(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -656(s0)
.Lmain_232:
	lw t0, -656(s0)
	bne t0, x0, .Lmain_234
.Lmain_233:
	j .Lmain_285
.Lmain_234:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -660(s0)
.Lmain_235:
	la t0, chas
	lw t1, -660(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -664(s0)
.Lmain_236:
	lw t0, -664(s0)
	li t1, 42
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -668(s0)
.Lmain_237:
	lw t0, -668(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -672(s0)
.Lmain_238:
	lw t0, -672(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -676(s0)
.Lmain_239:
	li t0, 1
	sw t0, -680(s0)
.Lmain_240:
	lw t0, -676(s0)
	seqz t2, t0
	sw t2, -684(s0)
.Lmain_241:
	lw t0, -684(s0)
	bne t0, x0, .Lmain_243
.Lmain_242:
	j .Lmain_272
.Lmain_243:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -688(s0)
.Lmain_244:
	la t0, chas
	lw t1, -688(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -692(s0)
.Lmain_245:
	lw t0, -692(s0)
	li t1, 47
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -696(s0)
.Lmain_246:
	lw t0, -696(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -700(s0)
.Lmain_247:
	lw t0, -700(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -704(s0)
.Lmain_248:
	li t0, 1
	sw t0, -708(s0)
.Lmain_249:
	lw t0, -704(s0)
	seqz t2, t0
	sw t2, -712(s0)
.Lmain_250:
	lw t0, -712(s0)
	bne t0, x0, .Lmain_252
.Lmain_251:
	j .Lmain_270
.Lmain_252:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -716(s0)
.Lmain_253:
	la t0, chas
	lw t1, -716(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -720(s0)
.Lmain_254:
	lw t0, -720(s0)
	li t1, 37
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -724(s0)
.Lmain_255:
	lw t0, -724(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -728(s0)
.Lmain_256:
	lw t0, -728(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -732(s0)
.Lmain_257:
	li t0, 1
	sw t0, -736(s0)
.Lmain_258:
	lw t0, -732(s0)
	seqz t2, t0
	sw t2, -740(s0)
.Lmain_259:
	lw t0, -740(s0)
	bne t0, x0, .Lmain_261
.Lmain_260:
	j .Lmain_268
.Lmain_261:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -744(s0)
.Lmain_262:
	la t0, chas
	lw t1, -744(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -748(s0)
.Lmain_263:
	lw t0, -748(s0)
	li t1, 94
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -752(s0)
.Lmain_264:
	lw t0, -752(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -756(s0)
.Lmain_265:
	lw t0, -756(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -760(s0)
.Lmain_266:
	lw t0, -760(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -764(s0)
.Lmain_267:
	lw t0, -764(s0)
	sw t0, -736(s0)
.Lmain_268:
	lw t0, -736(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -768(s0)
.Lmain_269:
	lw t0, -768(s0)
	sw t0, -708(s0)
.Lmain_270:
	lw t0, -708(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -772(s0)
.Lmain_271:
	lw t0, -772(s0)
	sw t0, -680(s0)
.Lmain_272:
	lw t0, -680(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -776(s0)
.Lmain_273:
	lw t0, -776(s0)
	bne t0, x0, .Lmain_275
.Lmain_274:
	j .Lmain_284
.Lmain_275:
	call find
	sw a0, -780(s0)
.Lmain_276:
	lw t0, -780(s0)
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -784(s0)
.Lmain_277:
	lw t0, -784(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -788(s0)
.Lmain_278:
	lw t0, -788(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -792(s0)
.Lmain_279:
	lw t0, -792(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -796(s0)
.Lmain_280:
	lw t0, -796(s0)
	bne t0, x0, .Lmain_282
.Lmain_281:
	j .Lmain_283
.Lmain_282:
	j .Lmain_284
.Lmain_283:
	j .Lmain_234
.Lmain_284:
	li a0, 42
	call chapush
.Lmain_285:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -800(s0)
.Lmain_286:
	la t0, get
	lw t1, -800(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -804(s0)
.Lmain_287:
	lw t0, -804(s0)
	li t1, 47
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -808(s0)
.Lmain_288:
	lw t0, -808(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -812(s0)
.Lmain_289:
	lw t0, -812(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -816(s0)
.Lmain_290:
	lw t0, -816(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -820(s0)
.Lmain_291:
	lw t0, -820(s0)
	bne t0, x0, .Lmain_293
.Lmain_292:
	j .Lmain_344
.Lmain_293:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -824(s0)
.Lmain_294:
	la t0, chas
	lw t1, -824(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -828(s0)
.Lmain_295:
	lw t0, -828(s0)
	li t1, 42
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -832(s0)
.Lmain_296:
	lw t0, -832(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -836(s0)
.Lmain_297:
	lw t0, -836(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -840(s0)
.Lmain_298:
	li t0, 1
	sw t0, -844(s0)
.Lmain_299:
	lw t0, -840(s0)
	seqz t2, t0
	sw t2, -848(s0)
.Lmain_300:
	lw t0, -848(s0)
	bne t0, x0, .Lmain_302
.Lmain_301:
	j .Lmain_331
.Lmain_302:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -852(s0)
.Lmain_303:
	la t0, chas
	lw t1, -852(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -856(s0)
.Lmain_304:
	lw t0, -856(s0)
	li t1, 47
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -860(s0)
.Lmain_305:
	lw t0, -860(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -864(s0)
.Lmain_306:
	lw t0, -864(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -868(s0)
.Lmain_307:
	li t0, 1
	sw t0, -872(s0)
.Lmain_308:
	lw t0, -868(s0)
	seqz t2, t0
	sw t2, -876(s0)
.Lmain_309:
	lw t0, -876(s0)
	bne t0, x0, .Lmain_311
.Lmain_310:
	j .Lmain_329
.Lmain_311:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -880(s0)
.Lmain_312:
	la t0, chas
	lw t1, -880(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -884(s0)
.Lmain_313:
	lw t0, -884(s0)
	li t1, 37
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -888(s0)
.Lmain_314:
	lw t0, -888(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -892(s0)
.Lmain_315:
	lw t0, -892(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -896(s0)
.Lmain_316:
	li t0, 1
	sw t0, -900(s0)
.Lmain_317:
	lw t0, -896(s0)
	seqz t2, t0
	sw t2, -904(s0)
.Lmain_318:
	lw t0, -904(s0)
	bne t0, x0, .Lmain_320
.Lmain_319:
	j .Lmain_327
.Lmain_320:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -908(s0)
.Lmain_321:
	la t0, chas
	lw t1, -908(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -912(s0)
.Lmain_322:
	lw t0, -912(s0)
	li t1, 94
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -916(s0)
.Lmain_323:
	lw t0, -916(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -920(s0)
.Lmain_324:
	lw t0, -920(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -924(s0)
.Lmain_325:
	lw t0, -924(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -928(s0)
.Lmain_326:
	lw t0, -928(s0)
	sw t0, -900(s0)
.Lmain_327:
	lw t0, -900(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -932(s0)
.Lmain_328:
	lw t0, -932(s0)
	sw t0, -872(s0)
.Lmain_329:
	lw t0, -872(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -936(s0)
.Lmain_330:
	lw t0, -936(s0)
	sw t0, -844(s0)
.Lmain_331:
	lw t0, -844(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -940(s0)
.Lmain_332:
	lw t0, -940(s0)
	bne t0, x0, .Lmain_334
.Lmain_333:
	j .Lmain_343
.Lmain_334:
	call find
	sw a0, -944(s0)
.Lmain_335:
	lw t0, -944(s0)
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -948(s0)
.Lmain_336:
	lw t0, -948(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -952(s0)
.Lmain_337:
	lw t0, -952(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -956(s0)
.Lmain_338:
	lw t0, -956(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -960(s0)
.Lmain_339:
	lw t0, -960(s0)
	bne t0, x0, .Lmain_341
.Lmain_340:
	j .Lmain_342
.Lmain_341:
	j .Lmain_343
.Lmain_342:
	j .Lmain_293
.Lmain_343:
	li a0, 47
	call chapush
.Lmain_344:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -964(s0)
.Lmain_345:
	la t0, get
	lw t1, -964(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -968(s0)
.Lmain_346:
	lw t0, -968(s0)
	li t1, 37
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -972(s0)
.Lmain_347:
	lw t0, -972(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -976(s0)
.Lmain_348:
	lw t0, -976(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -980(s0)
.Lmain_349:
	lw t0, -980(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -984(s0)
.Lmain_350:
	lw t0, -984(s0)
	bne t0, x0, .Lmain_352
.Lmain_351:
	j .Lmain_403
.Lmain_352:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -988(s0)
.Lmain_353:
	la t0, chas
	lw t1, -988(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -992(s0)
.Lmain_354:
	lw t0, -992(s0)
	li t1, 42
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -996(s0)
.Lmain_355:
	lw t0, -996(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1000(s0)
.Lmain_356:
	lw t0, -1000(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1004(s0)
.Lmain_357:
	li t0, 1
	sw t0, -1008(s0)
.Lmain_358:
	lw t0, -1004(s0)
	seqz t2, t0
	sw t2, -1012(s0)
.Lmain_359:
	lw t0, -1012(s0)
	bne t0, x0, .Lmain_361
.Lmain_360:
	j .Lmain_390
.Lmain_361:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -1016(s0)
.Lmain_362:
	la t0, chas
	lw t1, -1016(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1020(s0)
.Lmain_363:
	lw t0, -1020(s0)
	li t1, 47
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1024(s0)
.Lmain_364:
	lw t0, -1024(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1028(s0)
.Lmain_365:
	lw t0, -1028(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1032(s0)
.Lmain_366:
	li t0, 1
	sw t0, -1036(s0)
.Lmain_367:
	lw t0, -1032(s0)
	seqz t2, t0
	sw t2, -1040(s0)
.Lmain_368:
	lw t0, -1040(s0)
	bne t0, x0, .Lmain_370
.Lmain_369:
	j .Lmain_388
.Lmain_370:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -1044(s0)
.Lmain_371:
	la t0, chas
	lw t1, -1044(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1048(s0)
.Lmain_372:
	lw t0, -1048(s0)
	li t1, 37
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1052(s0)
.Lmain_373:
	lw t0, -1052(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1056(s0)
.Lmain_374:
	lw t0, -1056(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1060(s0)
.Lmain_375:
	li t0, 1
	sw t0, -1064(s0)
.Lmain_376:
	lw t0, -1060(s0)
	seqz t2, t0
	sw t2, -1068(s0)
.Lmain_377:
	lw t0, -1068(s0)
	bne t0, x0, .Lmain_379
.Lmain_378:
	j .Lmain_386
.Lmain_379:
	li t0, 0
	lw t1, chat
	add t2, t0, t1
	sw t2, -1072(s0)
.Lmain_380:
	la t0, chas
	lw t1, -1072(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1076(s0)
.Lmain_381:
	lw t0, -1076(s0)
	li t1, 94
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1080(s0)
.Lmain_382:
	lw t0, -1080(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1084(s0)
.Lmain_383:
	lw t0, -1084(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1088(s0)
.Lmain_384:
	lw t0, -1088(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1092(s0)
.Lmain_385:
	lw t0, -1092(s0)
	sw t0, -1064(s0)
.Lmain_386:
	lw t0, -1064(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1096(s0)
.Lmain_387:
	lw t0, -1096(s0)
	sw t0, -1036(s0)
.Lmain_388:
	lw t0, -1036(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1100(s0)
.Lmain_389:
	lw t0, -1100(s0)
	sw t0, -1008(s0)
.Lmain_390:
	lw t0, -1008(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1104(s0)
.Lmain_391:
	lw t0, -1104(s0)
	bne t0, x0, .Lmain_393
.Lmain_392:
	j .Lmain_402
.Lmain_393:
	call find
	sw a0, -1108(s0)
.Lmain_394:
	lw t0, -1108(s0)
	li t1, 0
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1112(s0)
.Lmain_395:
	lw t0, -1112(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1116(s0)
.Lmain_396:
	lw t0, -1116(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1120(s0)
.Lmain_397:
	lw t0, -1120(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1124(s0)
.Lmain_398:
	lw t0, -1124(s0)
	bne t0, x0, .Lmain_400
.Lmain_399:
	j .Lmain_401
.Lmain_400:
	j .Lmain_402
.Lmain_401:
	j .Lmain_352
.Lmain_402:
	li a0, 37
	call chapush
.Lmain_403:
	li t0, 0
	lw t1, ii
	add t2, t0, t1
	sw t2, -1128(s0)
.Lmain_404:
	la t0, get2
	lw t1, -1128(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 32
	sw t2, 0(t0)
.Lmain_405:
	lw t0, ii
	li t1, 1
	add t2, t0, t1
	sw t2, -1132(s0)
.Lmain_406:
	lw t0, -1132(s0)
	sw t0, ii
.Lmain_407:
	j .Lmain_414
.Lmain_408:
	li t0, 0
	lw t1, ii
	add t2, t0, t1
	sw t2, -1136(s0)
.Lmain_409:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1140(s0)
.Lmain_410:
	la t0, get
	lw t1, -1140(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1144(s0)
.Lmain_411:
	la t0, get2
	lw t1, -1136(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -1144(s0)
	sw t2, 0(t0)
.Lmain_412:
	lw t0, ii
	li t1, 1
	add t2, t0, t1
	sw t2, -1148(s0)
.Lmain_413:
	lw t0, -1148(s0)
	sw t0, ii
.Lmain_414:
	lw t0, i
	li t1, 1
	add t2, t0, t1
	sw t2, -1152(s0)
.Lmain_415:
	lw t0, -1152(s0)
	sw t0, i
.Lmain_416:
	j .Lmain_6
.Lmain_417:
	lw t0, chat
	li t1, 0
	slt t2, t1, t0
	sw t2, -1156(s0)
.Lmain_418:
	lw t0, -1156(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1160(s0)
.Lmain_419:
	lw t0, -1160(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1164(s0)
.Lmain_420:
	lw t0, -1164(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1168(s0)
.Lmain_421:
	lw t0, -1168(s0)
	bne t0, x0, .Lmain_423
.Lmain_422:
	j .Lmain_433
.Lmain_423:
	call chapop
	sw a0, -1172(s0)
.Lmain_424:
	lw t0, -1172(s0)
	sw t0, -1176(s0)
.Lmain_425:
	li t0, 0
	lw t1, ii
	add t2, t0, t1
	sw t2, -1180(s0)
.Lmain_426:
	la t0, get2
	lw t1, -1180(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 32
	sw t2, 0(t0)
.Lmain_427:
	lw t0, ii
	li t1, 1
	add t2, t0, t1
	sw t2, -1184(s0)
.Lmain_428:
	li t0, 0
	lw t1, -1184(s0)
	add t2, t0, t1
	sw t2, -1188(s0)
.Lmain_429:
	la t0, get2
	lw t1, -1188(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, -1176(s0)
	sw t2, 0(t0)
.Lmain_430:
	lw t0, ii
	li t1, 2
	add t2, t0, t1
	sw t2, -1192(s0)
.Lmain_431:
	lw t0, -1192(s0)
	sw t0, ii
.Lmain_432:
	j .Lmain_417
.Lmain_433:
	li t0, 0
	lw t1, ii
	add t2, t0, t1
	sw t2, -1196(s0)
.Lmain_434:
	la t0, get2
	lw t1, -1196(s0)
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 64
	sw t2, 0(t0)
.Lmain_435:
	li t0, 1
	sw t0, i
.Lmain_436:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1200(s0)
.Lmain_437:
	la t0, get2
	lw t1, -1200(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1204(s0)
.Lmain_438:
	lw t0, -1204(s0)
	li t1, 64
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1208(s0)
.Lmain_439:
	lw t0, -1208(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1212(s0)
.Lmain_440:
	lw t0, -1212(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1216(s0)
.Lmain_441:
	lw t0, -1216(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1220(s0)
.Lmain_442:
	lw t0, -1220(s0)
	bne t0, x0, .Lmain_444
.Lmain_443:
	j .Lmain_608
.Lmain_444:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1224(s0)
.Lmain_445:
	la t0, get2
	lw t1, -1224(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1228(s0)
.Lmain_446:
	lw t0, -1228(s0)
	li t1, 43
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1232(s0)
.Lmain_447:
	lw t0, -1232(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1236(s0)
.Lmain_448:
	lw t0, -1236(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1240(s0)
.Lmain_449:
	li t0, 1
	sw t0, -1244(s0)
.Lmain_450:
	lw t0, -1240(s0)
	seqz t2, t0
	sw t2, -1248(s0)
.Lmain_451:
	lw t0, -1248(s0)
	bne t0, x0, .Lmain_453
.Lmain_452:
	j .Lmain_504
.Lmain_453:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1252(s0)
.Lmain_454:
	la t0, get2
	lw t1, -1252(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1256(s0)
.Lmain_455:
	lw t0, -1256(s0)
	li t1, 45
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1260(s0)
.Lmain_456:
	lw t0, -1260(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1264(s0)
.Lmain_457:
	lw t0, -1264(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1268(s0)
.Lmain_458:
	li t0, 1
	sw t0, -1272(s0)
.Lmain_459:
	lw t0, -1268(s0)
	seqz t2, t0
	sw t2, -1276(s0)
.Lmain_460:
	lw t0, -1276(s0)
	bne t0, x0, .Lmain_462
.Lmain_461:
	j .Lmain_502
.Lmain_462:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1280(s0)
.Lmain_463:
	la t0, get2
	lw t1, -1280(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1284(s0)
.Lmain_464:
	lw t0, -1284(s0)
	li t1, 42
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1288(s0)
.Lmain_465:
	lw t0, -1288(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1292(s0)
.Lmain_466:
	lw t0, -1292(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1296(s0)
.Lmain_467:
	li t0, 1
	sw t0, -1300(s0)
.Lmain_468:
	lw t0, -1296(s0)
	seqz t2, t0
	sw t2, -1304(s0)
.Lmain_469:
	lw t0, -1304(s0)
	bne t0, x0, .Lmain_471
.Lmain_470:
	j .Lmain_500
.Lmain_471:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1308(s0)
.Lmain_472:
	la t0, get2
	lw t1, -1308(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1312(s0)
.Lmain_473:
	lw t0, -1312(s0)
	li t1, 47
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1316(s0)
.Lmain_474:
	lw t0, -1316(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1320(s0)
.Lmain_475:
	lw t0, -1320(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1324(s0)
.Lmain_476:
	li t0, 1
	sw t0, -1328(s0)
.Lmain_477:
	lw t0, -1324(s0)
	seqz t2, t0
	sw t2, -1332(s0)
.Lmain_478:
	lw t0, -1332(s0)
	bne t0, x0, .Lmain_480
.Lmain_479:
	j .Lmain_498
.Lmain_480:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1336(s0)
.Lmain_481:
	la t0, get2
	lw t1, -1336(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1340(s0)
.Lmain_482:
	lw t0, -1340(s0)
	li t1, 37
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1344(s0)
.Lmain_483:
	lw t0, -1344(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1348(s0)
.Lmain_484:
	lw t0, -1348(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1352(s0)
.Lmain_485:
	li t0, 1
	sw t0, -1356(s0)
.Lmain_486:
	lw t0, -1352(s0)
	seqz t2, t0
	sw t2, -1360(s0)
.Lmain_487:
	lw t0, -1360(s0)
	bne t0, x0, .Lmain_489
.Lmain_488:
	j .Lmain_496
.Lmain_489:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1364(s0)
.Lmain_490:
	la t0, get2
	lw t1, -1364(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1368(s0)
.Lmain_491:
	lw t0, -1368(s0)
	li t1, 94
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1372(s0)
.Lmain_492:
	lw t0, -1372(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1376(s0)
.Lmain_493:
	lw t0, -1376(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1380(s0)
.Lmain_494:
	lw t0, -1380(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1384(s0)
.Lmain_495:
	lw t0, -1384(s0)
	sw t0, -1356(s0)
.Lmain_496:
	lw t0, -1356(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1388(s0)
.Lmain_497:
	lw t0, -1388(s0)
	sw t0, -1328(s0)
.Lmain_498:
	lw t0, -1328(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1392(s0)
.Lmain_499:
	lw t0, -1392(s0)
	sw t0, -1300(s0)
.Lmain_500:
	lw t0, -1300(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1396(s0)
.Lmain_501:
	lw t0, -1396(s0)
	sw t0, -1272(s0)
.Lmain_502:
	lw t0, -1272(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1400(s0)
.Lmain_503:
	lw t0, -1400(s0)
	sw t0, -1244(s0)
.Lmain_504:
	lw t0, -1244(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1404(s0)
.Lmain_505:
	lw t0, -1404(s0)
	bne t0, x0, .Lmain_540
.Lmain_506:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1408(s0)
.Lmain_507:
	la t0, get2
	lw t1, -1408(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1412(s0)
.Lmain_508:
	lw t0, -1412(s0)
	li t1, 32
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1416(s0)
.Lmain_509:
	lw t0, -1416(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1420(s0)
.Lmain_510:
	lw t0, -1420(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1424(s0)
.Lmain_511:
	lw t0, -1424(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1428(s0)
.Lmain_512:
	lw t0, -1428(s0)
	bne t0, x0, .Lmain_514
.Lmain_513:
	j .Lmain_539
.Lmain_514:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1432(s0)
.Lmain_515:
	la t0, get2
	lw t1, -1432(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1436(s0)
.Lmain_516:
	lw t0, -1436(s0)
	li t1, 48
	sub t2, t0, t1
	sw t2, -1440(s0)
.Lmain_517:
	lw a0, -1440(s0)
	call intpush
.Lmain_518:
	li t0, 1
	sw t0, ii
.Lmain_519:
	lw t0, i
	lw t1, ii
	add t2, t0, t1
	sw t2, -1444(s0)
.Lmain_520:
	li t0, 0
	lw t1, -1444(s0)
	add t2, t0, t1
	sw t2, -1448(s0)
.Lmain_521:
	la t0, get2
	lw t1, -1448(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1452(s0)
.Lmain_522:
	lw t0, -1452(s0)
	li t1, 32
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1456(s0)
.Lmain_523:
	lw t0, -1456(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1460(s0)
.Lmain_524:
	lw t0, -1460(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1464(s0)
.Lmain_525:
	lw t0, -1464(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1468(s0)
.Lmain_526:
	lw t0, -1468(s0)
	bne t0, x0, .Lmain_528
.Lmain_527:
	j .Lmain_536
.Lmain_528:
	lw t0, i
	lw t1, ii
	add t2, t0, t1
	sw t2, -1472(s0)
.Lmain_529:
	li t0, 0
	lw t1, -1472(s0)
	add t2, t0, t1
	sw t2, -1476(s0)
.Lmain_530:
	la t0, get2
	lw t1, -1476(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1480(s0)
.Lmain_531:
	lw t0, -1480(s0)
	li t1, 48
	sub t2, t0, t1
	sw t2, -1484(s0)
.Lmain_532:
	lw a0, -1484(s0)
	call intadd
.Lmain_533:
	lw t0, ii
	li t1, 1
	add t2, t0, t1
	sw t2, -1488(s0)
.Lmain_534:
	lw t0, -1488(s0)
	sw t0, ii
.Lmain_535:
	j .Lmain_519
.Lmain_536:
	lw t0, i
	lw t1, ii
	add t2, t0, t1
	sw t2, -1492(s0)
.Lmain_537:
	lw t0, -1492(s0)
	li t1, 1
	sub t2, t0, t1
	sw t2, -1496(s0)
.Lmain_538:
	lw t0, -1496(s0)
	sw t0, i
.Lmain_539:
	j .Lmain_605
.Lmain_540:
	call intpop
	sw a0, -1500(s0)
.Lmain_541:
	lw t0, -1500(s0)
	sw t0, -1504(s0)
.Lmain_542:
	call intpop
	sw a0, -1508(s0)
.Lmain_543:
	lw t0, -1508(s0)
	sw t0, -1512(s0)
.Lmain_544:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1516(s0)
.Lmain_545:
	la t0, get2
	lw t1, -1516(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1520(s0)
.Lmain_546:
	lw t0, -1520(s0)
	li t1, 43
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1524(s0)
.Lmain_547:
	lw t0, -1524(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1528(s0)
.Lmain_548:
	lw t0, -1528(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1532(s0)
.Lmain_549:
	lw t0, -1532(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1536(s0)
.Lmain_550:
	lw t0, -1536(s0)
	bne t0, x0, .Lmain_552
.Lmain_551:
	j .Lmain_554
.Lmain_552:
	lw t0, -1504(s0)
	lw t1, -1512(s0)
	add t2, t0, t1
	sw t2, -1540(s0)
.Lmain_553:
	lw t0, -1540(s0)
	sw t0, -1544(s0)
.Lmain_554:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1548(s0)
.Lmain_555:
	la t0, get2
	lw t1, -1548(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1552(s0)
.Lmain_556:
	lw t0, -1552(s0)
	li t1, 45
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1556(s0)
.Lmain_557:
	lw t0, -1556(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1560(s0)
.Lmain_558:
	lw t0, -1560(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1564(s0)
.Lmain_559:
	lw t0, -1564(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1568(s0)
.Lmain_560:
	lw t0, -1568(s0)
	bne t0, x0, .Lmain_562
.Lmain_561:
	j .Lmain_564
.Lmain_562:
	lw t0, -1512(s0)
	lw t1, -1504(s0)
	sub t2, t0, t1
	sw t2, -1572(s0)
.Lmain_563:
	lw t0, -1572(s0)
	sw t0, -1544(s0)
.Lmain_564:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1576(s0)
.Lmain_565:
	la t0, get2
	lw t1, -1576(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1580(s0)
.Lmain_566:
	lw t0, -1580(s0)
	li t1, 42
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1584(s0)
.Lmain_567:
	lw t0, -1584(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1588(s0)
.Lmain_568:
	lw t0, -1588(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1592(s0)
.Lmain_569:
	lw t0, -1592(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1596(s0)
.Lmain_570:
	lw t0, -1596(s0)
	bne t0, x0, .Lmain_572
.Lmain_571:
	j .Lmain_574
.Lmain_572:
	lw t0, -1504(s0)
	lw t1, -1512(s0)
	mul t2, t0, t1
	sw t2, -1600(s0)
.Lmain_573:
	lw t0, -1600(s0)
	sw t0, -1544(s0)
.Lmain_574:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1604(s0)
.Lmain_575:
	la t0, get2
	lw t1, -1604(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1608(s0)
.Lmain_576:
	lw t0, -1608(s0)
	li t1, 47
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1612(s0)
.Lmain_577:
	lw t0, -1612(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1616(s0)
.Lmain_578:
	lw t0, -1616(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1620(s0)
.Lmain_579:
	lw t0, -1620(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1624(s0)
.Lmain_580:
	lw t0, -1624(s0)
	bne t0, x0, .Lmain_582
.Lmain_581:
	j .Lmain_584
.Lmain_582:
	lw t0, -1512(s0)
	lw t1, -1504(s0)
	div t2, t0, t1
	sw t2, -1628(s0)
.Lmain_583:
	lw t0, -1628(s0)
	sw t0, -1544(s0)
.Lmain_584:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1632(s0)
.Lmain_585:
	la t0, get2
	lw t1, -1632(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1636(s0)
.Lmain_586:
	lw t0, -1636(s0)
	li t1, 37
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1640(s0)
.Lmain_587:
	lw t0, -1640(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1644(s0)
.Lmain_588:
	lw t0, -1644(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1648(s0)
.Lmain_589:
	lw t0, -1648(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1652(s0)
.Lmain_590:
	lw t0, -1652(s0)
	bne t0, x0, .Lmain_592
.Lmain_591:
	j .Lmain_594
.Lmain_592:
	lw t0, -1512(s0)
	lw t1, -1504(s0)
	rem t2, t0, t1
	sw t2, -1656(s0)
.Lmain_593:
	lw t0, -1656(s0)
	sw t0, -1544(s0)
.Lmain_594:
	li t0, 0
	lw t1, i
	add t2, t0, t1
	sw t2, -1660(s0)
.Lmain_595:
	la t0, get2
	lw t1, -1660(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1664(s0)
.Lmain_596:
	lw t0, -1664(s0)
	li t1, 94
	xor t2, t0, t1
	seqz t2, t2
	sw t2, -1668(s0)
.Lmain_597:
	lw t0, -1668(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1672(s0)
.Lmain_598:
	lw t0, -1672(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1676(s0)
.Lmain_599:
	lw t0, -1676(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -1680(s0)
.Lmain_600:
	lw t0, -1680(s0)
	bne t0, x0, .Lmain_602
.Lmain_601:
	j .Lmain_604
.Lmain_602:
	lw a0, -1512(s0)
	lw a1, -1504(s0)
	call power
	sw a0, -1684(s0)
.Lmain_603:
	lw t0, -1684(s0)
	sw t0, -1544(s0)
.Lmain_604:
	lw a0, -1544(s0)
	call intpush
.Lmain_605:
	lw t0, i
	li t1, 1
	add t2, t0, t1
	sw t2, -1688(s0)
.Lmain_606:
	lw t0, -1688(s0)
	sw t0, i
.Lmain_607:
	j .Lmain_436
.Lmain_608:
	li t0, 0
	li t1, 1
	add t2, t0, t1
	sw t2, -1692(s0)
.Lmain_609:
	la t0, ints
	lw t1, -1692(s0)
	slli t1, t1, 2
	add t0, t0, t1
	lw t2, 0(t0)
	sw t2, -1696(s0)
.Lmain_610:
	lw a0, -1696(s0)
	call putint
.Lmain_611:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 1692(sp)
	lw s0, 1688(sp)
	addi sp, sp, 1696
	jr ra
.globl __global_init
__global_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.L__global_init_0:
	li t0, 0
	sw t0, i
.L__global_init_1:
	li t0, 1
	sw t0, ii
.L__global_init_2:
	j .L__global_init_epilogue
.L__global_init_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
