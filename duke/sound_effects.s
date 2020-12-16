	;======================
	; noise when jump
jump_noise:

	lda	SOUND_STATUS
	bmi	done_jump_noise

	bit	$C030

done_jump_noise:
	rts


	;======================
	; noise when bump head
head_noise:

	lda	SOUND_STATUS
	bmi	done_head_noise

	bit	$C030
	bit	$C030

done_head_noise:
	rts


	;======================
	; noise when land after jump
land_noise:

	lda	SOUND_STATUS
	bmi	done_land_noise

	bit	$C030

done_land_noise:
	rts


	;======================
	; rumble noise
rumble_noise:

	lda	SOUND_STATUS
	bmi	done_rumble_noise

	ldx	#50
rumble_red:
	bit	$C030
	lda	#100
	jsr	WAIT
	dex
	bne	rumble_red

done_rumble_noise:
	rts


	;======================
	; pickup noise
	;    C, two octaves+C?
pickup_noise:

	lda	SOUND_STATUS
	bmi	done_pickup_noise

	lda	#NOTE_C3
	sta	speaker_frequency
	lda	#25
	sta	speaker_duration
	jsr	speaker_tone

	lda	#NOTE_C5
	sta	speaker_frequency
	lda	#20
	sta	speaker_duration
	jsr	speaker_tone

done_pickup_noise:
	rts



