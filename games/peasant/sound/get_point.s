	;=======================
	;=======================
	; get point
	;=======================
	;=======================

	; happens when get points

get_point_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_get_point_sound

	;===========================
	; weep-boom sound

	lda	#32
	sta	speaker_duration
	lda	#NOTE_E5
	sta	speaker_frequency
	jsr	speaker_tone
	lda	#64
	sta	speaker_duration
	lda	#NOTE_F5
	sta	speaker_frequency
	jsr	speaker_tone
	lda	#128
	sta	speaker_duration
	lda	#NOTE_F4
	sta	speaker_frequency
	jsr	speaker_tone

done_get_point_sound:

	rts

