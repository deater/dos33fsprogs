	;=======================
	;=======================
	; falling (sound 662)
	;=======================
	;=======================
	; note we might want to break up

	; used in
	; (----)	675	location_kerrek1/2 (kerrek falling)
	; (----)	957	trogdor (flames, while sleeping)

	; .150-.250	B3/D5
	; .200-.300	G3/E4/D5
	; .250-.350	A3/F4
	; .300-.400	A3/D5
	; .350-.450	A3/E4

	; .150-.340	B3
	; .340-.530	A3
	; .530-.720	A3/E4





FALLING_NOTES=9

falling_notes:
;.byte NOTE_B3,NOTE_D5,NOTE_B3,NOTE_D5
;.byte NOTE_G3,NOTE_D5,NOTE_G3,NOTE_D5
;.byte NOTE_A3,NOTE_D5,NOTE_A3,NOTE_D5

; ok?
;.byte NOTE_B3,NOTE_D4,NOTE_B3,NOTE_D4
;.byte NOTE_G3,NOTE_D4,NOTE_G3,NOTE_D4
;.byte NOTE_A3,NOTE_D4,NOTE_A3,NOTE_D4

; ok?
.byte NOTE_B3,NOTE_G3,NOTE_B3,NOTE_G3
.byte NOTE_G3,NOTE_A3,NOTE_G3,NOTE_A3
.byte NOTE_A3,NOTE_D4,NOTE_A3,NOTE_D4

	; duration
	; assuming 255 means 0.5s
	; seems more likely 255 means 0.5s

	; 50ms (255*.05=13)*2
	; 80ms (255*.08 =20)*2

falling_lengths:
	.byte	10,10,10,10,10,10,10,10,10	; 30ms

	; use the apple II wait function
	;  use reverse_wait program
falling_delay:
	.byte	0,0,0,0,0,0,0,0,0	; 0


falling_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_falling_sound

	ldx	#0

falling_loop:
	txa
	pha

	lda     falling_notes,X
	sta     speaker_frequency
	lda     falling_lengths,X
	sta	speaker_duration
	jsr     speaker_tone

	pla
	tax

;	lda	falling_delay,X
;	jsr	wait

	inx
	cpx	#FALLING_NOTES
	bne	falling_loop


done_falling_sound:
        rts

