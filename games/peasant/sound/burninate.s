	;=======================
	;=======================
	; burninate (sound 947)
	;=======================
	;=======================

	; used in
	; (----)	954	trogdor (flames)

burninate_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_burninate_sound

done_burninate_sound:
        rts

