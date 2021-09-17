	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; xsize, ysize  in first two bytes

	; sprite AT INL/INH

hgr_draw_sprite:
	ldy	#0
	lda	(INL),Y
	clc
	adc	CURSOR_X
	sta	h4231_width_end_smc+1	; self modify for end of output

	iny
	lda	(INL),Y
	sta	h4231_ysize_smc+1

	; set up sprite pointers
	clc
	lda	INL
	adc	#2
	sta	h4231_smc1+1
	lda	INH
	adc	#0
	sta	h4231_smc1+2

	ldx	#0			; X is pointer offset

	stx	MASK			; actually row

hgr_42x31_sprite_yloop:

	lda	MASK			; row

	clc
	adc	CURSOR_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH

	ldy	CURSOR_X

h3231_inner_loop:

h4231_smc1:
	lda	$d000		; get sprite pattern
	sta	(GBASL),Y	; store out

	inx
	iny


	inc	h4231_smc1+1
	bne	h4231_noflo
	inc	h4231_smc1+2

h4231_noflo:

h4231_width_end_smc:
	cpy	#6
	bne	h3231_inner_loop


	inc	MASK		; row
	lda	MASK		; row

h4231_ysize_smc:
	cmp	#31
	bne	hgr_42x31_sprite_yloop

	rts

