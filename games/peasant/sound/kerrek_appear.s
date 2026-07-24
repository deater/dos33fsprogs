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


	; using sox stat
	;	.150-.200	.260-.360   .400-.480	.530-.1300
	;	869 		1092		1127	1086
	;	A5?		C#6		D6?	C#6

	;	700		600		700	600or780
	;	F5		D#5		F5



	; F5/E5 believable
	; C5 believable
	; F4
	; F4

	; length: 50, 100, 80, 500

	; using spectrogram
	;	700, 580, 660, 580?
	;	F5,D5,E5,D5
	;	700  580  720  580
kerrek_warning_music:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_kerrek_appear_sound

	lda     #25		; 50ms (255/20=13)
	sta     speaker_duration
	lda     #NOTE_DSHARP5
	sta     speaker_frequency
	jsr     speaker_tone

	lda	#150		; 60ms
	jsr	wait


	lda     #50		; 100ms (255/10=25)
	sta     speaker_duration
	lda     #NOTE_C5
	sta     speaker_frequency
	jsr     speaker_tone

	lda	#125		; 40ms
	jsr	wait

	lda     #40			; 80ms (255*.08 =20)
	sta     speaker_duration
	lda     #NOTE_F4
	sta     speaker_frequency
	jsr     speaker_tone

	lda	#133		; 50ms
	jsr	wait

	lda     #255
	sta     speaker_duration
	lda     #NOTE_F4
	sta     speaker_frequency
	jsr     speaker_tone

done_kerrek_appear_sound:

	rts
