; check borders when leaving

	; new location (on climb?)

	lda	#4
	sta	PEASANT_X
	lda	#170
	sta	PEASANT_Y

	jsr	stop_walking

exiting_cliff:
