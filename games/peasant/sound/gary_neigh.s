	;=======================
	;=======================
	; gary neigh
	;=======================
	;=======================
	; used in
	; (done) 586	location e_lake (fisherman pulls fish onto boat)
	; (done) 742	location_gary (revenge: rear up, followed by bonk)
	; (done)	location_gary (fence: rear up twice, followed by bonk)
	; (done)	location_burninated (grease catches fire)

gary_neigh_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_gary_neigh_sound

done_gary_neigh_sound:
        rts


	; based on fish sound effect, should be changed

.if 0
	; play sound effect
	lda	BABY_COUNT
	cmp	#7
	bcc	no_sound
	cmp	#11
	bcs	no_sound

	cmp	#10
	beq	bloop

click:
	lda	#NOTE_C4
	sta	speaker_frequency
	lda	#6
	sta	speaker_duration
	jsr	speaker_tone
	jmp	no_sound

bloop:
	lda	#10
	sta	speaker_duration
	lda	#NOTE_C5
	sta	speaker_frequency
	jsr	speaker_tone

	lda	#10
	sta	speaker_duration
	lda	#NOTE_D5
	sta	speaker_frequency
	jsr	speaker_tone

	lda	#10
	sta	speaker_duration
	lda	#NOTE_E5
	sta	speaker_frequency
	jsr	speaker_tone

	lda	#10
	sta	speaker_duration
	lda	#NOTE_D5
	sta	speaker_frequency
	jsr	speaker_tone

	lda	#10
	sta	speaker_duration
	lda	#NOTE_C5
	sta	speaker_frequency
	jsr	speaker_tone
	jmp	no_sound

.endif
