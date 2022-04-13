update_timer:
	jsr	update_explosion_timer

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	bne	timer_mockingboard

	; if no mockingboard, then
	; fake timer count so clocks tick

	lda	TIMER_COUNT
	clc
	adc	#7
	sta	TIMER_COUNT

timer_mockingboard:
	lda	TIMER_COUNT
	cmp	#50
	bcc	timer_not_yet

	jsr	update_time

	lda	#$0
	sta	TIMER_COUNT
timer_not_yet:
	rts
