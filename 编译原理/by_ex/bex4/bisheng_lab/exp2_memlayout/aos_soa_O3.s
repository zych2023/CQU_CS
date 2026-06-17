	.text
	.file	"aos_soa.c"
	.globl	transform_a_aos                 // -- Begin function transform_a_aos
	.p2align	2
	.type	transform_a_aos,@function
transform_a_aos:                        // @transform_a_aos
	.cfi_startproc
// %bb.0:
	mov	w8, #20352                      // =0x4f80
	mov	w9, #52429                      // =0xcccd
	mov	w10, #20352                     // =0x4f80
	movk	w8, #18, lsl #16
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	movk	w10, #18, lsl #16
	mov	x11, x0
	mov	x12, x1
.LBB0_1:                                // =>This Inner Loop Header: Depth=1
	ldr	s1, [x11], #128
	fmov	s2, w9
	subs	x10, x10, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x12], #4
	b.ne	.LBB0_1
// %bb.2:
	mov	w9, #52429                      // =0xcccd
	mov	w12, #20352                     // =0x4f80
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	mov	x10, x0
	mov	x11, x1
	movk	w12, #18, lsl #16
.LBB0_3:                                // =>This Inner Loop Header: Depth=1
	ldr	s1, [x10], #128
	fmov	s2, w9
	subs	x12, x12, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x11], #4
	b.ne	.LBB0_3
// %bb.4:
	mov	w9, #52429                      // =0xcccd
	mov	w12, #20352                     // =0x4f80
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	mov	x10, x0
	mov	x11, x1
	movk	w12, #18, lsl #16
.LBB0_5:                                // =>This Inner Loop Header: Depth=1
	ldr	s1, [x10], #128
	fmov	s2, w9
	subs	x12, x12, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x11], #4
	b.ne	.LBB0_5
// %bb.6:
	mov	w9, #52429                      // =0xcccd
	mov	w12, #20352                     // =0x4f80
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	mov	x10, x0
	mov	x11, x1
	movk	w12, #18, lsl #16
.LBB0_7:                                // =>This Inner Loop Header: Depth=1
	ldr	s1, [x10], #128
	fmov	s2, w9
	subs	x12, x12, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x11], #4
	b.ne	.LBB0_7
// %bb.8:
	mov	w9, #52429                      // =0xcccd
	mov	w12, #20352                     // =0x4f80
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	mov	x10, x0
	mov	x11, x1
	movk	w12, #18, lsl #16
.LBB0_9:                                // =>This Inner Loop Header: Depth=1
	ldr	s1, [x10], #128
	fmov	s2, w9
	subs	x12, x12, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x11], #4
	b.ne	.LBB0_9
// %bb.10:
	mov	w9, #52429                      // =0xcccd
	mov	w12, #20352                     // =0x4f80
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	mov	x10, x0
	mov	x11, x1
	movk	w12, #18, lsl #16
.LBB0_11:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x10], #128
	fmov	s2, w9
	subs	x12, x12, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x11], #4
	b.ne	.LBB0_11
// %bb.12:
	mov	w9, #52429                      // =0xcccd
	mov	w12, #20352                     // =0x4f80
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	mov	x10, x0
	mov	x11, x1
	movk	w12, #18, lsl #16
.LBB0_13:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x10], #128
	fmov	s2, w9
	subs	x12, x12, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x11], #4
	b.ne	.LBB0_13
// %bb.14:
	mov	w9, #52429                      // =0xcccd
	mov	w12, #20352                     // =0x4f80
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	mov	x10, x0
	mov	x11, x1
	movk	w12, #18, lsl #16
.LBB0_15:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x10], #128
	fmov	s2, w9
	subs	x12, x12, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x11], #4
	b.ne	.LBB0_15
// %bb.16:
	mov	w9, #52429                      // =0xcccd
	mov	w12, #20352                     // =0x4f80
	movk	w9, #16268, lsl #16
	fmov	s0, #2.00000000
	mov	x10, x0
	mov	x11, x1
	movk	w12, #18, lsl #16
.LBB0_17:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x10], #128
	fmov	s2, w9
	subs	x12, x12, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x11], #4
	b.ne	.LBB0_17
// %bb.18:
	mov	w9, #52429                      // =0xcccd
	fmov	s0, #2.00000000
	movk	w9, #16268, lsl #16
.LBB0_19:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0], #128
	fmov	s2, w9
	subs	x8, x8, #1
	fmadd	s1, s1, s2, s0
	str	s1, [x1], #4
	b.ne	.LBB0_19
// %bb.20:
	ret
.Lfunc_end0:
	.size	transform_a_aos, .Lfunc_end0-transform_a_aos
	.cfi_endproc
                                        // -- End function
	.globl	transform_a_soa                 // -- Begin function transform_a_soa
	.p2align	2
	.type	transform_a_soa,@function
transform_a_soa:                        // @transform_a_soa
	.cfi_startproc
// %bb.0:
	mov	w9, #15872                      // =0x3e00
	sub	x10, x1, x0
	mov	w8, #20352                      // =0x4f80
	movk	w9, #73, lsl #16
	movk	w8, #18, lsl #16
	sub	x10, x10, #4
	cmp	x10, #28
	b.hs	.LBB1_3
// %bb.1:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_2:                                // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_2
	b	.LBB1_5
.LBB1_3:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_4:                                // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_4
.LBB1_5:
	cmp	x10, #28
	b.hs	.LBB1_8
// %bb.6:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_7:                                // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_7
	b	.LBB1_10
.LBB1_8:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_9:                                // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_9
.LBB1_10:
	cmp	x10, #28
	b.hs	.LBB1_13
// %bb.11:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_12:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_12
	b	.LBB1_15
.LBB1_13:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_14:                               // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_14
.LBB1_15:
	cmp	x10, #28
	b.hs	.LBB1_18
// %bb.16:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_17:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_17
	b	.LBB1_20
.LBB1_18:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_19:                               // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_19
.LBB1_20:
	cmp	x10, #28
	b.hs	.LBB1_23
// %bb.21:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_22:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_22
	b	.LBB1_25
.LBB1_23:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_24:                               // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_24
.LBB1_25:
	cmp	x10, #28
	b.hs	.LBB1_28
// %bb.26:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_27:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_27
	b	.LBB1_30
.LBB1_28:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_29:                               // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_29
.LBB1_30:
	cmp	x10, #28
	b.hs	.LBB1_33
// %bb.31:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_32:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_32
	b	.LBB1_35
.LBB1_33:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_34:                               // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_34
.LBB1_35:
	cmp	x10, #28
	b.hs	.LBB1_38
// %bb.36:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_37:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_37
	b	.LBB1_40
.LBB1_38:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_39:                               // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_39
.LBB1_40:
	cmp	x10, #28
	b.hs	.LBB1_43
// %bb.41:
	mov	w12, #52429                     // =0xcccd
	mov	x11, xzr
	movk	w12, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_42:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x11]
	fmov	s2, w12
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x11]
	add	x11, x11, #4
	cmp	x9, x11
	b.ne	.LBB1_42
	b	.LBB1_45
.LBB1_43:
	mov	w14, #52429                     // =0xcccd
	mov	w13, #20352                     // =0x4f80
	movk	w14, #16268, lsl #16
	add	x11, x0, #16
	add	x12, x1, #16
	movk	w13, #18, lsl #16
	dup	v0.4s, w14
.LBB1_44:                               // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x11, #-16]
	movi	v2.4s, #64, lsl #24
	add	x11, x11, #32
	movi	v3.4s, #64, lsl #24
	subs	x13, x13, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x12, #-16]
	add	x12, x12, #32
	b.ne	.LBB1_44
.LBB1_45:
	cmp	x10, #28
	b.hs	.LBB1_48
// %bb.46:
	mov	w10, #52429                     // =0xcccd
	mov	x8, xzr
	movk	w10, #16268, lsl #16
	fmov	s0, #2.00000000
.LBB1_47:                               // =>This Inner Loop Header: Depth=1
	ldr	s1, [x0, x8]
	fmov	s2, w10
	fmadd	s1, s1, s2, s0
	str	s1, [x1, x8]
	add	x8, x8, #4
	cmp	x9, x8
	b.ne	.LBB1_47
	b	.LBB1_50
.LBB1_48:
	mov	w11, #52429                     // =0xcccd
	add	x9, x0, #16
	movk	w11, #16268, lsl #16
	add	x10, x1, #16
	dup	v0.4s, w11
.LBB1_49:                               // =>This Inner Loop Header: Depth=1
	ldp	q1, q4, [x9, #-16]
	movi	v2.4s, #64, lsl #24
	add	x9, x9, #32
	movi	v3.4s, #64, lsl #24
	subs	x8, x8, #8
	fmla	v2.4s, v1.4s, v0.4s
	fmla	v3.4s, v4.4s, v0.4s
	stp	q2, q3, [x10, #-16]
	add	x10, x10, #32
	b.ne	.LBB1_49
.LBB1_50:
	ret
.Lfunc_end1:
	.size	transform_a_soa, .Lfunc_end1-transform_a_soa
	.cfi_endproc
                                        // -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          // -- Begin function main
.LCPI2_0:
	.xword	0x3e112e0be826d695              // double 1.0000000000000001E-9
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	stp	d11, d10, [sp, #16]             // 16-byte Folded Spill
	stp	d9, d8, [sp, #32]               // 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 80
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w30, -72
	.cfi_offset w29, -80
	.cfi_offset b8, -88
	.cfi_offset b9, -96
	.cfi_offset b10, -104
	.cfi_offset b11, -112
	.cfi_remember_state
	mov	w1, #49152                      // =0xc000
	mov	w0, #64                         // =0x40
	movk	w1, #2343, lsl #16
	bl	aligned_alloc
	mov	w1, #15872                      // =0x3e00
	mov	x19, x0
	mov	w0, #64                         // =0x40
	movk	w1, #73, lsl #16
	bl	aligned_alloc
	mov	w1, #15872                      // =0x3e00
	mov	x20, x0
	mov	w0, #64                         // =0x40
	movk	w1, #73, lsl #16
	bl	aligned_alloc
	mov	w1, #15872                      // =0x3e00
	mov	x21, x0
	mov	w0, #64                         // =0x40
	movk	w1, #73, lsl #16
	bl	aligned_alloc
	cbz	x19, .LBB2_10
// %bb.1:
	cbz	x20, .LBB2_10
// %bb.2:
	cbz	x21, .LBB2_10
// %bb.3:
	mov	x22, x0
	cbz	x0, .LBB2_10
// %bb.4:
	mov	w2, #15872                      // =0x3e00
	mov	x0, x21
	mov	w1, wzr
	movk	w2, #73, lsl #16
	mov	w23, #20352                     // =0x4f80
	movk	w23, #18, lsl #16
	bl	memset
	mov	w2, #15872                      // =0x3e00
	mov	x0, x22
	mov	w1, wzr
	movk	w2, #73, lsl #16
	bl	memset
	movi	v0.2d, #0000000000000000
	mov	w10, #4719                      // =0x126f
	mov	x8, xzr
	add	x9, x19, #4
	movk	w10, #14979, lsl #16
.LBB2_5:                                // =>This Inner Loop Header: Depth=1
	scvtf	s1, w8
	fmov	s2, w10
	stp	q0, q0, [x9]
	stp	q0, q0, [x9, #32]
	stp	q0, q0, [x9, #64]
	fmul	s1, s1, s2
	str	q0, [x9, #96]
	stur	q0, [x9, #108]
	str	s1, [x20, x8, lsl #2]
	add	x8, x8, #1
	stur	s1, [x9, #-4]
	add	x9, x9, #128
	cmp	x23, x8
	b.ne	.LBB2_5
// %bb.6:
	mov	x1, sp
	mov	w0, #1                          // =0x1
	bl	clock_gettime
	ldr	d0, [sp, #8]
	adrp	x8, .LCPI2_0
	mov	x0, x19
	mov	x1, x21
	ldr	x24, [sp]
	scvtf	d0, d0
	ldr	d11, [x8, :lo12:.LCPI2_0]
	fmul	d8, d0, d11
	bl	transform_a_aos
	mov	x1, sp
	mov	w0, #1                          // =0x1
	bl	clock_gettime
	ldr	d0, [sp, #8]
	mov	x1, sp
	mov	w0, #1                          // =0x1
	ldr	x25, [sp]
	scvtf	d0, d0
	fmul	d9, d0, d11
	bl	clock_gettime
	ldr	d0, [sp, #8]
	mov	x0, x20
	mov	x1, x22
	ldr	x26, [sp]
	scvtf	d0, d0
	fmul	d10, d0, d11
	bl	transform_a_soa
	mov	x1, sp
	mov	w0, #1                          // =0x1
	bl	clock_gettime
	ldr	d0, [sp, #8]
	movi	d1, #0000000000000000
	ldr	x8, [sp]
	add	x9, x21, #16
	add	x10, x22, #16
	scvtf	d0, d0
	fmul	d2, d0, d11
	movi	d0, #0000000000000000
.LBB2_7:                                // =>This Inner Loop Header: Depth=1
	ldur	q3, [x10, #-16]
	subs	x23, x23, #8
	ldur	q4, [x9, #-16]
	fcvtl	v5.2d, v3.2s
	fcvtl2	v3.2d, v3.4s
	fcvtl	v6.2d, v4.2s
	fcvtl2	v4.2d, v4.4s
	mov	d7, v5.d[1]
	fadd	d1, d1, d5
	mov	d5, v6.d[1]
	fadd	d0, d0, d6
	mov	d6, v3.d[1]
	fadd	d1, d1, d7
	fadd	d0, d0, d5
	ldr	q5, [x10], #32
	fadd	d1, d1, d3
	mov	d3, v4.d[1]
	fadd	d0, d0, d4
	fcvtl	v7.2d, v5.2s
	ldr	q4, [x9], #32
	fcvtl2	v5.2d, v5.4s
	fadd	d1, d1, d6
	fcvtl	v6.2d, v4.2s
	fadd	d0, d0, d3
	mov	d3, v7.d[1]
	fadd	d1, d1, d7
	mov	d7, v6.d[1]
	fadd	d0, d0, d6
	fadd	d1, d1, d3
	fcvtl2	v3.2d, v4.4s
	fadd	d0, d0, d7
	mov	d4, v5.d[1]
	fadd	d1, d1, d5
	mov	d5, v3.d[1]
	fadd	d0, d0, d3
	fadd	d1, d1, d4
	fadd	d0, d0, d5
	b.ne	.LBB2_7
// %bb.8:
	scvtf	d3, x24
	scvtf	d4, x25
	scvtf	d5, x26
	scvtf	d6, x8
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	fadd	d8, d8, d3
	fadd	d9, d9, d4
	fadd	d10, d10, d5
	fadd	d11, d2, d6
	bl	printf
	fsub	d0, d9, d8
	fsub	d1, d11, d10
	adrp	x0, .L.str.2
	add	x0, x0, :lo12:.L.str.2
	bl	printf
	mov	x0, x19
	bl	free
	mov	x0, x20
	bl	free
	mov	x0, x21
	bl	free
	mov	x0, x22
	bl	free
	mov	w0, wzr
.LBB2_9:
	.cfi_def_cfa wsp, 128
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #48]             // 16-byte Folded Reload
	ldp	d9, d8, [sp, #32]               // 16-byte Folded Reload
	ldp	d11, d10, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #128
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w30
	.cfi_restore w29
	.cfi_restore b8
	.cfi_restore b9
	.cfi_restore b10
	.cfi_restore b11
	ret
.LBB2_10:
	.cfi_restore_state
	adrp	x0, .Lstr
	add	x0, x0, :lo12:.Lstr
	bl	puts
	mov	w0, #1                          // =0x1
	b	.LBB2_9
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str.1,@object                // @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"checksum_aos=%0.3f checksum_soa=%0.3f\n"
	.size	.L.str.1, 39

	.type	.L.str.2,@object                // @.str.2
.L.str.2:
	.asciz	"time_aos=%f time_soa=%f\n"
	.size	.L.str.2, 25

	.type	.Lstr,@object                   // @str
.Lstr:
	.asciz	"alloc failed"
	.size	.Lstr, 13

	.ident	"BiSheng Enterprise 4.2.0.B009 clang version 17.0.6 (958fd14d28f0)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
