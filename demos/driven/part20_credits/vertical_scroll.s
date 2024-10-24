
hgr_vertical_scroll:
	ldx	#0

outer_vscroll_loop:
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	sta	OUTH

	inx

	lda	hposn_low,X
	sta	INL
	lda	hposn_high,X
	sta	INH

	ldy	#39
inner_vscroll_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	bpl	inner_vscroll_loop

	cpx	#200
	bne	outer_vscroll_loop

	rts

