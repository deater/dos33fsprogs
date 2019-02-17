	;=========================================================
	; gr_overlay, 40x40 version
	;=========================================================
	; copy 0xc00 to DRAW_PAGE
	; then overlay with 0x1000, treating 0xa as transparent

gr_overlay_40x40:
	jsr	gr_copy_to_current_40x40

gr_overlay_40x40_noload:
	lda	#40
	sta	CH		; xsize is in CH			; 3
	lda	#38
	sta	CV		; ysize is in CV			; 3

	jmp	gr_overlay_custom


	;=========================================================
	; gr_overlay, 40x48 version
	;=========================================================
	; copy 0xc00 to DRAW_PAGE
	; then overlay with 0x1000, treating 0xa as transparent

gr_overlay:
	jsr	gr_copy_to_current


gr_overlay_noload:

	lda	#40
	sta	CH		; xsize is in CH			; 3
	lda	#46
	sta	CV		; ysize is in CV			; 3

gr_overlay_custom:

	ldy	#0

gr_overlay_loop:

	ldy	CV							; 3
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	OUTL		; store out low byte of addy		; 3
	sta	INL
	lda	gr_offsets+1,Y	; look up high byte			; 4
	clc
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3

	lda	gr_offsets+1,Y	; look up high byte			; 4
	clc
	adc	#$c		; force to start at $1000
	sta	INH

				; OUTH:OUTL now points at right place

	ldx	CH		; load xsize into x			; 3
	ldy	#0
gr_overlay_put_pixel:
	lda	(INL),Y			; get sprite colors		; 5

	; check if completely transparent
	; if so, skip

	cmp	#$aa			; if all zero, transparent	; 2
	beq	gr_overlay_done_draw	; don't draw it			; 2nt/3

	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	cmp	#$a0
	bne	gr_overlay_bottom	; if not skip ahead		; 2nt/3

	lda	COLOR
	and	#$0f
	sta	COLOR

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	gr_overlay_mask		; always?			; 3


gr_overlay_bottom:
	lda	COLOR			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	cmp	#$0a
	bne	overlay_put_sprite_all	; if not, skip ahead		; 2nt/3
								;=============
								;	7/8

	lda	COLOR
	and	#$f0
	sta	COLOR
	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3
								;===========
								;         5

gr_overlay_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 6

	jmp	gr_overlay_done_draw	; we are done			; 3

overlay_put_sprite_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 6


gr_overlay_done_draw:
	iny
	dex				; decrement x counter		; 2
	bne	gr_overlay_put_pixel	; if not done, keep looping	; 2nt/3

	dec	CV			; decemenet total y count	; 5
	dec	CV
	bpl	gr_overlay_loop		; loop if not done		; 2nt/3


	rts				; return			; 6
