	;=====================================
	; TODO: actually implement walking to

	; move peasant to X,Y
peasant_walkto:

peasant_walkto_done:
	stx	PEASANT_X
	sty	PEASANT_Y

	rts
