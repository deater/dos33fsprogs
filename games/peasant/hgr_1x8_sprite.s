
	;======================
	; hgr 1x8 draw sprite
	;======================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y*7
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
	pha

	clc
	adc	CURSOR_Y

;	ldx	#0
;	ldy	#0

	; calc GBASL/GBASH
;	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	tax
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH


	pla
	tax

	ldy	CURSOR_X

	lda	(GBASL),Y
hds_smc1:
	eor	$D000,X		; not $0000 or it will make it ZP
	sta	(GBASL),Y

	inx
	cpx	#8
	bne	hgr_1x8_sprite_yloop

	rts
