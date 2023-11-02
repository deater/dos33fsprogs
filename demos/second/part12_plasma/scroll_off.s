; note, this should scroll while still moving
; don't have time to do that

scroll_off:

	ldx	#0
scroll_off_outer_loop:

	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	#39
	lda	#00
scroll_off_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	scroll_off_inner_loop

	lda	#50
	jsr	wait

	inx
	cpx	#192
	bne	scroll_off_outer_loop

	rts
