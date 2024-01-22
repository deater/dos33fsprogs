	;======================================
	; do very simple horizontal scroll
	;======================================
	; skips by 4 because we need fairly high FPS

	; originally ~12 seconds to scroll 80 (twice)
	; made double high, ~8s

	; screens to pan in $2000/$4000 to left


horiz_pan_skip:

pan_skip_loop:

	; how many times to scroll

	lda	#0
	sta	COUNT

pan_skip_outer_outer_loop:


	ldx	#191
pan_skip_outer_loop:

	txa
	pha

	; self-modify the PAGE1 high input addresses

	lda	hposn_high,X
	sta	pil_in_smc1+2		; input source

	sta	pil_out_smc1+2		; output odd
	sta	pil_out_smc4+2

	;self modify the PAGE2 high input addresses
	eor	#$60
	sta	pil_in_page2_smc1+2


	; self modify the PAGE1 LOW addresses
	lda	hposn_low,X
	sta	pil_out_smc1+1		; output odd
	sta	pil_out_smc4+1		; output odd


	; self modify the PAGE1 LOW input addresses
	sta	pil_in_smc1+1		; input is regular+1
	inc	pil_in_smc1+1
	inc	pil_in_smc1+1
	inc	pil_in_smc1+1
	inc	pil_in_smc1+1

	; offset in PAGE2 to get input from

	clc
	adc	COUNT
	sta	pil_in_page2_smc1+1


	inx
	lda	hposn_high,X
	sta	pil_out_smc2+2		; output even high
	sta	pil_out_smc5+2

	lda	hposn_low,X		; output even low
	sta	pil_out_smc2+1
	sta	pil_out_smc5+1



	;=========================
	; inner loop, from 0-36

	ldy	#0
pan_skip_inner_loop:

	; load in+1, store to in

	; if completely unrolled, would save 1 cycle for store and
	;	5 for the branch/loop
	;	192*6=not a lot

pil_in_smc1:
	lda	$2000+1,Y					; 4
pil_out_smc1:
	sta	$2000,Y						; 5
pil_out_smc2:
	sta	$2000,Y						; 5

	iny							; 2
	cpy	#36						; 2
	bne	pan_skip_inner_loop				; 2/3

	; for right edge, scroll in from PAGE2

	ldx	#0
tail_loop:

pil_in_page2_smc1:
	lda	$4000,X
pil_out_smc4:
	sta	$2000,Y
pil_out_smc5:
	sta	$2000,Y

	iny
	inx
	cpy	#40
	bne	tail_loop


	pla
	tax

	dex
	dex
	cpx	#$ff
	bne	pan_skip_outer_loop

	inc	COUNT
	inc	COUNT
	inc	COUNT
	inc	COUNT

	lda	COUNT
	cmp	#36

	bne	pan_skip_outer_outer_loop

	rts
