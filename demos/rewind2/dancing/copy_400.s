	;=========================
	; copy to 400
	;=========================
copy_to_400:


	ldx	#119
looper1:
	lda	$2000,X
	sta	$400,X

	lda	$2080,X
	sta	$480,X

	lda	$2100,X
	sta	$500,X

	lda	$2180,X
	sta	$580,X

	lda	$2200,X
	sta	$600,X

	lda	$2280,X
	sta	$680,X

	lda	$2300,X
	sta	$700,X

	lda	$2380,X
	sta	$780,X
	dex
	bpl	looper1

	rts
