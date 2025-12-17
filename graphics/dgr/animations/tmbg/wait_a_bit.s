	;======================================
	; delay some time (multiple of 50ms)
	;======================================
	; to wait 50ms its approximately 139?

wait_50ms_sound:
	ldx	#1
wait_50xms2:

wait_50_loop:

	jsr	draw_sound_bars

	lda	#139
	jsr	wait
	dex
	bne	wait_50_loop

	rts


	;=======================================================
	; wait for multiple of 50ms, but exit early if keypress
	;=======================================================
	; X * 50ms is wait
	; A/X trashed

wait_a_bit2:

	bit	KEYRESET

keyloop:
	lda	#139			; delay a bit
	jsr	wait

	lda	KEYPRESS
	bmi	done_keyloop

	dex
	bne	keyloop

done_keyloop:
	bit	KEYRESET

	rts

;.assert (>wait_end - >wait) < 1 , error, "wait crosses page boundary"
