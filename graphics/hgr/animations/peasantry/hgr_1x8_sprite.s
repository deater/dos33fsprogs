	;======================================
	; hgr 1x8 draw sprite XOR
	;======================================
	; mostly used for text print routines
	;======================================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y*7
	; Draws to page indicated by DRAW_PAGE
	; X, Y, A trashed

hgr_draw_sprite_1x8:

	; set up pointers
	lda	INL
	sta	hds_smc1+1
	lda	INH
	sta	hds_smc1+2

	ldx	#0
hgr_1x8_sprite_yloop:
	txa

	clc
	adc	CURSOR_Y	; calculate row

	tay			; get co-ords for it
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	CURSOR_X

	lda	(GBASL),Y
hds_smc1:
	eor	$D000,X		; not $0000 or it will make it ZP

invert_smc1:
	eor	#$00		; invert

	sta	(GBASL),Y

	inx
	cpx	#8
	bne	hgr_1x8_sprite_yloop

	rts
