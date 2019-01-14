
	;=============================================
	; put_sprite
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two

	; transparent color is $A (grey #2)
	;  this means we can have black ($0) in a sprite

	; also note all the cycle count is out of date

	; time= 28 setup
	;    Y*outerloop
	;    outerloop = 34 setup
	;	X*innerloop
	;	innerloop = 30 if $00 17+13(done)
	;		    64 if $0X 16+7+8+20(put_sprite_mask)+13(done)
	;		    69 if $X0 16+8+7+5+20(put_sprite_mask)+13(done)
	;		    54 if if $XX 16+8+8+9(put_all)+13(done)


	;       -1 for last iteration
	;    18 (-1 for last)
	;     6 return

	; so cost = 28 + Y*(34+18)+ (INNER-Y) -1 + 6
	;         = 33 + Y*(52)+(INNER-Y)
	;	  = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y

put_sprite:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2

	lda	(INL),Y		; byte 1 is ysize			; 5
	sta	CV		; ysize is in CV			; 3
	iny								; 2

	lda	YPOS		; make a copy of ypos			; 3
	sta	TEMPY		; as we modify it			; 3
								;===========
								;	28
put_sprite_loop:
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
put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2

	sty	TEMP			; save sprite pointer		; 3
	ldy	#$0							; 2

	; check if completely transparent
	; if so, skip

	cmp	#$aa			; if all zero, transparent	; 2
	beq	put_sprite_done_draw	; don't draw it			; 2nt/3
								;==============
								;	 16/17

	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	cmp	#$a0
	bne	put_sprite_bottom	; if not skip ahead		; 2nt/3
								;==============
								;	7/8

	lda	COLOR
	and	#$0f
	sta	COLOR

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	put_sprite_mask		; always?			; 3
								;=============
								;	  8

put_sprite_bottom:
	lda	COLOR			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	cmp	#$0a
	bne	put_sprite_all		; if not, skip ahead		; 2nt/3
								;=============
								;	7/8

	lda	COLOR
	and	#$f0
	sta	COLOR
	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3
								;===========
								;         5

put_sprite_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 6

	jmp	put_sprite_done_draw	; we are done			; 3
								;===========
								;        20

put_sprite_all:
	lda	COLOR			; load color			; 3
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

	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5
	dec	CV			; decemenet total y count	; 5
	bne	put_sprite_loop		; loop if not done		; 2nt/3
								;==============
								;	17/18

	rts				; return			; 6


