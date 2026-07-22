	;=======================
	;=======================
	; earthquake (sound 938)
	;=======================
	;=======================

	; used in
	; (----)	954	trogdor (flames)

earthquake_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_earthquake_sound

done_earthquake_sound:
        rts

