	;=======================
	;=======================
	; raise_up (sound 323)
	;=======================
	;=======================

	; used in
	; (----)	425	kerrek1/kerrek2: raise up belt
	; (done)		outer3: raise up sword

	; based onn audacity "analyze/plot spectrum"

	; E5 D5 C5
	; E5 D5 C5
	; E5 D5 C5
	; G5

RAISE_NOTES=10

raise_up_notes:
.byte NOTE_E5,NOTE_D5,NOTE_C5
.byte NOTE_E5,NOTE_D5,NOTE_C5
.byte NOTE_E5,NOTE_D5,NOTE_C5
.byte NOTE_G5

	; duration
	; assuming 255 means 0.5s
	; seems more likely 255 means 0.5s

	; 50ms (255*.05=13)*2
	; 80ms (255*.08 =20)*2

raise_up_lengths:
	.byte	36	; .150 - .220 = 70ms
	.byte	54	; .260 - .370 = 110ms
	.byte	54	; .380 - .490 = 110ms
	.byte	52	; .500 - .600 = 100ms
	.byte	40	; .640 - .720 = 80ms
	.byte	54	; .760 - .865 = 105ms
	.byte	52	; .880 - .980 = 100ms
	.byte	54	; .995 - 1.100 = 105ms
	.byte	40	; 1.140 - 1.220 = 80ms
	.byte	219	; 1.260 - 1.690 = 430ms

	; use the apple II wait function
	;  use reverse_wait program
raise_up_delay:
	.byte	123	; .220 - .260 = 40ms
	.byte	60	; .370 - .380 = 10ms
	.byte	60	; .490 - .500 = 10ms
	.byte	123	; .600 - .640 = 40ms
	.byte	123	; .720 - .760 = 40ms
	.byte	74	; .865 - .880 = 15ms
	.byte	74	; .980 - .995 = 15ms
	.byte	123	; 1.100 - 1.140 = 40ms
	.byte	123	; 1.220 - 1.260 = 40ms
	.byte	0	; 0


raise_up_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_raise_up_sound

	ldx	#0

raise_up_loop:
	txa
	pha

	lda     raise_up_notes,X
	sta     speaker_frequency
	lda     raise_up_lengths,X
	sta	speaker_duration
	jsr     speaker_tone

	pla
	tax

	lda	raise_up_delay,X
	jsr	wait

	inx
	cpx	#RAISE_NOTES
	bne	raise_up_loop

done_raise_up_sound:
        rts

