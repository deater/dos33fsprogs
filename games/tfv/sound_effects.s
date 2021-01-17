	;======================
	; noise when move menu
menu_noise:

	lda	SOUND_STATUS
	bmi	done_menu_noise

	lda	#NOTE_C4
	sta	speaker_frequency
	lda	#25
	sta	speaker_duration
	jsr	speaker_tone

done_menu_noise:
	rts


	;======================
	; noise when cast heal
heal_noise:

	lda	SOUND_STATUS
	bmi	done_heal_noise

	lda	#NOTE_D3
	sta	speaker_frequency
	lda	#5
	sta	speaker_duration
	jsr	speaker_tone

done_heal_noise:
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
