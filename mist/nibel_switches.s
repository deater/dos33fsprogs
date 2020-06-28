

;=============================
;=============================
; elevator2 handle pulled
;=============================
;=============================


; FIXME: check for water power
; FIXME: animate
elevator2_handle:

	; click speaker
	bit	SPEAKER

	; check for water power

	lda	#ARBOR_INSIDE_ELEV2_CLOSED
	sta	LOCATION

	lda	#LOAD_ARBOR
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts


;=========================
;=========================
; close elevator2 door
;=========================
;=========================

elevator2_close_door:

	lda	#NIBEL_IN_ELEV2_TOP_CLOSED
	sta	LOCATION
	jmp	change_location



