; from http://nparker.llx.com/a2/mult.html

	;=====================
	;=====================
	; 16x16 -> 32 multiply
	;=====================
	;=====================
mul16_slow:
	lda	#0		; Initialize RESULT to 0
	sta	RESULT+2
	ldx	#16		; There are 16 bits in NUM2
L1:
	lsr	NUM2+1		; Get low bit of NUM2 into C
	ror	NUM2
	bcc	L2		; 0 or 1?
	tay			; If 1, add NUM1 (hi byte of RESULT is in A)
	clc
	lda	NUM1
	adc	RESULT+2
	sta	RESULT+2
	tya
	adc	NUM1+1
L2:
	ror			; "Stairstep" shift
	ror	RESULT+2
	ror	RESULT+1
	ror	RESULT
	dex
	bne	L1
	sta	RESULT+3

	rts
