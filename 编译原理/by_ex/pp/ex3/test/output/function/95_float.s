.text
.globl float_abs
float_abs:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
	fsw fa0, -12(s0)
.Lfloat_abs_0:
	flw ft0, -12(s0)
	li t0, 0
	fmv.w.x ft1, t0
	flt.s t2, ft0, ft1
	sw t2, -16(s0)
.Lfloat_abs_1:
	flw ft0, -16(s0)
	fcvt.w.s t0, ft0
	sw t0, -20(s0)
.Lfloat_abs_2:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lfloat_abs_3:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lfloat_abs_4:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lfloat_abs_5:
	lw t0, -32(s0)
	bne t0, x0, .Lfloat_abs_7
.Lfloat_abs_6:
	j .Lfloat_abs_9
.Lfloat_abs_7:
	li t0, 0
	fmv.w.x ft0, t0
	flw ft1, -12(s0)
	fsub.s ft2, ft0, ft1
	fsw ft2, -36(s0)
.Lfloat_abs_8:
	flw fa0, -36(s0)
	j .Lfloat_abs_epilogue
.Lfloat_abs_9:
	flw fa0, -12(s0)
	j .Lfloat_abs_epilogue
.Lfloat_abs_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
.globl circle_area
circle_area:
	addi sp, sp, -48
	sw ra, 44(sp)
	sw s0, 40(sp)
	addi s0, sp, 48
	sw a0, -12(s0)
.Lcircle_area_0:
	lw t0, -12(s0)
	fcvt.s.w ft0, t0
	fsw ft0, -16(s0)
.Lcircle_area_1:
	li t0, 1078530011
	fmv.w.x ft0, t0
	flw ft1, -16(s0)
	fmul.s ft2, ft0, ft1
	fsw ft2, -20(s0)
.Lcircle_area_2:
	lw t0, -12(s0)
	fcvt.s.w ft0, t0
	fsw ft0, -24(s0)
.Lcircle_area_3:
	flw ft0, -20(s0)
	flw ft1, -24(s0)
	fmul.s ft2, ft0, ft1
	fsw ft2, -28(s0)
.Lcircle_area_4:
	lw t0, -12(s0)
	lw t1, -12(s0)
	mul t2, t0, t1
	sw t2, -32(s0)
.Lcircle_area_5:
	lw t0, -32(s0)
	fcvt.s.w ft0, t0
	fsw ft0, -36(s0)
.Lcircle_area_6:
	flw ft0, -36(s0)
	li t0, 1078530011
	fmv.w.x ft1, t0
	fmul.s ft2, ft0, ft1
	fsw ft2, -40(s0)
.Lcircle_area_7:
	flw ft0, -28(s0)
	flw ft1, -40(s0)
	fadd.s ft2, ft0, ft1
	fsw ft2, -44(s0)
.Lcircle_area_8:
	flw ft0, -44(s0)
	li t0, 1073741824
	fmv.w.x ft1, t0
	fdiv.s ft2, ft0, ft1
	fsw ft2, -48(s0)
.Lcircle_area_9:
	flw fa0, -48(s0)
	j .Lcircle_area_epilogue
.Lcircle_area_epilogue:
	lw ra, 44(sp)
	lw s0, 40(sp)
	addi sp, sp, 48
	jr ra
.globl float_eq
float_eq:
	addi sp, sp, -64
	sw ra, 60(sp)
	sw s0, 56(sp)
	addi s0, sp, 64
	fsw fa0, -12(s0)
	fsw fa1, -16(s0)
.Lfloat_eq_0:
	flw ft0, -12(s0)
	flw ft1, -16(s0)
	fsub.s ft2, ft0, ft1
	fsw ft2, -20(s0)
.Lfloat_eq_1:
	flw fa0, -20(s0)
	call float_abs
	fsw fa0, -24(s0)
.Lfloat_eq_2:
	flw ft0, -24(s0)
	li t0, 897988541
	fmv.w.x ft1, t0
	flt.s t2, ft0, ft1
	sw t2, -28(s0)
.Lfloat_eq_3:
	flw ft0, -28(s0)
	fcvt.w.s t0, ft0
	sw t0, -32(s0)
.Lfloat_eq_4:
	lw t0, -32(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -36(s0)
.Lfloat_eq_5:
	lw t0, -36(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -40(s0)
.Lfloat_eq_6:
	lw t0, -40(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -44(s0)
.Lfloat_eq_7:
	lw t0, -44(s0)
	bne t0, x0, .Lfloat_eq_10
.Lfloat_eq_8:
	li a0, 0
	j .Lfloat_eq_epilogue
.Lfloat_eq_9:
	j .Lfloat_eq_epilogue
.Lfloat_eq_10:
	li t0, 1065353216
	fmv.w.x ft0, t0
	li t0, 1073741824
	fmv.w.x ft1, t0
	fmul.s ft2, ft0, ft1
	fsw ft2, -48(s0)
.Lfloat_eq_11:
	flw ft0, -48(s0)
	li t0, 1073741824
	fmv.w.x ft1, t0
	fdiv.s ft2, ft0, ft1
	fsw ft2, -52(s0)
.Lfloat_eq_12:
	flw ft0, -52(s0)
	fcvt.w.s t0, ft0
	sw t0, -56(s0)
.Lfloat_eq_13:
	lw a0, -56(s0)
	j .Lfloat_eq_epilogue
.Lfloat_eq_epilogue:
	lw ra, 60(sp)
	lw s0, 56(sp)
	addi sp, sp, 64
	jr ra
.globl error
error:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lerror_0:
	li a0, 101
	call putch
.Lerror_1:
	li a0, 114
	call putch
.Lerror_2:
	li a0, 114
	call putch
.Lerror_3:
	li a0, 111
	call putch
.Lerror_4:
	li a0, 114
	call putch
.Lerror_5:
	li a0, 10
	call putch
.Lerror_6:
	j .Lerror_epilogue
.Lerror_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl ok
ok:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	addi s0, sp, 16
.Lok_0:
	li a0, 111
	call putch
.Lok_1:
	li a0, 107
	call putch
.Lok_2:
	li a0, 10
	call putch
.Lok_3:
	j .Lok_epilogue
.Lok_epilogue:
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	jr ra
.globl assert
assert:
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	addi s0, sp, 32
	sw a0, -12(s0)
.Lassert_0:
	lw t0, -12(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -16(s0)
.Lassert_1:
	lw t0, -16(s0)
	seqz t2, t0
	sw t2, -20(s0)
.Lassert_2:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lassert_3:
	lw t0, -24(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -28(s0)
.Lassert_4:
	lw t0, -28(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -32(s0)
.Lassert_5:
	lw t0, -32(s0)
	bne t0, x0, .Lassert_8
.Lassert_6:
	call ok
.Lassert_7:
	j .Lassert_9
.Lassert_8:
	call error
.Lassert_9:
	j .Lassert_epilogue
.Lassert_epilogue:
	lw ra, 28(sp)
	lw s0, 24(sp)
	addi sp, sp, 32
	jr ra
.globl assert_not
assert_not:
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	addi s0, sp, 32
	sw a0, -12(s0)
.Lassert_not_0:
	lw t0, -12(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -16(s0)
.Lassert_not_1:
	lw t0, -16(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -20(s0)
.Lassert_not_2:
	lw t0, -20(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -24(s0)
.Lassert_not_3:
	lw t0, -24(s0)
	bne t0, x0, .Lassert_not_6
.Lassert_not_4:
	call ok
.Lassert_not_5:
	j .Lassert_not_7
.Lassert_not_6:
	call error
.Lassert_not_7:
	j .Lassert_not_epilogue
.Lassert_not_epilogue:
	lw ra, 28(sp)
	lw s0, 24(sp)
	addi sp, sp, 32
	jr ra
.globl main
main:
	addi sp, sp, -288
	sw ra, 284(sp)
	sw s0, 280(sp)
	addi s0, sp, 288
.Lmain_0:
	li t0, 2
	li t1, 16
	mul t2, t0, t1
	sw t2, -12(s0)
.Lmain_1:
	lw t0, -12(s0)
	li t1, 32
	add t2, t0, t1
	sw t2, -16(s0)
.Lmain_2:
	lw t0, -16(s0)
	li t1, 64
	sub t2, t0, t1
	sw t2, -20(s0)
.Lmain_3:
	lw t0, -20(s0)
	fcvt.s.w ft0, t0
	fsw ft0, -24(s0)
.Lmain_4:
	flw ft0, -24(s0)
	li t0, 1036831949
	fmv.w.x ft1, t0
	fsub.s ft2, ft0, ft1
	fsw ft2, -28(s0)
.Lmain_5:
	flw ft0, -28(s0)
	fsw ft0, -32(s0)
.Lmain_6:
	li t0, 1033895936
	fmv.w.x fa0, t0
	li t0, 3338725376
	fmv.w.x fa1, t0
	call float_eq
	sw a0, -36(s0)
.Lmain_7:
	lw a0, -36(s0)
	call assert_not
.Lmain_8:
	li t0, 1119752446
	fmv.w.x fa0, t0
	li t0, 1107966695
	fmv.w.x fa1, t0
	call float_eq
	sw a0, -40(s0)
.Lmain_9:
	lw a0, -40(s0)
	call assert_not
.Lmain_10:
	li t0, 1107966695
	fmv.w.x fa0, t0
	li t0, 1107966695
	fmv.w.x fa1, t0
	call float_eq
	sw a0, -44(s0)
.Lmain_11:
	lw a0, -44(s0)
	call assert
.Lmain_12:
	li a0, 5
	call circle_area
	fsw fa0, -48(s0)
.Lmain_13:
	li a0, 5
	call circle_area
	fsw fa0, -52(s0)
.Lmain_14:
	flw fa0, -48(s0)
	flw fa1, -52(s0)
	call float_eq
	sw a0, -56(s0)
.Lmain_15:
	lw a0, -56(s0)
	call assert
.Lmain_16:
	li t0, 1130954752
	fmv.w.x fa0, t0
	li t0, 1166012416
	fmv.w.x fa1, t0
	call float_eq
	sw a0, -60(s0)
.Lmain_17:
	lw a0, -60(s0)
	call assert_not
.Lmain_18:
	li t0, 1
	bne t0, x0, .Lmain_20
.Lmain_19:
	j .Lmain_21
.Lmain_20:
	call ok
.Lmain_21:
	li t0, 1
	seqz t2, t0
	sw t2, -64(s0)
.Lmain_22:
	lw t0, -64(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -68(s0)
.Lmain_23:
	lw t0, -68(s0)
	seqz t2, t0
	sw t2, -72(s0)
.Lmain_24:
	lw t0, -72(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -76(s0)
.Lmain_25:
	lw t0, -76(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -80(s0)
.Lmain_26:
	lw t0, -80(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -84(s0)
.Lmain_27:
	lw t0, -84(s0)
	bne t0, x0, .Lmain_29
.Lmain_28:
	j .Lmain_30
.Lmain_29:
	call ok
.Lmain_30:
	li t0, 0
	sw t0, -88(s0)
.Lmain_31:
	li t0, 0
	bne t0, x0, .Lmain_33
.Lmain_32:
	j .Lmain_38
.Lmain_33:
	li t0, 1077936128
	fmv.w.x ft0, t0
	li t0, 1053609165
	fmv.w.x ft1, t0
	feq.s t2, ft0, ft1
	sw t2, -92(s0)
.Lmain_34:
	flw ft0, -92(s0)
	fcvt.w.s t0, ft0
	sw t0, -96(s0)
.Lmain_35:
	lw t0, -96(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -100(s0)
.Lmain_36:
	lw t0, -100(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -104(s0)
.Lmain_37:
	lw t0, -104(s0)
	sw t0, -88(s0)
.Lmain_38:
	lw t0, -88(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -108(s0)
.Lmain_39:
	lw t0, -108(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -112(s0)
.Lmain_40:
	lw t0, -112(s0)
	bne t0, x0, .Lmain_42
.Lmain_41:
	j .Lmain_43
.Lmain_42:
	call error
.Lmain_43:
	li t0, 1
	sw t0, -116(s0)
.Lmain_44:
	li t0, 0
	seqz t2, t0
	sw t2, -120(s0)
.Lmain_45:
	lw t0, -120(s0)
	bne t0, x0, .Lmain_47
.Lmain_46:
	j .Lmain_48
.Lmain_47:
	li t0, 1
	sw t0, -116(s0)
.Lmain_48:
	lw t0, -116(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -124(s0)
.Lmain_49:
	lw t0, -124(s0)
	bne t0, x0, .Lmain_51
.Lmain_50:
	j .Lmain_52
.Lmain_51:
	call ok
.Lmain_52:
	li t0, 1
	sw t0, -128(s0)
.Lmain_53:
	li t0, 0
	sw t0, -132(s0)
.Lmain_54:
	addi t0, s0, -176
	sw t0, -136(s0)
.Lmain_55:
	lw t0, -136(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1065353216
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_56:
	lw t0, -136(s0)
	li t1, 1
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 1073741824
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_57:
	lw t0, -136(s0)
	li t1, 2
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_58:
	lw t0, -136(s0)
	li t1, 3
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_59:
	lw t0, -136(s0)
	li t1, 4
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_60:
	lw t0, -136(s0)
	li t1, 5
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_61:
	lw t0, -136(s0)
	li t1, 6
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_62:
	lw t0, -136(s0)
	li t1, 7
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_63:
	lw t0, -136(s0)
	li t1, 8
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_64:
	lw t0, -136(s0)
	li t1, 9
	slli t1, t1, 2
	add t0, t0, t1
	li t2, 0
	fmv.w.x ft0, t2
	fsw ft0, 0(t0)
.Lmain_65:
	lw t0, -136(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	sw t0, -180(s0)
.Lmain_66:
	lw a0, -180(s0)
	call getfarray
	sw a0, -184(s0)
.Lmain_67:
	lw t0, -184(s0)
	sw t0, -188(s0)
.Lmain_68:
	lw t0, -128(s0)
	li t1, 1000000000
	slt t2, t0, t1
	sw t2, -192(s0)
.Lmain_69:
	lw t0, -192(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -196(s0)
.Lmain_70:
	lw t0, -196(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -200(s0)
.Lmain_71:
	lw t0, -200(s0)
	li t1, 0
	xor t2, t0, t1
	snez t2, t2
	sw t2, -204(s0)
.Lmain_72:
	lw t0, -204(s0)
	bne t0, x0, .Lmain_74
.Lmain_73:
	j .Lmain_99
.Lmain_74:
	call getfloat
	fsw fa0, -208(s0)
.Lmain_75:
	flw ft0, -208(s0)
	fsw ft0, -212(s0)
.Lmain_76:
	li t0, 1078530011
	fmv.w.x ft0, t0
	flw ft1, -212(s0)
	fmul.s ft2, ft0, ft1
	fsw ft2, -216(s0)
.Lmain_77:
	flw ft0, -216(s0)
	flw ft1, -212(s0)
	fmul.s ft2, ft0, ft1
	fsw ft2, -220(s0)
.Lmain_78:
	flw ft0, -220(s0)
	fsw ft0, -224(s0)
.Lmain_79:
	flw ft0, -212(s0)
	fcvt.w.s t0, ft0
	sw t0, -228(s0)
.Lmain_80:
	lw a0, -228(s0)
	call circle_area
	fsw fa0, -232(s0)
.Lmain_81:
	flw ft0, -232(s0)
	fsw ft0, -236(s0)
.Lmain_82:
	li t0, 0
	lw t1, -132(s0)
	add t2, t0, t1
	sw t2, -240(s0)
.Lmain_83:
	li t0, 0
	lw t1, -132(s0)
	add t2, t0, t1
	sw t2, -244(s0)
.Lmain_84:
	lw t0, -136(s0)
	lw t1, -244(s0)
	slli t1, t1, 2
	add t0, t0, t1
	flw ft0, 0(t0)
	fsw ft0, -248(s0)
.Lmain_85:
	flw ft0, -248(s0)
	flw ft1, -212(s0)
	fadd.s ft2, ft0, ft1
	fsw ft2, -252(s0)
.Lmain_86:
	lw t0, -136(s0)
	lw t1, -240(s0)
	slli t1, t1, 2
	add t0, t0, t1
	flw ft0, -252(s0)
	fsw ft0, 0(t0)
.Lmain_87:
	flw fa0, -224(s0)
	call putfloat
.Lmain_88:
	li a0, 32
	call putch
.Lmain_89:
	flw ft0, -236(s0)
	fcvt.w.s t0, ft0
	sw t0, -256(s0)
.Lmain_90:
	lw a0, -256(s0)
	call putint
.Lmain_91:
	li a0, 10
	call putch
.Lmain_92:
	li t0, 0
	li t1, 10
	sub t2, t0, t1
	sw t2, -260(s0)
.Lmain_93:
	li t0, 0
	lw t1, -260(s0)
	sub t2, t0, t1
	sw t2, -264(s0)
.Lmain_94:
	lw t0, -128(s0)
	lw t1, -264(s0)
	mul t2, t0, t1
	sw t2, -268(s0)
.Lmain_95:
	lw t0, -268(s0)
	sw t0, -128(s0)
.Lmain_96:
	lw t0, -132(s0)
	li t1, 1
	add t2, t0, t1
	sw t2, -272(s0)
.Lmain_97:
	lw t0, -272(s0)
	sw t0, -132(s0)
.Lmain_98:
	j .Lmain_68
.Lmain_99:
	lw t0, -136(s0)
	li t1, 0
	slli t1, t1, 2
	add t0, t0, t1
	sw t0, -276(s0)
.Lmain_100:
	lw a0, -188(s0)
	lw a1, -276(s0)
	call putfarray
.Lmain_101:
	li a0, 0
	j .Lmain_epilogue
.Lmain_epilogue:
	lw ra, 284(sp)
	lw s0, 280(sp)
	addi sp, sp, 288
	jr ra
