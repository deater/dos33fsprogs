	;=================================
	; fakes sines based on parabolas
	;	based on code by White Flame from codebase64
	;=================================
	; makes 256 entries, min 0 max 127

initSineTable:

	ldy	#$3f
	ldx	#$00

	; Accumulate the delta (16-bit addition)
init_sine_loop:
	lda	VALUE
	clc
	adc	DELTA
	sta	VALUE
	lda	VALUE+1
	adc	DELTA+1
	sta	VALUE+1

	; Reflect the value around for a sine wave
	sta	sine+$c0,x
	sta	sine+$80,y
	eor	#$7f
	sta	sine+$40,x
	sta	sine+$00,y

	; Increase the delta, which creates the
	; "acceleration" for a parabola

	lda	DELTA
	adc	#$08   ; this value adds up to the proper amplitude
	sta	DELTA
	bcc	init_sine_noflo
	inc	DELTA+1
init_sine_noflo:

	; Loop
	inx
	dey
	bpl	init_sine_loop

	rts


