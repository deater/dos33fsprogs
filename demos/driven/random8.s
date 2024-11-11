; https://wimcouwenberg.wordpress.com/2020/11/15/a-fast-24-bit-prng-algorithm-for-the-6502-processor/

random8:
	lda	rand_a		; Operation 7 (with carry clear).
	asl
	eor	rand_b
	sta	rand_b
	rol			; Operation 9.
	eor	rand_c
	sta	rand_c
	eor	rand_a		; Operation 5.
	sta	rand_a
	lda	rand_b		; Operation 15.
	ror
	eor	rand_c
	sta	rand_c
	eor	rand_b		; Operation 6.
	sta	rand_b

	rts

rand_a:	.byte 0
rand_b:	.byte 0
rand_c:	.byte 1
