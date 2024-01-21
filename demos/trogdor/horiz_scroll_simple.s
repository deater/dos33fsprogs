	;======================================
	; do very simple horizontal scroll
	;======================================
	; screens to pan in $2000/$4000 to left


horiz_pan:

pan_loop:

	; how many times to scroll

	lda	#0
	sta	COUNT

pan_outer_outer_loop:

	; do all 191 lines

	ldx	#191
pan_outer_loop:

	; self-modify the PAGE1 high addresses

	lda	hposn_high,X
	sta	pil_smc1+2
	sta	pil_smc2+2
	sta	pil_smc4+2

	;self modify the PAGE2 high addresses
	eor	#$60
	sta	pil_smc3+2

	; self modify the PAGE1 LOW addresses
	lda	hposn_low,X
	sta	pil_smc2+1
	sta	pil_smc4+1

	; self mofidy the PAGE1 LOW input addresses
	sta	pil_smc1+1
	inc	pil_smc1+1


	clc
	adc	COUNT
	sta	pil_smc3+1


	;=========================
	; inner loop, from 0-39

	ldy	#0
pan_inner_loop:

	; load in+1, store to in

	; if completely unrolled, would save 1 cycle for store and
	;	5 for the branch/loop
	;	192*6=not a lot

pil_smc1:
	lda	$2000+1,Y					; 4
pil_smc2:
	sta	$2000,Y						; 5

	iny							; 2
	cpy	#39						; 2
	bne	pan_inner_loop					; 2/3

	; for right edge, scroll in from PAGE2

pil_smc3:
	lda	$4000
pil_smc4:
	sta	$2000,Y

	dex
	cpx	#$ff
	bne	pan_outer_loop

	inc	COUNT
	lda	COUNT
	cmp	#39

	bne	pan_outer_outer_loop

	rts
