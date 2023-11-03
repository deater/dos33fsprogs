	; no page flip currently, that's hard

	; scrolls two at a time to preserve colors

horiz_scroll_left:

scroll_left_loop:

	lda	#0
	sta	COUNT

scroll_left_outer_outer_loop:

	ldx	#191				; end is 191

scroll_left_outer_loop:

	; high

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	hsl_smc1+2		; SMC1 = $2000+2
	sta	hsl_smc2+2		; SMC2 = $2000
	sta	hsl_smc4+2		; SMC4 = $2000
	sta	hsl_smc6+2		; SMC6 = $2000

	ora	#$40			; convert to $6000 range
	sta	hsl_smc3+2		; SMC3 = $6000+COUNT
	sta	hsl_smc5+2		; SMC5 = $6000+COUNT+1

	;=========================
	; low

	lda	hposn_low,X
	sta	hsl_smc2+1		; SMC2 = $2000
	sta	hsl_smc4+1		; SMC4 = $2000
	sta	hsl_smc6+1		; SMC6 = $2000

	sta	hsl_smc1+1		; SMC1 = $2000+2
	inc	hsl_smc1+1
	inc	hsl_smc1+1

	clc
	adc	COUNT

	sta	hsl_smc3+1		; SMC3 = $6000+COUNT

	sta	hsl_smc5+1		; SMC5 = $6000+COUNT+1
	inc	hsl_smc5+1

	ldy	#0
scroll_left_inner_loop:

hsl_smc1:
	lda	$2000+2,Y
hsl_smc2:
	sta	$2000,Y

	iny
	cpy	#38
	bne	scroll_left_inner_loop

	; get new data to scroll in

hsl_smc3:
	lda	$6000		; 6000+COUNT

hsl_smc4:
	sta	$2000,Y		; Y=38

	iny

hsl_smc5:
	lda	$6000+1		; 6000+COUNT+1

hsl_smc6:
	sta	$2000,Y		; Y=39



	dex
	cpx	#$FF				; end at top of screen

	bne	scroll_left_outer_loop

;	jsr	hgr_page_flip

	inc	COUNT
	inc	COUNT
	lda	COUNT
	cmp	#40
	bne	scroll_left_outer_outer_loop

	rts




