	; clear the bottom of the screen where the text goes
	; clear to #$00 (black0)
	; clear from 183-191?
	; use DRAW_PAGE

clear_bottom:

	ldx	#183
clear_bottom_yloop:

	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	lda	#0
	ldy	#39
clear_bottom_xloop:

	sta	(GBASL),Y

	dey
	bpl	clear_bottom_xloop

	inx
	cpx	#192
	bne	clear_bottom_yloop

	rts
