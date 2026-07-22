	;=======================
	;=======================
	; bullseye
	;=======================
	;=======================

	; used in
	;        954	trogdor (thrown sword hits him)
	; (done)	target (bullseye)

bullseye_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_bullseye_sound


	; 600/1200

	lda	#NOTE_D5
	sta	speaker_frequency

	lda	#30
	sta	speaker_duration

	jsr	speaker_tone

	lda	#100
	jsr	wait

	lda	#NOTE_D6
	sta	speaker_frequency

	lda	#60
	sta	speaker_duration

	jsr	speaker_tone


done_bullseye_sound:
        rts





