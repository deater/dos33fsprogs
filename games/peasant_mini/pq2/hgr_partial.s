; copy partial part of screen from $6000 to DRAW_PAGE
	; HGR_X1,HGR_Y1 to HGR_X2,HGR_Y2 source
	; destination = Y at HGR_DEST

hgr_partial:
	lda	HGR_DEST
	sta	dest_y_smc+1

	ldx	HGR_Y1		; Y1
hgr_partial_outer_loop:
	lda	hposn_low,X
	sta	INL
	lda	hposn_high,X
	ora	#$40		; convert to $6000
	sta	INH

	txa
	pha

dest_y_smc:
	ldx	#100		; DEST_Y
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	pla
	tax

	ldy	HGR_X1		; X1
hgr_partial_inner_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	cpy	HGR_X2		; X2
	bne	hgr_partial_inner_loop

	inc	dest_y_smc+1

	inx
	cpx	HGR_Y2		; Y2
	bne	hgr_partial_outer_loop

	rts
