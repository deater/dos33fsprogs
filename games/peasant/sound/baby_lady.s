	;=======================
	;=======================
	; baby lady gone
	;=======================
	;=======================
	; beep boop bop

	; 	note 1		note2		note3
	; 	0.15-0.220	0.28-0.38	0.5-0.9
	; sox	825Hz (G#5)	1026Hz (C6)	1068Hz (C#6?)
	; ear	C6		F#5		C5

	; used in
	;	425
	; (done)	haystack blows away
	; (done)	lady_cottage: when lady goes away after give riches

baby_lady_gone_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_baby_lady_sound

	lda     #36		; 70ms (255*.07=18)
	sta     speaker_duration
	lda     #NOTE_C5
	sta     speaker_frequency
	jsr     speaker_tone

	lda	#152		; 60ms
	jsr	wait


	lda     #50		; 100ms (255/10=25)
	sta     speaker_duration
	lda     #NOTE_FSHARP4
	sta     speaker_frequency
	jsr     speaker_tone

	lda	#216		; 120ms
	jsr	wait

	lda     #255		; 400ms
	sta     speaker_duration
	lda     #NOTE_C4
	sta     speaker_frequency
	jsr     speaker_tone


done_baby_lady_sound:
        rts

