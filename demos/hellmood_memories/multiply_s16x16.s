
	;==========================
	; Signed 16x16=32 multiply
	;==========================
	; multiplies NUM1H:NUM1L by NUM2H:NUM2L
	; result in RESULT3:RESULT2:RESULT1:RESULT0

multiply_s16x16:

	; check if we need to invert result, save for later
	lda	NUM1H
	eor	NUM2H
	php


	; if NUM1 negative, invert it
	lda	NUM1H
	bpl	num1_positive

	sec
	lda	#0
	sbc	NUM1L
	sta	NUM1L
	lda	#0
	sbc	NUM1H
	sta	NUM1H

num1_positive:

	; if NUM2 negative, invert it

	lda	NUM2H
	bpl	num2_positive

	sec
	lda	#0
	sbc	NUM2L
	sta	NUM2L
	lda	#0
	sbc	NUM2H
	sta	NUM2H
num2_positive:

	jsr	multiply_u16x16


	; done, see if we need to negate

	plp
	bpl	done_s16x16

	sec
	lda	#0
	sbc	RESULT0
	sta	RESULT0
	lda	#0
	sbc	RESULT1
	sta	RESULT1
	lda	#0
	sbc	RESULT2
	sta	RESULT2
	lda	#0
	sbc	RESULT3
	sta	RESULT3

done_s16x16:

	rts
