	;============================
	; do the pan

horiz_pan:

pan_loop:

	lda	#0
	sta	COUNT

pan_outer_outer_loop:

	ldx	#191
pan_outer_loop:

	lda	hposn_high,X
	sta	pil_smc1+2
	sta	pil_smc2+2
	sta	pil_smc4+2
	eor	#$60
	sta	pil_smc3+2

	lda	hposn_low,X
	sta	pil_smc2+1
	sta	pil_smc4+1

	sta	pil_smc1+1
	inc	pil_smc1+1
	clc
	adc	COUNT
	sta	pil_smc3+1


	ldy	#0
pan_inner_loop:

pil_smc1:
	lda	$2000+1,Y
pil_smc2:
	sta	$2000,Y

	iny
	cpy	#39
	bne	pan_inner_loop

pil_smc3:
	lda	$4000
pil_smc4:
	sta	$2000,Y

	dex
	cpx	#$ff
	bne	pan_outer_loop

;	jsr	wait_until_keypress

	inc	COUNT
	lda	COUNT
	cmp	#39

	bne	pan_outer_outer_loop

	rts
