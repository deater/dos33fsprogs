; init state

; initial state at start of game is for all vars to be 0

init_state:

	; global game state
	lda	#0
	sta	SOUND_DISABLED
	sta	JOYSTICK_ENABLED

	; game state in saves init

	lda	#$0
	ldy	#WHICH_LOAD
init_state_loop:
	sta	0,Y
	iny
	cpy	#END_OF_SAVE
	bne	init_state_loop


	; FIXME: testing

	lda	#$ff
	sta	MARKER_SWITCHES

	rts

