;=============================
; elevator1 handle pulled

; FIXME: check for water power
; FIXME: animate
elev1_handle:

	; click speaker
	bit	SPEAKER

	; check for water power

	; go to bottom floor, which involves moving to CHANNEL level

	lda	#CHANNEL_IN_ELEV1_CLOSED
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#LOAD_CHANNEL
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts


	;=========================
	; close elevator1 door
elev1_close_door:

	lda	#ARBOR_INSIDE_ELEV1
	sta	LOCATION
	jmp	change_location


