	;=======================
	;=======================
	; guitar song (sound 408)
	;=======================
	;=======================

	; used in
	; (----)	425	outer2: once have guitar


guitar_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_guitar_sound

done_guitar_sound:
        rts

