
	;===============================
	;===============================
	; draw_scene
	;===============================
	;===============================

draw_scene:


	;===============================
	; decompress background
	;===============================

before:
;	ldx	SCENE_COUNT

;	lda	frames_l,X
	lda	#<captured_bg
	sta	ZX0_src
;	lda	frames_h,X
	lda	#>captured_bg
        sta	ZX0_src+1

	clc
	lda	DRAW_PAGE
	adc	#$4

	jsr	full_decomp
after:


	; fallthrough


	;===============================
	; do overlay
	;===============================
	;	INL/H $c00   = overlay
	;	OUTL/H  = gr location
do_overlay:
load_overlay:
	; load overlay to $C00

	ldx	WHICH_OVERLAY

	lda	frames_l,X
	sta	ZX0_src
	lda	frames_h,X
        sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp
done_load_overlay:


	;====================
	; mask with overlay
	;====================

	lda	DRAW_PAGE
	clc
	adc	#$4
	sta	OUTH

	lda	#$0c
	sta	INH

	lda	#0
	sta	OUTL
	sta	INL

do_overlay_outer:

	ldy	#0
do_overlay_inner:

	lda	(INL),Y

	; 3 options, $AA, $AX, $XA, $XX

	cmp	#$aa
	beq	mask_full

	and	#$0f
	cmp	#$0a
	beq	mask_bottom

	lda	(INL),Y
	and	#$f0
	cmp	#$a0
	beq	mask_top

	bne	mask_none

mask_top:
	lda	#$0f
	bne	mask_save	; bra

mask_bottom:
	lda	#$f0
	bne	mask_save	; bra

mask_full:
	lda	#$00
	beq	mask_save	; bra

mask_none:
	lda	#$ff

mask_save:
	sta	MASK


	lda	(INL),Y
	and	MASK
	sta	TEMP

	lda	MASK
	eor	#$ff
	and	(OUTL),Y
	ora	TEMP
	sta	(OUTL),Y

skip_write:
	dey
	bne	do_overlay_inner


	inc	OUTH
	inc	INH

	lda	INH
	cmp	#$10
	bne	do_overlay_inner

	rts

