	;=================================================
	; M1 * M2
multiply_s8x8:

	lda	M2
	eor	M1		; calc if we need to adjust at end
				; (++ vs +- vs -+ vs --)
	php			; save status on stack

	; if M1 negative, negate it
	lda	M1
	bpl	m1_positive
	eor	#$ff
	clc
	adc	#0
m1_positive:
	sta	M1

	; if M2 negative, naegate it
	lda	M2
	bpl	m2_positive
	eor	#$ff
	clc
	adc	#0
m2_positive:
	sta	M2

	;==================
	; unsigned multiply

	jsr	multiply_u8x8


	; done, high result in factor2, low result in factor1

	; adjust to be signed
	; if m1 and m2 positive, good
	; if m1 and m2 negative, good
	; otherwise, negate result

	plp			; restore saved pos/neg value
	bpl	done_result
negate_result:
	sec
	lda	#0
	sbc	M1
	lda	#0
	sbc	M2
done_result:
	sta	M2

	rts

