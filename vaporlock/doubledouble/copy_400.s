	;=========================
	; copy to 400
	;=========================
copy_to_400:


	ldx	#119
looper1:
	lda	$c00,X
	sta	$400,X

	lda	$c80,X
	sta	$480,X

	lda	$d00,X
	sta	$500,X

	lda	$d80,X
	sta	$580,X

	lda	$e00,X
	sta	$600,X

	lda	$e80,X
	sta	$680,X

	lda	$f00,X
	sta	$700,X

	lda	$f80,X
	sta	$780,X
	dex
	bpl	looper1

	rts
