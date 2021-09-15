	;===============================
	; hgr 42x31 draw sprite
	;===============================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; sprite AT INL/INH

hgr_draw_sprite_42x31:

	; set up sprite pointers
	lda	INL
	sta	h4231_smc1+1
	lda	INH
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
	tya
	clc
	adc	#6
	sta	h4231_width_smc+1

h3231_inner_loop:

h4231_smc1:
	lda	$d000,X		; or in sprite
	sta	(GBASL),Y	; store out

	inx
	iny

h4231_width_smc:
	cpy	#6
	bne	h3231_inner_loop


	inc	MASK		; row
	lda	MASK		; row

	cmp	#31
	bne	hgr_42x31_sprite_yloop

	rts

