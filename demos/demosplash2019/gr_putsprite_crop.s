	;=============================================
	; put_sprite_crop
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two

	; transparent color is $A (grey #2)
	;  this means we can have black ($0) in a sprite

	; FIXME: force YPOS to be even?

put_sprite_crop:

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
put_sprite_crop_loop:
	sty	TEMP		; save sprite pointer			; 3
	ldy	TEMPY							; 3

	bpl	put_sprite_crop_pos	; if < 0, skip to next

	clc				; skip line in sprite too
	lda	TEMP
	adc	CH
	tay

	bne	crop_increment_y

put_sprite_crop_pos:
	cpy	#48			; bge if >= 48, done sprite
	bcs	crop_sprite_done


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
crop_put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2
	sty	TEMP			; save sprite pointer		; 3


	cpx	#0			; if off-screen left, skip draw
	bmi	skip_drawing
	cpx	#40
	bcs	skip_drawing		; if off-screen right, skip draw

	ldy	#$0							; 2

	; check if completely transparent
	; if so, skip

	cmp	#$aa			; if all zero, transparent	; 2
	beq	crop_put_sprite_done_draw	; don't draw it			; 2nt/3
								;==============
								;	 16/17

	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	cmp	#$a0
	bne	crop_put_sprite_bottom	; if not skip ahead		; 2nt/3
								;==============
								;	7/8

	lda	COLOR
	and	#$0f
	sta	COLOR

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	crop_put_sprite_mask		; always?			; 3
								;=============
								;	  8

crop_put_sprite_bottom:
	lda	COLOR			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	cmp	#$0a
	bne	crop_put_sprite_all		; if not, skip ahead		; 2nt/3
								;=============
								;	7/8

	lda	COLOR
	and	#$f0
	sta	COLOR
	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3
								;===========
								;         5

crop_put_sprite_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 6

	jmp	crop_put_sprite_done_draw	; we are done			; 3
								;===========
								;        20

crop_put_sprite_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	  9

crop_put_sprite_done_draw:
skip_drawing:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	inx				; increment x counter		; 2
	cpx	XMAX
	bne	crop_put_sprite_pixel	; if not done, keep looping	; 2nt/3
								;==============
								;	12/13
crop_increment_y:

	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5
	dec	CV			; decemenet total y count	; 5
	bne	put_sprite_crop_loop	; loop if not done		; 2nt/3
								;==============
								;	17/18
crop_sprite_done:
	rts				; return			; 6



; 0,0 = 400+0
; -1,0 = 400+ff=4ff, inc=400

; sprite: 5x4
;
; -2,0  Xstart=0, sprite_offset=2, xsize=3
; -1,0, Xstart=0, sprite_offset=1, xsize=4
;  0,0, Xstrat=0, sprite_offset=0, xsize=5
;  1,0, Xstart=1, sprite_offset=0, xsize=5
;
; 39,0 Xstart=39, sprite_offset=0, xsize=1
;
;
;
;

	;=============================================
	; put_sprite_flipped_crop
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two

	; transparent color is $A (grey #2)
	;  this means we can have black ($0) in a sprite


put_sprite_flipped_crop:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2


	lda	(INL),Y		; byte 1 is ysize			; 5
	sta	CV		; ysize is in CV			; 3
	dey			; make Y zero again			; 2

	lda	INH		; ???
	sta	ppfc_smc+2
	clc
	lda	INL
	adc	#1		; add one (not two) because X counts
				; from CH to 1 (not CH-1 to 0)
	sta	ppfc_smc+1
	bcc	psfc16
	inc	ppfc_smc+2
psfc16:


	lda	YPOS		; make a copy of ypos			; 3

	sta	TEMPY		; as we modify it			; 3
								;===========
								;	28



put_spritefc_loop:
;	sty	TEMP		; save sprite pointer			; 3
	ldy	TEMPY							; 3

	bmi	fcrop_increment_y	; if < 0, skip to next
	cpy	#48			; bge if >= 48, done sprite
	bcs	fcrop_sprite_done


	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	clc								; 2
	adc	XPOS		; add in xpos				; 3
	sta	OUTL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	clc
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3
;	ldy	TEMP		; restore sprite pointer		; 3

				; OUTH:OUTL now points at right place

	ldx	CH		; load xsize into x			; 3
								;===========
								;	34
put_spritefc_pixel:

	clc
	txa			; want (CH-X-1)+XPOS
	eor	#$ff
	adc	CH
	adc	XPOS

	bmi	cskip_drawing
	cmp	#40

	bcs	cskip_drawing		; if off-screen right, skip draw

ppfc_smc:
	lda	$C000,X			; get sprite colors		; 5
;	iny				; increment sprite pointer	; 2
;	sty	TEMP			; save sprite pointer		; 3
	ldy	#$0							; 2

	; check if completely transparent
	; if so, skip

	cmp	#$aa			; if all zero, transparent	; 2
	beq	put_spritefc_done_draw	; don't draw it			; 2nt/3
								;==============
								;	 16/17

	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	cmp	#$a0
	bne	put_spritefc_bottom	; if not skip ahead		; 2nt/3
								;==============
								;	7/8

	lda	COLOR
	and	#$0f
	sta	COLOR

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	put_spritefc_mask	; always?			; 3
								;=============
								;	  8

put_spritefc_bottom:
	lda	COLOR			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	cmp	#$0a
	bne	put_spritefc_all		; if not, skip ahead		; 2nt/3
								;=============
								;	7/8

	lda	COLOR
	and	#$f0
	sta	COLOR
	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3
								;===========
								;         5

put_spritefc_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 6

	jmp	put_spritefc_done_draw	; we are done			; 3
								;===========
								;        20

put_spritefc_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	  9

put_spritefc_done_draw:
cskip_drawing:
;	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	dex				; decrement x counter		; 2
	bne	put_spritefc_pixel	; if not done, keep looping	; 2nt/3
								;==============
								;	12/13
fcrop_increment_y:
	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5

	lda	CH
	clc
	adc	ppfc_smc+1
	sta	ppfc_smc+1
	bcc	psfco
	inc	ppfc_smc+2
psfco:

	dec	CV			; decemenet total y count	; 5
	beq	fcrop_sprite_done	; loop if not done		; 2nt/3
	jmp	put_spritefc_loop
								;==============
								;	17/18

fcrop_sprite_done:
	rts				; return			; 6


