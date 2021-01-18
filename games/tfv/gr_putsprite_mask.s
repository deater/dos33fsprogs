	;=============================================
	; put_sprite_mask
	;=============================================
	; put an outline of the sprite, using non-transparent ($AA)
	; pixels with a solid color in COLOR

	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two

	; transparent color is $A (grey #2)
	;  this means we can have black ($0) in a sprite

	; FIXME: force YPOS to be even?

	; A, X, Y trashed

put_sprite_mask:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2
	clc
	adc	XPOS
	sta	XMAX

	lda	(INL),Y		; byte 1 is ysize			; 5
	sta	CV		; ysize is in CV			; 3
	iny								; 2

	lda	YPOS		; make a copy of ypos			; 3
	sta	TEMPY		; as we modify it			; 3
								;===========
								;	28
psm_put_sprite_loop:
	sty	TEMP		; save sprite pointer			; 3
	ldy	TEMPY							; 3

	bpl	psm_put_sprite_pos	; if < 0, skip to next

	clc				; skip line in sprite too
	lda	TEMP
	adc	CH
	tay

	bne	psm_increment_y

psm_put_sprite_pos:

psm_smc1:
	cpy	#48			; bge if >= 48, done sprite
	bcs	psm_sprite_done


	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	clc								; 2
	adc	XPOS		; add in xpos				; 3
	sta	OUTL		; store out low byte of addy		; 3
	clc	; never wraps, handle negative
	lda	gr_offsets+1,Y	; look up high byte			; 4
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3
	ldy	TEMP		; restore sprite pointer		; 3

				; OUTH:OUTL now points at right place

	ldx	XPOS		; load xposition into x			; 3
								;===========
								;	34
psm_put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2
	sty	TEMP			; save sprite pointer		; 3


	cpx	#0			; if off-screen left, skip draw
	bmi	psm_skip_drawing
	cpx	#40
	bcs	psm_skip_drawing	; if off-screen right, skip draw

	ldy	#$0							; 2

	; check if completely transparent
	; if so, skip

	cmp	#$AA			; if all zero, transparent	; 2
	beq	psm_put_sprite_done_draw	; don't draw it			; 2nt/3
								;==============
								;	 16/17

	sta	COLOR2			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	cmp	#$a0
	bne	psm_put_sprite_bottom	; if not skip ahead		; 2nt/3
								;==============
								;	7/8

	lda	COLOR
	and	#$0f
	sta	COLOR2

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	psm_put_sprite_mask		; always?			; 3
								;=============
								;	  8

psm_put_sprite_bottom:

	lda	COLOR2			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	cmp	#$0a
	bne	psm_put_sprite_all		; if not, skip ahead		; 2nt/3
								;=============
								;	7/8

	lda	COLOR
	and	#$f0
	sta	COLOR2
	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3
								;===========
								;         5

psm_put_sprite_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR2			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 6

	jmp	psm_put_sprite_done_draw	; we are done			; 3
								;===========
								;        20

psm_put_sprite_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	  9

psm_put_sprite_done_draw:
psm_skip_drawing:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	inx				; increment x counter		; 2
	cpx	XMAX
	bne	psm_put_sprite_pixel	; if not done, keep looping	; 2nt/3
								;==============
								;	12/13
psm_increment_y:

	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5
	dec	CV			; decemenet total y count	; 5
	bne	psm_put_sprite_loop	; loop if not done		; 2nt/3
								;==============
								;	17/18
psm_sprite_done:
	rts				; return			; 6



