	;=======================
	;=======================
	; arrow_shoot
	;=======================
	;=======================

	; used in
	;	776	location_well (bucket going down)
	;		target (arrow shoot)

arrow_shoot_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_arrow_shoot_sound

;launch_sound:

	lda	#NOTE_A4		; 440
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

	lda	#NOTE_G4		; 400
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

	lda	#NOTE_E4		;
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

	lda	#NOTE_C4		;
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

	lda	#NOTE_G5		; 800
	sta	speaker_frequency
	lda	#30
	sta	speaker_duration
	jsr	speaker_tone

done_arrow_shoot_sound:
        rts
