	;=========================
	; copy to 400
	;=========================
	; X is page to copy from

copy_to_400_aux:
	sta	RDAUX
	sta	WRAUX

copy_to_400_main:


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

	lda	DRAW_PAGE
	clc
	adc	#$4
	tax
	stx	c400_smc9+2
	stx	c400_smc10+2
	inx
	stx	c400_smc11+2
	stx	c400_smc12+2
	inx
	stx	c400_smc13+2
	stx	c400_smc14+2
	inx
	stx	c400_smc15+2
	stx	c400_smc16+2

;	rts

;copy_to_400:
	ldx	#119
looper1:

c400_smc1:
	lda	$2000,X
c400_smc9:
	sta	$400,X

c400_smc2:
	lda	$2080,X
c400_smc10:
	sta	$480,X

c400_smc3:
	lda	$2100,X
c400_smc11:
	sta	$500,X

c400_smc4:
	lda	$2180,X
c400_smc12:
	sta	$580,X

c400_smc5:
	lda	$2200,X
c400_smc13:
	sta	$600,X

c400_smc6:
	lda	$2280,X
c400_smc14:
	sta	$680,X

c400_smc7:
	lda	$2300,X
c400_smc15:
	sta	$700,X

c400_smc8:
	lda	$2380,X
c400_smc16:
	sta	$780,X

	dex
	bpl	looper1

	sta	RDMAIN
	sta	WRMAIN

	rts
