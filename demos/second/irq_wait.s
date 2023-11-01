	; wait A * 1 50Hz tick
wait_ticks:
        sta     IRQ_COUNTDOWN
wait_tick_loop:
	lda	IRQ_COUNTDOWN
	bne	wait_tick_loop
wait_tick_done:
	rts


wait_seconds:
	tax

wait_seconds_loop:
	lda	#50		; wait 1s
	jsr	wait_ticks

	lda	KEYPRESS
	bmi	wait_seconds_done

	dex
	bpl	wait_seconds_loop
wait_seconds_done:
	bit	KEYRESET
	rts
