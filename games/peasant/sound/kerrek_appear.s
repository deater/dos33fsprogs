; Oh Kerrek, where is thine sting?

	;=======================
	;=======================
	; kerrek warning sting
	;=======================
	;=======================
	; called "kerrekappear" in original
	; used in
	; (----)	425	kerrek1/kerrek2: raise up belt

	; based onn audacity "analyze/plot spectrum"

	; F5/A#3
	; D5/G3
	; E5/C5/G#3/F#4
	; F#5/D5/F4/G#4

KERREK_APPEAR_NOTES=4

kerrek_appear_notes:
.byte NOTE_F4,NOTE_D4,NOTE_E4,NOTE_D4
;.byte NOTE_F5,NOTE_D5,NOTE_E5,NOTE_FSHARP5
;.byte NOTE_ASHARP4,NOTE_G4,NOTE_GSHARP4,NOTE_GSHARP3


	; duration
	; assuming 255 means 0.5s
	; seems more likely 255 means 0.5s

	; 50ms (255*.05=13)*2
	; 80ms (255*.08 =20)*2

kerrek_appear_lengths:
	.byte	36	; .150 - .220 = 70ms
	.byte	54	; .260 - .370 = 110ms
	.byte	36	; .410 - .480 = 70ms
	.byte	255	; .530 - 1.370 = 840ms	; 428?

	; use the apple II wait function
	;  use reverse_wait program
kerrek_appear_delay:
	.byte	123	; .220 - .260 = 40ms
	.byte	123	; .370 - .410 = 40ms
	.byte	138	; .480 - .530 = 50ms
	.byte	0	; 0


kerrek_warning_music:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_kerrek_appear_sound

	ldx	#0

kerrek_appear_loop:
	txa
	pha

	lda     kerrek_appear_notes,X
	sta     speaker_frequency
	lda     kerrek_appear_lengths,X
	sta	speaker_duration
	jsr     speaker_tone

	pla
	tax

	lda	kerrek_appear_delay,X
	jsr	wait

	inx
	cpx	#KERREK_APPEAR_NOTES
	bne	kerrek_appear_loop

done_kerrek_appear_sound:

	rts





;======================================================
; old

.if 0
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
.endif
