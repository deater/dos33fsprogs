
	;=============================================
	; put_sprite_one_color_no_transparent
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two

	; This is a fast sprite with no transparency and assumes
	; only black/white sprite.  Can change color by setting the
	; sprite_color_smc+1 value

put_sprite:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2

	lda	(INL),Y		; byte 1 is ysize			; 5
	sta	CV		; ysize is in CV			; 3
	iny								; 2

	ldx	YPOS		; make a copy of ypos			; 3
								;===========
								;	25
put_sprite_loop:
	stx	TEMPY		; as we modify it			; 3
	lda	gr_offsets,X	; lookup low-res memory address		; 4
	clc								; 2
	adc	XPOS		; add in xpos				; 3
	sta	OUTL		; store out low byte of addy		; 3
	lda	gr_offsets+1,X	; look up high byte			; 4
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3

				; OUTH:OUTL now points at right place

	ldx	CH		; load xsize into x			; 3
								;===========
								;	28
put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2

	sty	TEMP			; save sprite pointer		; 3


sprite_color_smc:
	and	#$ff

;	cmp	#$00
;	beq	sprite_output

;	cmp	#$ff
;	bne	not_ff
;sprite_color_ff_smc:
;	lda	#$ff
;	jmp	sprite_output
;not_ff:
;	cmp	#$f0
;	bne	not_f0
;sprite_color_f0_smc:
;	lda	#$f0
;	jmp	sprite_output

;not_f0:
;sprite_color_0f_smc:
;	lda	#$0f

;sprite_output:

	ldy	#$0							; 2
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	  9

put_sprite_done_draw:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	dex				; decrement x counter		; 2
	bne	put_sprite_pixel	; if not done, keep looping	; 2nt/3
								;==============
								;	12/13

	ldx	TEMPY							; 3
	inx				; each line has two y vars	; 2
	inx								; 2
	dec	CV			; decemenet total y count	; 5
	bne	put_sprite_loop		; loop if not done		; 2nt/3
								;==============
								;	14/15

	rts				; return			; 6




