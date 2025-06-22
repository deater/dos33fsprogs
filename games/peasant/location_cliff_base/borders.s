; check borders when leaving

	; new location (on climb?)

	lda	#4
	sta	PEASANT_X
	lda	#170
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
exiting_cliff:
