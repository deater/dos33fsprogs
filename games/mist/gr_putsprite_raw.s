	;=============================================
	; put_sprite_raw
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two

	; no transparency, no cropping

	; FIXME: force YPOS to be even?

put_sprite_raw:

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
put_sprite_raw_loop:
	sty	TEMP		; save sprite pointer			; 3
	ldy	TEMPY							; 3

	bpl	put_sprite_raw_pos	; if < 0, skip to next

	clc				; skip line in sprite too
	lda	TEMP
	adc	CH
	tay

	bne	raw_increment_y

put_sprite_raw_pos:

psr_smc1:
	cpy	#48			; bge if >= 48, done sprite
	bcs	raw_sprite_done


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
raw_put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2
	sty	TEMP			; save sprite pointer		; 3


	cpx	#0			; if off-screen left, skip draw
	bmi	skip_drawing
	cpx	#40
	bcs	skip_drawing		; if off-screen right, skip draw

	ldy	#$0							; 2


	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent


raw_put_sprite_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	  9
raw_put_sprite_done_draw:
skip_drawing:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	inx				; increment x counter		; 2
	cpx	XMAX
	bne	raw_put_sprite_pixel	; if not done, keep looping	; 2nt/3
								;==============
								;	12/13
raw_increment_y:

	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5
	dec	CV			; decemenet total y count	; 5
	bne	put_sprite_raw_loop	; loop if not done		; 2nt/3
								;==============
								;	17/18
raw_sprite_done:
	rts				; return			; 6



