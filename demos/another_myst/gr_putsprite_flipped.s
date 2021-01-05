	;=============================================
	; put_sprite_flipped
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two

	; transparent color is $A (grey #2)
	;  this means we can have black ($0) in a sprite


put_sprite_flipped:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2


	lda	(INL),Y		; byte 1 is ysize			; 5
	sta	CV		; ysize is in CV			; 3
	dey			; make Y zero again			; 2

	lda	INH
	sta	ppf_smc+2
	clc
	lda	INL
	adc	#1		; add one (not two) because X counts
				; from CH to 1 (not CH-1 to 0)
	sta	ppf_smc+1
	bcc	psf16
	inc	ppf_smc+2
psf16:


	lda	YPOS		; make a copy of ypos			; 3

	sta	TEMPY		; as we modify it			; 3
								;===========
								;	28



put_spritef_loop:
	sty	TEMP		; save sprite pointer			; 3
	ldy	TEMPY							; 3
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	clc								; 2
	adc	XPOS		; add in xpos				; 3
	sta	OUTL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3
	ldy	TEMP		; restore sprite pointer		; 3

				; OUTH:OUTL now points at right place

	ldx	CH		; load xsize into x			; 3
								;===========
								;	34
put_spritef_pixel:
ppf_smc:
	lda	$C000,X			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2

	sty	TEMP			; save sprite pointer		; 3
	ldy	#$0							; 2

	; check if completely transparent
	; if so, skip

	cmp	#$aa			; if all zero, transparent	; 2
	beq	put_spritef_done_draw	; don't draw it			; 2nt/3
								;==============
								;	 16/17

	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	cmp	#$a0
	bne	put_spritef_bottom	; if not skip ahead		; 2nt/3
								;==============
								;	7/8

	lda	COLOR
	and	#$0f
	sta	COLOR

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	put_spritef_mask	; always?			; 3
								;=============
								;	  8

put_spritef_bottom:
	lda	COLOR			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	cmp	#$0a
	bne	put_spritef_all		; if not, skip ahead		; 2nt/3
								;=============
								;	7/8

	lda	COLOR
	and	#$f0
	sta	COLOR
	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3
								;===========
								;         5

put_spritef_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 6

	jmp	put_spritef_done_draw	; we are done			; 3
								;===========
								;        20

put_spritef_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	  9

put_spritef_done_draw:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	dex				; decrement x counter		; 2
	bne	put_spritef_pixel	; if not done, keep looping	; 2nt/3
								;==============
								;	12/13

	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5

	lda	CH
	clc
	adc	ppf_smc+1
	sta	ppf_smc+1
	bcc	psfo
	inc	ppf_smc+2
psfo:

	dec	CV			; decemenet total y count	; 5
	bne	put_spritef_loop	; loop if not done		; 2nt/3
								;==============
								;	17/18

	rts				; return			; 6


