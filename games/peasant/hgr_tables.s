div7_table	= $b800
mod7_table	= $b900
hposn_high	= $ba00
hposn_low	= $bb00



	;=====================
	; make /7 %7 tables
	;=====================

hgr_make_tables:

	ldy	#0
	lda	#0
	ldx	#0
div7_loop:
	sta	div7_table,Y

	inx
	cpx	#7
	bne	div7_not7

	clc
	adc	#1
	ldx	#0
div7_not7:
	iny
	bne	div7_loop


	ldy	#0
	lda	#0
mod7_loop:
	sta	mod7_table,Y
	clc
	adc	#1
	cmp	#7
	bne	mod7_not7
	lda	#0
mod7_not7:
	iny
	bne	mod7_loop


	; Hposn table

	lda	#0
hposn_loop:
	ldy	#0
	ldx	#0
	pha
	jsr	HPOSN	; (Y,X),(A)
	pla
	tax

	lda	GBASL
	sta	hposn_low,X

	lda	GBASH
	sta	hposn_high,X

	inx
	txa

	cmp	#192
	bne	hposn_loop

	rts

left_masks:
	.byte $FF,$FE,$FC,$F8, $F0,$E0,$C0

right_masks:
	.byte $81,$83,$87, $8F,$9F,$BF,$FF


