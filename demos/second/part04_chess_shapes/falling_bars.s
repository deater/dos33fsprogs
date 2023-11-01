
	;==============================
	; falling bars
	;==============================
	; set X1 and X2 before calling
falling_bars:

	ldx	#0
falling_bar_outer:
	lda	gr_offsets_l,X
	sta	GBASL
	lda	gr_offsets_h,X
	sta	GBASH

	ldy	BAR_X2
	lda	#0
falling_bar_inner:
	sta	(GBASL),Y
	dey
	cpy	BAR_X1
	bne	falling_bar_inner

	lda	#50
	jsr	wait

	inx
	cpx	#24
	bne	falling_bar_outer

	rts
