	;====================================
	; wait for keypress or a few seconds
	;====================================
	; A is length to wait

wait_a_bit:

	bit	KEYRESET
	tax

keyloop:
	lda	#200			; delay a bit
	jsr	WAIT

	lda	KEYPRESS
	bmi	done_keyloop

	dex
	bne	keyloop
	beq	no_escape

done_keyloop:

	and	#$7f
	cmp	#27
	bne	no_escape

	inc	ESC_PRESSED
no_escape:

	bit	KEYRESET

	rts




