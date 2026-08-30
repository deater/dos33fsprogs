	;=======================
	;=======================
	; baby lady gone
	;=======================
	;=======================

	; used in
	;	425
	; (done)	haystack blows away
	; (done)	lady_cottage: when lady goes away after give riches

	; beep boop bop

	; based onn audacity "analyze/plot spectrum"

	; C5, D4, E5/G4/C3

BABY_LADY_NOTES=3

baby_lady_notes:
	; can't do C3 :(
;.byte NOTE_C5,NOTE_D4,NOTE_C3
.byte NOTE_C6,NOTE_D5,NOTE_C4

	; duration
	; assuming 255 means 0.5s
	; seems more likely 255 means 0.5s

	; 50ms (255*.05=13)*2
	; 80ms (255*.08 =20)*2

baby_lady_lengths:
	.byte	36	; .150 - .220 = 70ms
	.byte	54	; .280 - .390 = 110ms
	.byte	255	; .490 - .910 = 420ms

	; use the apple II wait function
	;  use reverse_wait program
baby_lady_delay:
	.byte	152	; .220 - .280 = 60ms
	.byte	197	; .390 - .490 = 100ms
	.byte	0	; .490 - .500 = 10ms



baby_lady_gone_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_baby_lady_sound

	ldx	#0

baby_lady_loop:
	txa
	pha

	lda     baby_lady_notes,X
	sta     speaker_frequency
	lda     baby_lady_lengths,X
	sta	speaker_duration
	jsr     speaker_tone

	pla
	tax

	lda	baby_lady_delay,X
	jsr	wait

	inx
	cpx	#BABY_LADY_NOTES
	bne	baby_lady_loop

done_baby_lady_sound:
	rts



;======================
; old

.if 0

	; 	note 1		note2		note3
	; 	0.15-0.220	0.28-0.38	0.5-0.9
	; sox	825Hz (G#5)	1026Hz (C6)	1068Hz (C#6?)
	; ear	C6		F#5		C5

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

.endif
