	;=========================
	; copy to 400
	;=========================
	; X is page to copy from
copy_to_400:

	stx	c400_smc1+2
	stx	c400_smc2+2
	inx
	stx	c400_smc3+2
	stx	c400_smc4+2
	inx
	stx	c400_smc5+2
	stx	c400_smc6+2
	inx
	stx	c400_smc7+2
	stx	c400_smc8+2

	ldx	#119
looper1:

c400_smc1:
	lda	$2000,X
	sta	$400,X

c400_smc2:
	lda	$2080,X
	sta	$480,X

c400_smc3:
	lda	$2100,X
	sta	$500,X

c400_smc4:
	lda	$2180,X
	sta	$580,X

c400_smc5:
	lda	$2200,X
	sta	$600,X

c400_smc6:
	lda	$2280,X
	sta	$680,X

c400_smc7:
	lda	$2300,X
	sta	$700,X

c400_smc8:
	lda	$2380,X
	sta	$780,X
	dex
	bpl	looper1

	rts
