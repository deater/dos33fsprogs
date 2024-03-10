
	;=====================
	; init vars
	;=====================
init_vars:
	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	DISP_PAGE
	sta	JOYSTICK_ENABLED
	sta	KEEN_WALKING
	sta	KEEN_JUMPING
	sta	LEVEL_OVER
	sta	LASER_OUT
	sta	KEEN_XL
	sta	SCORE0
	sta	SCORE1
	sta	SCORE2
	sta	KEEN_FALLING
	sta	KEEN_SHOOTING
	sta	KICK_UP_DUST
	sta	DOOR_ACTIVATED
	sta	INVENTORY

	lda	#1
	sta	FIREPOWER

	lda	#7
	sta	HEALTH

	rts
