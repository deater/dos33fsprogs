
	;=====================
	; init vars
	;=====================
init_vars:
	lda	#0
	sta	FRAMEL
	sta	FRAMEH
	sta	DISP_PAGE
	sta	JOYSTICK_ENABLED
	sta	LEVEL_OVER

	rts
