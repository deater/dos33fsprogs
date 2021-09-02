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

	; left masks
	;	in memory	on screen
	;	x111 1111	1111111		start at 0
	;	x111 1110	0111111		start at 1
	;	x111 1100	0011111		start at 2
	; ...
	;	x100 0000	0000001		start at 6

left_masks:
	.byte $FF,$FE,$FC,$F8, $F0,$E0,$C0

	; right masks
	;	in memory	on screen
	;	x000 0001	1000000		end at 0
	;	x000 0011	1100000		end at 1
	;	x000 0111	1110000		end at 2
	; ...
	;	x011 1111	1111110		end at 5
	;	x111 1111	1111111		end at 6
right_masks:
	.byte $81,$83,$87, $8F,$9F,$BF,$FF


