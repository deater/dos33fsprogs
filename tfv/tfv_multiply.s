; http://www.llx.com/~nparker/a2/mult.html
; MULTIPLY NUM1H:NUM1L * NUM2H:NUM2L
; NUM2 is zeroed out
; result is in RESULT3:RESULT2:RESULT1:RESULT0

NUM1L:	.byte 0
NUM1H:	.byte 0
NUM2L:	.byte 0
NUM2H:	.byte 0
RESULT:	.byte 0,0,0,0
NEGATE:	.byte 0

; If we have 2k to spare we should check out
; http://codebase64.org/doku.php?id=base:seriously_fast_multiplication

multiply:

	lda	#$0
	sta	NEGATE

	; Handle Signed
	lda	NUM1H
	bpl	check_num2

	inc	NEGATE

	clc
	lda	NUM1L
	eor	#$ff
	adc	#$1
	sta	NUM1L

	lda	NUM1H
	eor	#$ff
	adc	#$0
	sta	NUM1H

check_num2:
	lda	NUM2H
	bpl	unsigned_multiply

	inc	NEGATE

	clc
	lda	NUM2L
	eor	#$ff
	adc	#$1
	sta	NUM2L

	lda	NUM2H
	eor	#$ff
	adc	#$0
	sta	NUM2H

unsigned_multiply:

	lda	#0		; Initialize RESULT to 0
	sta 	RESULT+2
	ldx	#16		; 16x16 multiply
multiply_mainloop:
	lsr	NUM2H		; Shift right 16-bit NUM2
	ror	NUM2L		; low bit goes into carry
	bcc	shift_output	; 0 or 1?
	tay			; If 1, add NUM1 (hi byte of RESULT is in A)
	clc
	lda	NUM1L
	adc	RESULT+2
	sta	RESULT+2
	tya
	adc	NUM1H
shift_output:
	ror	A		; "Stairstep" shift
	ror	RESULT+2
	ror	RESULT+1
	ror	RESULT
	dex
	bne	multiply_mainloop
	sta	RESULT+3

	;; Negate if necessary

	lda	NEGATE
	and	#$1
	beq	positive

	clc
	lda	RESULT+0
	eor	#$ff
	adc	#$1
	sta	RESULT+0

	lda	RESULT+1
	eor	#$ff
	adc	#$0
	sta	RESULT+1

	lda	RESULT+2
	eor	#$ff
	adc	#$0
	sta	RESULT+2

	lda	RESULT+3
	eor	#$ff
	adc	#$0
	sta	RESULT+3

positive:

	rts

