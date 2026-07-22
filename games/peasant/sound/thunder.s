	;=======================
	;=======================
	; thunder (sound 34)
	;=======================
	;=======================

	; used in
	; (----)	36	cliff: rock smash to pieces
	; (----)	39	cliff: rock smash to pieces
	; (----)	40	cliff: rock smash to pieces
	; (Done)	677	rainsound/thunder?  repeated 3 times?
	; (----)	742	location_gary
	; (----)		gary hooves down
	; (----)		gary smash fence
	; (done)	897	location_cliff_heighs: lightning/thunder
	; (done)	898	location_cliff_heights: lightning/thunder

thunder_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_thunder_sound

	; from original lightning code

	lda	#8
	sta	speaker_duration
	lda	#NOTE_G3
	sta	speaker_frequency
	jsr	speaker_tone

done_thunder_sound:
        rts

