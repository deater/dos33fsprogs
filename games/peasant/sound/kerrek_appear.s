; Oh Kerrek, where is thine sting?


	;=======================
	;=======================
	; kerrek warning sting
	;=======================
	;=======================
	; called "kerrekappear" in original

	; not sure about this one
	; GFED?
	; GEFD?
	; GEFC?
	; GFEC?
kerrek_warning_music:
	lda     #96
	sta     speaker_duration
	lda     #NOTE_G4
	sta     speaker_frequency
	jsr     speaker_tone

	lda     #48
	sta     speaker_duration
	lda     #NOTE_F4
	sta     speaker_frequency
	jsr     speaker_tone

	lda     #48
	sta     speaker_duration
	lda     #NOTE_E4
	sta     speaker_frequency
	jsr     speaker_tone

	lda     #192
	sta     speaker_duration
	lda     #NOTE_C4
	sta     speaker_frequency
	jsr     speaker_tone

	rts
