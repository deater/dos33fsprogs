; approx sine

; uses two parabolas to approximate sine
; see https://codebase64.org/doku.php?id=base:generating_approximate_sines_in_assembly

VALUE_L	= $F0
VALUE_H	= $F1
DELTA_L = $F2
DELTA_H = $F3



approx_sine:


initSineTable:

	ldy	#$3f
	ldx	#$00
	stx	VALUE_L
	stx	VALUE_H
	stx	DELTA_L
	stx	DELTA_H


	; Accumulate the delta (normal 16-bit addition)

outer_loop:
	lda	VALUE_L
	clc
	adc	DELTA_L
	sta	VALUE_L
	lda	VALUE_H
	adc	DELTA_H
	sta	VALUE_H

	; Reflect the value around for a sine wave

	sta	sinetable+$c0,X
	sta	sinetable+$80,Y
	eor	#$ff
	sta	sinetable+$40,X
	sta	sinetable+$00,Y

	; Increase the delta, which creates the "acceleration" for a parabola
	lda	DELTA_L
	adc	#$10   ; this value adds up to the proper amplitude
	sta	DELTA_L
	bcc	skip_oflo
	inc	DELTA_H
skip_oflo:
	; Loop
	inx
	dey
	bpl	outer_loop

end:
	jmp	end

sinetable=$6000
