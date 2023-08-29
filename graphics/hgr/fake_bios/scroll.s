	;================================
	;================================
	;================================
	;================================
scroll_screen:
	ldx	#8
	stx	INL
	ldx	#0
	stx	OUTL

scroll_yloop:
	ldx	INL
	lda	hposn_low,X
	sta	xloop_smc1+1
	lda	hposn_high,X
	sta	xloop_smc1+2

	ldx	OUTL
	lda	hposn_low,X
	sta	xloop_smc2+1
	lda	hposn_high,X
	sta	xloop_smc2+2

	ldy	#39
scroll_xloop:
xloop_smc1:
	lda	$2000,Y
xloop_smc2:
	sta	$2000,Y
	dey
	bpl	scroll_xloop

	inc	INL
	inc	OUTL

	lda	INL
	cmp	#192
	bne	scroll_yloop

	; blank bottom line


	lda	#$00
	ldy	#39
scroll_hline_xloop:
	sta	$23D0,Y
	sta	$27D0,Y
	sta	$2BD0,Y
	sta	$2FD0,Y
	sta	$33D0,Y
	sta	$37D0,Y
	sta	$3BD0,Y
	sta	$3FD0,Y
	dey
	bpl	scroll_hline_xloop

	rts

