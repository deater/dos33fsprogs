	;=============================================
	; put_sprite
	;=============================================
	; Sprite to display in INH,INL
	; Assumes sprite size is 3x2
	; Location is SPRITE_XPOS,SPRITE_YPOS
	; Note, only works if SPRITE_YPOS is multiple of two

	; NO TRANSPARENCY

	; 13+ Y*(33+17+X*(18+13) + 5
	; 18 + Y*(50+31*X)

	; so if 3*2 = 304 cycles??

put_sprite:
	ldy	#0							; 2
	lda	#2		; ysize is 2				; 2
	sta	CV		; ysize is in CV			; 3

	lda	SPRITE_YPOS	; make a copy of ypos			; 3
	sta	TEMPY		; as we modify it			; 3
								;===========
								;	13
put_sprite_loop:
	sty	TEMP		; save sprite pointer			; 3
	ldy	TEMPY							; 3
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	clc								; 2
	adc	SPRITE_XPOS		; add in xpos			; 3
	sta	OUTL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3
	ldy	TEMP		; restore sprite pointer		; 3

				; OUTH:OUTL now points at right place

	ldx	#3		; load xsize into x			; 2
								;===========
								;	33
put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2

	sty	TEMP			; save sprite pointer		; 3
	ldy	#$0							; 2
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	 18

put_sprite_done_draw:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	dex				; decrement x counter		; 2
	bne	put_sprite_pixel	; if not done, keep looping	; 3
								;==============
								;	13

									; -1
	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5
	dec	CV			; decemenet total y count	; 5
	bne	put_sprite_loop		; loop if not done		; 3
								;==============
								;	17

									; -1
	rts				; return			; 6




