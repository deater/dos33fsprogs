	;======================
	; hgr 2x16 draw sprite
	;======================
	; Note: NOT TRANSPARENT
	;
	; SPRITE in INL/INH
	; Location at CURSOR_X*7 CURSOR_Y
	; X, Y, A trashed

hgr_draw_sprite_2x16:

	; set up pointers
	lda	INL
	sta	hds2_smc1+1
	lda	INH
	sta	hds2_smc1+2

	ldx	#0
hgr_2x16_sprite_yloop:
	txa
	pha

	clc
	adc	CURSOR_Y

	tax
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	pla
	tax

	ldy	CURSOR_X
hds2_smc1:
	lda	$D000
	sta	(GBASL),Y

	inx
	cpx	#16
	bne	hgr_2x16_sprite_yloop

	rts
