	.text
	.file	"vec_add.c"
	.globl	f                               // -- Begin function f
	.p2align	2
	.type	f,@function
f:                                      // @f
	.cfi_startproc
// %bb.0:
                                        // kill: def $w0 killed $w0 def $x0
	cmp	w0, #1
	b.lt	.LBB0_3
// %bb.1:
	mov	x8, xzr
	ubfiz	x9, x0, #2, #32
.LBB0_2:                                // =>This Inner Loop Header: Depth=1
	ldr	s0, [x1, x8]
	ldr	s1, [x2, x8]
	fadd	s0, s0, s1
	str	s0, [x3, x8]
	add	x8, x8, #4
	cmp	x9, x8
	b.ne	.LBB0_2
.LBB0_3:
	ret
.Lfunc_end0:
	.size	f, .Lfunc_end0-f
	.cfi_endproc
                                        // -- End function
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	str	d8, [sp, #16]                   // 8-byte Folded Spill
	stp	x29, x30, [sp, #24]             // 16-byte Folded Spill
	str	x23, [sp, #40]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	add	x29, sp, #24
	.cfi_def_cfa w29, 56
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w30, -48
	.cfi_offset w29, -56
	.cfi_offset b8, -64
	mov	w0, #13568                      // =0x3500
	mov	w22, #13568                     // =0x3500
	movk	w0, #12, lsl #16
	movk	w22, #12, lsl #16
	bl	malloc
	mov	x19, x0
	mov	w0, #13568                      // =0x3500
	movk	w0, #12, lsl #16
	bl	malloc
	mov	x20, x0
	mov	w0, #13568                      // =0x3500
	movk	w0, #12, lsl #16
	bl	malloc
	movi	v8.2s, #48, lsl #24
	mov	x21, x0
	mov	x23, xzr
.LBB1_1:                                // =>This Inner Loop Header: Depth=1
	bl	rand
	scvtf	s0, w0
	fmul	s0, s0, s8
	str	s0, [x19, x23]
	bl	rand
	scvtf	s0, w0
	fmul	s0, s0, s8
	str	s0, [x20, x23]
	add	x23, x23, #4
	cmp	x22, x23
	b.ne	.LBB1_1
// %bb.2:
	mov	w23, #1000                      // =0x3e8
	bl	clock
	mov	x22, x0
.LBB1_3:                                // =>This Inner Loop Header: Depth=1
	mov	w0, #3392                       // =0xd40
	mov	x1, x19
	movk	w0, #3, lsl #16
	mov	x2, x20
	mov	x3, x21
	bl	f
	subs	w23, w23, #1
	b.ne	.LBB1_3
// %bb.4:
	bl	clock
	sub	x8, x0, x22
	mov	x9, #145685290680320            // =0x848000000000
	movk	x9, #16686, lsl #48
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	scvtf	d0, x8
	fmov	d1, x9
	fdiv	d0, d0, d1
	bl	printf
	ldr	s0, [x21]
	mov	x0, x19
	str	s0, [sp, #12]
	ldr	s0, [sp, #12]
	bl	free
	mov	x0, x20
	bl	free
	mov	x0, x21
	bl	free
	mov	w0, wzr
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #24]             // 16-byte Folded Reload
	ldr	x23, [sp, #40]                  // 8-byte Folded Reload
	ldr	d8, [sp, #16]                   // 8-byte Folded Reload
	add	sp, sp, #80
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	.cfi_restore b8
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"time: %f s\n"
	.size	.L.str, 12

	.ident	"BiSheng Enterprise 4.2.0.B009 clang version 17.0.6 (958fd14d28f0)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
