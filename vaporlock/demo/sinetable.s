	;=================================
	; fakes sines based on parabolas
	;	based on code by White Flame via Cruzer/Camelot
	;		from codebase64
	;=================================
	; makes 256 entries, min 0 max 127
	; call with X=0!

;DELTA = $2000
;VALUE = $2002

initSineTable:

	ldy	#$3f
;	ldx	#$00

	; Accumulate the delta (16-bit addition)
init_sine_loop:

value_l_smc:
	lda	#0
	clc
	adc	DELTA
	sta	value_l_smc+1
value_h_smc:
	lda	#0
	adc	DELTA+1
	sta	value_h_smc+1

	; Reflect the value around for a sine wave
	sta	sine+$c0,X
	sta	sine+$80,Y
	eor	#$7f
	sta	sine+$40,X
	sta	sine+$00,Y

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

;	rts


