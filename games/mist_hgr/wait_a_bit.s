	;====================================
	; wait for keypress or a few seconds
	;====================================

wait_a_bit:

	bit	KEYRESET
	tax

keyloop:
	lda	#200			; delay a bit
	jsr	WAIT

	lda	KEYPRESS
	bmi	done_keyloop

;	bmi	keypress_exit

	dex
	bne	keyloop

done_keyloop:

	sta	LAST_KEY

	bit	KEYRESET

	rts

