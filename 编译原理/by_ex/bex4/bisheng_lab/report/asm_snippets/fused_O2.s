	.text
	.file	"loop_fusion_test.c"
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          // -- Begin function main
.LCPI0_0:
	.word	0                               // 0x0
	.word	1                               // 0x1
	.word	2                               // 0x2
	.word	3                               // 0x3
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI0_1:
	.xword	0x3e112e0be826d695              // double 1.0000000000000001E-9
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	str	d10, [sp, #16]                  // 8-byte Folded Spill
	stp	d9, d8, [sp, #32]               // 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             // 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_offset b8, -72
	.cfi_offset b9, -80
	.cfi_offset b10, -96
	mov	w1, #13824                      // =0x3600
	mov	w0, #64                         // =0x40
	movk	w1, #366, lsl #16
	bl	aligned_alloc
	mov	w1, #13824                      // =0x3600
	mov	x19, x0
	mov	w0, #64                         // =0x40
	movk	w1, #366, lsl #16
	bl	aligned_alloc
	mov	w1, #13824                      // =0x3600
	mov	x20, x0
	mov	w0, #64                         // =0x40
	movk	w1, #366, lsl #16
	bl	aligned_alloc
	mov	w1, #13824                      // =0x3600
	mov	x21, x0
	mov	w0, #64                         // =0x40
	movk	w1, #366, lsl #16
	bl	aligned_alloc
	cbz	x19, .LBB0_15
// %bb.1:
	cbz	x20, .LBB0_15
// %bb.2:
	cbz	x21, .LBB0_15
// %bb.3:
	mov	x22, x0
	cbz	x0, .LBB0_15
// %bb.4:
	adrp	x9, .LCPI0_0
	mov	w23, #36224                     // =0x8d80
	mov	w11, #36220                     // =0x8d7c
	movk	w23, #91, lsl #16
	movk	w11, #91, lsl #16
	mov	w10, #36224                     // =0x8d80
	ldr	q0, [x9, :lo12:.LCPI0_0]
	add	x8, x19, #16
	movi	v1.4s, #4
	add	x9, x20, #16
	movi	v2.4s, #8
	movk	w10, #91, lsl #16
	dup	v4.4s, w23
	dup	v5.4s, w11
	mov	v3.16b, v0.16b
.LBB0_5:                                // =>This Inner Loop Header: Depth=1
	add	v6.4s, v0.4s, v1.4s
	subs	x10, x10, #8
	sub	v7.4s, v4.4s, v3.4s
	sub	v17.4s, v5.4s, v3.4s
	scvtf	v16.4s, v0.4s
	scvtf	v6.4s, v6.4s
	scvtf	v7.4s, v7.4s
	scvtf	v17.4s, v17.4s
	add	v0.4s, v0.4s, v2.4s
	add	v3.4s, v3.4s, v2.4s
	stp	q16, q6, [x8, #-16]
	add	x8, x8, #32
	stp	q7, q17, [x9, #-16]
	add	x9, x9, #32
	b.ne	.LBB0_5
// %bb.6:
	mov	x1, sp
	mov	w0, #1                          // =0x1
	mov	x24, #-13824                    // =0xffffffffffffca00
	movk	x24, #65169, lsl #16
	bl	clock_gettime
	ldr	d0, [sp, #8]
	adrp	x8, .LCPI0_1
	mov	w9, #16                         // =0x10
	scvtf	d0, d0
	ldr	d9, [x8, :lo12:.LCPI0_1]
	ldr	x8, [sp]
	fmul	d8, d0, d9
	movi	v0.4s, #63, lsl #24
.LBB0_7:                                // =>This Inner Loop Header: Depth=1
	add	x10, x19, x9
	add	x11, x20, x9
	ldp	q1, q2, [x10, #-16]
	add	x10, x21, x9
	ldp	q3, q4, [x11, #-16]
	add	x11, x22, x9
	add	x9, x9, #32
	fadd	v3.4s, v1.4s, v3.4s
	fmul	v1.4s, v1.4s, v0.4s
	fadd	v4.4s, v2.4s, v4.4s
	fmul	v2.4s, v2.4s, v0.4s
	stp	q3, q4, [x10, #-16]
	add	x10, x9, x24
	cmp	x10, #16
	stp	q1, q2, [x11, #-16]
	b.ne	.LBB0_7
// %bb.8:
	movi	v0.4s, #63, lsl #24
	mov	w9, #16                         // =0x10
.LBB0_9:                                // =>This Inner Loop Header: Depth=1
	add	x10, x19, x9
	add	x11, x20, x9
	ldp	q1, q2, [x10, #-16]
	add	x10, x21, x9
	ldp	q3, q4, [x11, #-16]
	add	x11, x22, x9
	add	x9, x9, #32
	fadd	v3.4s, v1.4s, v3.4s
	fmul	v1.4s, v1.4s, v0.4s
	fadd	v4.4s, v2.4s, v4.4s
	fmul	v2.4s, v2.4s, v0.4s
	stp	q3, q4, [x10, #-16]
	add	x10, x9, x24
	cmp	x10, #16
	stp	q1, q2, [x11, #-16]
	b.ne	.LBB0_9
// %bb.10:
	movi	v0.4s, #63, lsl #24
	mov	w9, #16                         // =0x10
.LBB0_11:                               // =>This Inner Loop Header: Depth=1
	add	x10, x19, x9
	add	x11, x20, x9
	ldp	q1, q2, [x10, #-16]
	add	x10, x21, x9
	ldp	q3, q4, [x11, #-16]
	add	x11, x22, x9
	add	x9, x9, #32
	fadd	v3.4s, v1.4s, v3.4s
	fmul	v1.4s, v1.4s, v0.4s
	fadd	v4.4s, v2.4s, v4.4s
	fmul	v2.4s, v2.4s, v0.4s
	stp	q3, q4, [x10, #-16]
	add	x10, x9, x24
	cmp	x10, #16
	stp	q1, q2, [x11, #-16]
	b.ne	.LBB0_11
// %bb.12:
	mov	x1, sp
	mov	w0, #1                          // =0x1
	scvtf	d10, x8
	bl	clock_gettime
	ldr	d0, [sp, #8]
	movi	d1, #0000000000000000
	ldr	x8, [sp]
	add	x9, x21, #16
	add	x10, x22, #16
	scvtf	d0, d0
	fmul	d0, d0, d9
.LBB0_13:                               // =>This Inner Loop Header: Depth=1
	ldur	q2, [x9, #-16]
	subs	x23, x23, #8
	ldur	q3, [x10, #-16]
	fadd	v2.4s, v2.4s, v3.4s
	mov	s3, v2.s[1]
	fadd	s1, s1, s2
	mov	s4, v2.s[2]
	mov	s2, v2.s[3]
	fadd	s1, s1, s3
	ldr	q3, [x9], #32
	fadd	s1, s1, s4
	ldr	q4, [x10], #32
	fadd	v3.4s, v3.4s, v4.4s
	fadd	s1, s1, s2
	mov	s2, v3.s[1]
	fadd	s1, s1, s3
	mov	s4, v3.s[2]
	fadd	s1, s1, s2
	mov	s2, v3.s[3]
	fadd	s1, s1, s4
	fadd	s1, s1, s2
	b.ne	.LBB0_13
// %bb.14:
	scvtf	d2, x8
	adrp	x8, :got:stderr
	adrp	x1, .L.str.1
	add	x1, x1, :lo12:.L.str.1
	fadd	d8, d8, d10
	ldr	x8, [x8, :got_lo12:stderr]
	fadd	d9, d0, d2
	fcvt	d0, s1
	ldr	x0, [x8]
	bl	fprintf
	adrp	x0, .L.str.2
	add	x0, x0, :lo12:.L.str.2
	bl	printf
	fsub	d0, d9, d8
	mov	w1, #36224                      // =0x8d80
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	movk	w1, #91, lsl #16
	mov	w2, #3                          // =0x3
	bl	printf
	mov	x0, x19
	bl	free
	mov	x0, x20
	bl	free
	mov	x0, x21
	bl	free
	mov	x0, x22
	bl	free
	mov	w19, wzr
	b	.LBB0_16
.LBB0_15:
	adrp	x8, :got:stderr
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	mov	w1, #13                         // =0xd
	mov	w2, #1                          // =0x1
	mov	w19, #1                         // =0x1
	ldr	x8, [x8, :got_lo12:stderr]
	ldr	x3, [x8]
	bl	fwrite
.LBB0_16:
	mov	w0, w19
	.cfi_def_cfa wsp, 112
	ldp	x20, x19, [sp, #96]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #48]             // 16-byte Folded Reload
	ldp	d9, d8, [sp, #32]               // 16-byte Folded Reload
	ldr	d10, [sp, #16]                  // 8-byte Folded Reload
	add	sp, sp, #112
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w30
	.cfi_restore w29
	.cfi_restore b8
	.cfi_restore b9
	.cfi_restore b10
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
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
	.asciz	"mode=fused "
	.size	.L.str.2, 12

	.type	.L.str.3,@object                // @.str.3
.L.str.3:
	.asciz	"N=%d REPEAT=%d time=%f\n"
	.size	.L.str.3, 24

	.ident	"BiSheng Enterprise 4.2.0.B009 clang version 17.0.6 (958fd14d28f0)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
