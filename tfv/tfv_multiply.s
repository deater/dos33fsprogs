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

	lda	#$0							; 2
	sta	NEGATE							; 4

	; Handle Signed
	lda	NUM1H							; 4
	bpl	check_num2						; 2nt/3

	inc	NEGATE							; 4

	clc		; 2s-complement NUM1H/NUM1L			; 2
	lda	NUM1L							; 4
	eor	#$ff							; 2
	adc	#$1							; 2
	sta	NUM1L							; 4

	lda	NUM1H							; 4
	eor	#$ff							; 2
	adc	#$0							; 2
	sta	NUM1H							; 4

check_num2:
	lda	NUM2H							; 4
	bpl	unsigned_multiply					; 2nt/3

	inc	NEGATE							; 4

	clc								; 2
	lda	NUM2L							; 4
	eor	#$ff							; 2
	adc	#$1							; 2
	sta	NUM2L							; 4

	lda	NUM2H							; 4
	eor	#$ff							; 2
	adc	#$0							; 2
	sta	NUM2H							; 4

unsigned_multiply:

	lda	#0		; Initialize RESULT to 0		; 2
	sta 	RESULT+2						; 4
	ldx	#16		; 16x16 multiply			; 2
multiply_mainloop:
	lsr	NUM2H		; Shift right 16-bit NUM2		; 6
	ror	NUM2L		; low bit goes into carry		; 6
	bcc	shift_output	; 0 or 1?				; 2nt/3
	tay			; If 1, add NUM1 (hi byte RESULT in A)	; 2
	clc								; 2
	lda	NUM1L							; 4
	adc	RESULT+2						; 4
	sta	RESULT+2						; 4
	tya								; 2
	adc	NUM1H							; 4
shift_output:
	ror	A		; "Stairstep" shift			; 2
	ror	RESULT+2						; 6
	ror	RESULT+1						; 6
	ror	RESULT							; 6
	dex								; 2
	bne	multiply_mainloop					; 2nt/3
	sta	RESULT+3						; 4

	;; Negate if necessary

	lda	NEGATE							; 4
	and	#$1							; 2
	beq	positive						; 2nt/3

	clc								; 2
	lda	RESULT+0						; 4
	eor	#$ff							; 2
	adc	#$1							; 2
	sta	RESULT+0						; 4

	lda	RESULT+1						; 4
	eor	#$ff							; 2
	adc	#$0							; 2
	sta	RESULT+1						; 4

	lda	RESULT+2						; 4
	eor	#$ff							; 2
	adc	#$0							; 2
	sta	RESULT+2						; 4

	lda	RESULT+3						; 4
	eor	#$ff							; 2
	adc	#$0							; 2
	sta	RESULT+3						; 4

positive:

	rts								; 6

