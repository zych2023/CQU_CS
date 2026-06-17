	.text
	.file	"loop_fusion_test.c"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	stp	x29, x30, [sp, #112]            // 16-byte Folded Spill
	add	x29, sp, #112
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x1, #13824                      // =0x3600
	movk	x1, #366, lsl #16
	str	x1, [sp, #8]                    // 8-byte Folded Spill
	mov	w8, #36224                      // =0x8d80
	movk	w8, #91, lsl #16
	str	w8, [sp, #4]                    // 4-byte Folded Spill
	stur	wzr, [x29, #-4]
	mov	x0, #64                         // =0x40
	str	x0, [sp, #16]                   // 8-byte Folded Spill
	bl	aligned_alloc
	ldr	x1, [sp, #8]                    // 8-byte Folded Reload
	mov	x8, x0
	ldr	x0, [sp, #16]                   // 8-byte Folded Reload
	stur	x8, [x29, #-16]
	bl	aligned_alloc
	ldr	x1, [sp, #8]                    // 8-byte Folded Reload
	mov	x8, x0
	ldr	x0, [sp, #16]                   // 8-byte Folded Reload
	stur	x8, [x29, #-24]
	bl	aligned_alloc
	ldr	x1, [sp, #8]                    // 8-byte Folded Reload
	mov	x8, x0
	ldr	x0, [sp, #16]                   // 8-byte Folded Reload
	stur	x8, [x29, #-32]
	bl	aligned_alloc
	stur	x0, [x29, #-40]
	ldur	x8, [x29, #-16]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, .LBB0_4
	b	.LBB0_1
.LBB0_1:
	ldur	x8, [x29, #-24]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, .LBB0_4
	b	.LBB0_2
.LBB0_2:
	ldur	x8, [x29, #-32]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, .LBB0_4
	b	.LBB0_3
.LBB0_3:
	ldur	x8, [x29, #-40]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, .LBB0_5
	b	.LBB0_4
.LBB0_4:
	adrp	x8, :got:stderr
	ldr	x8, [x8, :got_lo12:stderr]
	ldr	x0, [x8]
	adrp	x1, .L.str
	add	x1, x1, :lo12:.L.str
	bl	fprintf
	mov	w8, #1                          // =0x1
	stur	w8, [x29, #-4]
	b	.LBB0_26
.LBB0_5:
	stur	wzr, [x29, #-44]
	b	.LBB0_6
.LBB0_6:                                // =>This Inner Loop Header: Depth=1
	ldr	w9, [sp, #4]                    // 4-byte Folded Reload
	ldur	w8, [x29, #-44]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB0_9
	b	.LBB0_7
.LBB0_7:                                //   in Loop: Header=BB0_6 Depth=1
	ldr	w8, [sp, #4]                    // 4-byte Folded Reload
	ldur	s0, [x29, #-44]
	scvtf	s0, s0
	ldur	x9, [x29, #-16]
	ldursw	x10, [x29, #-44]
	str	s0, [x9, x10, lsl #2]
	ldur	w9, [x29, #-44]
	subs	w8, w8, w9
	scvtf	s0, w8
	ldur	x8, [x29, #-24]
	ldursw	x9, [x29, #-44]
	str	s0, [x8, x9, lsl #2]
	b	.LBB0_8
.LBB0_8:                                //   in Loop: Header=BB0_6 Depth=1
	ldur	w8, [x29, #-44]
	add	w8, w8, #1
	stur	w8, [x29, #-44]
	b	.LBB0_6
.LBB0_9:
	bl	now_sec
	str	d0, [sp, #56]
	str	wzr, [sp, #52]
	b	.LBB0_10
.LBB0_10:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_12 Depth 2
                                        //     Child Loop BB0_16 Depth 2
	ldr	w8, [sp, #52]
	subs	w8, w8, #3
	cset	w8, ge
	tbnz	w8, #0, .LBB0_21
	b	.LBB0_11
.LBB0_11:                               //   in Loop: Header=BB0_10 Depth=1
	str	wzr, [sp, #48]
	b	.LBB0_12
.LBB0_12:                               //   Parent Loop BB0_10 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldr	w9, [sp, #4]                    // 4-byte Folded Reload
	ldr	w8, [sp, #48]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB0_15
	b	.LBB0_13
.LBB0_13:                               //   in Loop: Header=BB0_12 Depth=2
	ldur	x8, [x29, #-16]
	ldrsw	x9, [sp, #48]
	ldr	s0, [x8, x9, lsl #2]
	ldur	x8, [x29, #-24]
	ldrsw	x9, [sp, #48]
	ldr	s1, [x8, x9, lsl #2]
	fadd	s0, s0, s1
	ldur	x8, [x29, #-32]
	ldrsw	x9, [sp, #48]
	str	s0, [x8, x9, lsl #2]
	b	.LBB0_14
.LBB0_14:                               //   in Loop: Header=BB0_12 Depth=2
	ldr	w8, [sp, #48]
	add	w8, w8, #1
	str	w8, [sp, #48]
	b	.LBB0_12
.LBB0_15:                               //   in Loop: Header=BB0_10 Depth=1
	str	wzr, [sp, #44]
	b	.LBB0_16
.LBB0_16:                               //   Parent Loop BB0_10 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldr	w9, [sp, #4]                    // 4-byte Folded Reload
	ldr	w8, [sp, #44]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB0_19
	b	.LBB0_17
.LBB0_17:                               //   in Loop: Header=BB0_16 Depth=2
	ldur	x8, [x29, #-16]
	ldrsw	x9, [sp, #44]
	ldr	s0, [x8, x9, lsl #2]
	fmov	s1, #0.50000000
	fmul	s0, s0, s1
	ldur	x8, [x29, #-40]
	ldrsw	x9, [sp, #44]
	str	s0, [x8, x9, lsl #2]
	b	.LBB0_18
.LBB0_18:                               //   in Loop: Header=BB0_16 Depth=2
	ldr	w8, [sp, #44]
	add	w8, w8, #1
	str	w8, [sp, #44]
	b	.LBB0_16
.LBB0_19:                               //   in Loop: Header=BB0_10 Depth=1
	b	.LBB0_20
.LBB0_20:                               //   in Loop: Header=BB0_10 Depth=1
	ldr	w8, [sp, #52]
	add	w8, w8, #1
	str	w8, [sp, #52]
	b	.LBB0_10
.LBB0_21:
	bl	now_sec
	str	d0, [sp, #32]
	movi	d0, #0000000000000000
	str	s0, [sp, #28]
	str	wzr, [sp, #24]
	b	.LBB0_22
.LBB0_22:                               // =>This Inner Loop Header: Depth=1
	ldr	w9, [sp, #4]                    // 4-byte Folded Reload
	ldr	w8, [sp, #24]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, .LBB0_25
	b	.LBB0_23
.LBB0_23:                               //   in Loop: Header=BB0_22 Depth=1
	ldur	x8, [x29, #-32]
	ldrsw	x9, [sp, #24]
	ldr	s0, [x8, x9, lsl #2]
	ldur	x8, [x29, #-40]
	ldrsw	x9, [sp, #24]
	ldr	s1, [x8, x9, lsl #2]
	fadd	s1, s0, s1
	ldr	s0, [sp, #28]
	fadd	s0, s0, s1
	str	s0, [sp, #28]
	b	.LBB0_24
.LBB0_24:                               //   in Loop: Header=BB0_22 Depth=1
	ldr	w8, [sp, #24]
	add	w8, w8, #1
	str	w8, [sp, #24]
	b	.LBB0_22
.LBB0_25:
	adrp	x8, :got:stderr
	ldr	x8, [x8, :got_lo12:stderr]
	ldr	x0, [x8]
	ldr	s0, [sp, #28]
	fcvt	d0, s0
	adrp	x1, .L.str.1
	add	x1, x1, :lo12:.L.str.1
	bl	fprintf
	adrp	x0, .L.str.2
	add	x0, x0, :lo12:.L.str.2
	bl	printf
	ldr	w1, [sp, #4]                    // 4-byte Folded Reload
	ldr	d0, [sp, #32]
	ldr	d1, [sp, #56]
	fsub	d0, d0, d1
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	mov	w2, #3                          // =0x3
	bl	printf
	ldur	x0, [x29, #-16]
	bl	free
	ldur	x0, [x29, #-24]
	bl	free
	ldur	x0, [x29, #-32]
	bl	free
	ldur	x0, [x29, #-40]
	bl	free
	stur	wzr, [x29, #-4]
	b	.LBB0_26
.LBB0_26:
	ldur	w0, [x29, #-4]
	.cfi_def_cfa wsp, 128
	ldp	x29, x30, [sp, #112]            // 16-byte Folded Reload
	add	sp, sp, #128
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          // -- Begin function now_sec
.LCPI1_0:
	.xword	0x3e112e0be826d695              // double 1.0000000000000001E-9
	.text
	.p2align	2
	.type	now_sec,@function
now_sec:                                // @now_sec
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #1                          // =0x1
	mov	x1, sp
	bl	clock_gettime
	ldr	d0, [sp]
	scvtf	d0, d0
	ldr	d1, [sp, #8]
	scvtf	d1, d1
	adrp	x8, .LCPI1_0
	ldr	d2, [x8, :lo12:.LCPI1_0]
	fmul	d1, d1, d2
	fadd	d0, d0, d1
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end1:
	.size	now_sec, .Lfunc_end1-now_sec
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"alloc failed\n"
	.size	.L.str, 14

	.type	.L.str.1,@object                // @.str.1
.L.str.1:
	.asciz	"Checksum: %f\n"
	.size	.L.str.1, 14

	.type	.L.str.2,@object                // @.str.2
.L.str.2:
	.asciz	"mode=unfused "
	.size	.L.str.2, 14

	.type	.L.str.3,@object                // @.str.3
.L.str.3:
	.asciz	"N=%d REPEAT=%d time=%f\n"
	.size	.L.str.3, 24

	.ident	"BiSheng Enterprise 4.2.0.B009 clang version 17.0.6 (958fd14d28f0)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym aligned_alloc
	.addrsig_sym fprintf
	.addrsig_sym printf
	.addrsig_sym free
	.addrsig_sym now_sec
	.addrsig_sym clock_gettime
	.addrsig_sym stderr
