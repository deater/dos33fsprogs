
	;======================
	; hgr 1x5 draw sprite
	;======================
	; over-writes
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y*7
	; X, Y, A trashed

hgr_draw_sprite_1x5:

	; set up pointers
	lda	INL
	sta	h1x5_smc1+1
	lda	INH
	sta	h1x5_smc1+2

	ldx	#0
hgr_1x5_sprite_yloop:
	txa				; row
	clc
	adc	CURSOR_Y		; add in y offset

	; calc GBASL/GBASH from lookup table

	tay
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH

	ldy	CURSOR_X

h1x5_smc1:
	lda	$D000,X		; not $0000 or it will make it ZP
	sta	(GBASL),Y

	inx
	cpx	#5
	bne	hgr_1x5_sprite_yloop

	rts
