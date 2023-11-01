	;====================================
	; Note: just does top part of screen
	;====================================
	; 16 ... 80
	; just one step
	; always scrolls in black

horiz_scroll_left:

;scroll_left_loop:
;
;	lda	#0
;	sta	COUNT

scroll_left_outer_outer_loop:

	ldx	#80				; end is 80

scroll_left_outer_loop:

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	hsl_smc1+2
	sta	hsl_smc2+2
	sta	hsl_smc4+2
;	eor	#$60
;	sta	hsl_smc3+2

	lda	hposn_low,X
	sta	hsl_smc2+1
	sta	hsl_smc4+1

	sta	hsl_smc1+1
	inc	hsl_smc1+1
;	clc
;	adc	COUNT
;	sta	hsl_smc3+1


	ldy	#0
scroll_left_inner_loop:

hsl_smc1:
	lda	$2000+1,Y
hsl_smc2:
	sta	$2000,Y

	iny
	cpy	#39
	bne	scroll_left_inner_loop

;hsl_smc3:
;	lda	$4000

	lda	#$0			; always scroll in black
hsl_smc4:
	sta	$2000,Y

	dex
	cpx	#15				; end at 16

	bne	scroll_left_outer_loop


;	inc	COUNT
;	lda	COUNT
;	cmp	#39
;	bne	scroll_left_outer_outer_loop

	rts







	;====================================
	; Note: just does top part of screen
	;====================================
	; 16 ... 80
	; just one step
	; always scrolls in black

horiz_scroll_right:

;scroll_right_loop:
;
;	lda	#0
;	sta	COUNT

scroll_right_outer_outer_loop:

	ldx	#80				; end is 80

scroll_right_outer_loop:

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	hsr_smc1+2
	sta	hsr_smc2+2
	sta	hsr_smc4+2

	lda	hposn_low,X
	sta	hsr_smc1+1
	sta	hsr_smc4+1

	sta	hsr_smc2+1
	inc	hsr_smc2+1


	ldy	#38
scroll_right_inner_loop:

hsr_smc1:
	lda	$2000,Y
hsr_smc2:
	sta	$2000+1,Y

	dey
	bpl	scroll_right_inner_loop

	lda	#$0			; always scroll in black
	iny
hsr_smc4:
	sta	$2000,Y

	dex
	cpx	#15				; end at 16

	bne	scroll_right_outer_loop


;	inc	COUNT
;	lda	COUNT
;	cmp	#39
;	bne	scroll_right_outer_outer_loop

	rts

