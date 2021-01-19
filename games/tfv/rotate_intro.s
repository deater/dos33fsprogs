	;===============================
	; rotate intro -- rotate screen
	;===============================

rotate_intro:

	; init the multiply routines

;	jsr	init_multiply_tables

	; first copy current screen to background

	jsr	gr_copy_current_to_offscreen_40x40

	lda	#0
	sta	ANGLE
	sta	SCALE_F
	sta	FRAMEL

	lda	#1
	sta	SCALE_I

rotate_loop:

	jsr	rotozoom
	jsr	page_flip

	; zoom out

	sec
	lda	SCALE_F
	sbc	#$10
	sta	SCALE_F
	lda	SCALE_I
	sbc	#$00
	sta	SCALE_I

	dec	ANGLE
	lda	ANGLE
	and	#$1f
	sta	ANGLE

	; rotate counter-clockwise

	cmp	#16
	beq	done_rotate

	jmp	rotate_loop

done_rotate:

	rts





	;=========================================================
	; gr_copy_current_to_offscreen 40x40
	;=========================================================
	; Copy draw page to $c00
	; Take image in DRAW_PAGE
	; 	Copy to $c00
	;	Actually copy lines 0..39
	; Don't over-write bottom 4 lines of text
gr_copy_current_to_offscreen_40x40:

	ldx	#0
gco_40x40_loop:
	lda	gr_offsets,X
	sta	OUTL
	sta	INL
	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	gr_offsets+1,X
	clc
	adc	#$8
	sta	INH

	ldy	#39
gco_40x40_inner:
	lda	(OUTL),Y
	sta	(INL),Y

	dey
	bpl	gco_40x40_inner

	inx
	inx

	cpx	#40
	bne	gco_40x40_loop

	rts								; 6
