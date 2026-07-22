	;=======================
	;=======================
	; twinkle (sound 914)
	;=======================
	;=======================

	; FIXME:
	; not sure if this is right
	;	originally we alternated frame high/low

	; used in
	;	918		outer/outer2/outer3 (keeper wiggle fingers)

twinkle_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_twinkle_sound

twinkle_first_note:

	lda     #NOTE_F6
        sta     speaker_frequency
        lda     #8
        sta     speaker_duration
        jsr     speaker_tone

twinkle_second_note:
        lda     #NOTE_E6
        sta     speaker_frequency
        lda     #8
        sta     speaker_duration
        jsr     speaker_tone


done_twinkle_sound:
        rts

