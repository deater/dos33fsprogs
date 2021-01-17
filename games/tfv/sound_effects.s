	;======================
	; noise when move menu
menu_move_noise:

	lda	SOUND_STATUS
	bmi	done_menu_move_noise

	lda	#NOTE_C4
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

done_menu_move_noise:
	rts

	;======================
	; noise when hit escape in menu
menu_escape_noise:

	lda	SOUND_STATUS
	bmi	done_menu_escape_noise

	lda	#NOTE_C5
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

done_menu_escape_noise:
	rts

	;======================
	; noise when error in menu
menu_error_noise:

	lda	SOUND_STATUS
	bmi	done_menu_error_noise

	lda	#NOTE_D3
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

done_menu_error_noise:
	rts


	;======================
	; noise when battle counter ready
menu_ready_noise:

	lda	SOUND_STATUS
	bmi	done_menu_ready_noise

	lda	#NOTE_A4
	sta	speaker_frequency
	lda	#5
	sta	speaker_duration
	jsr	speaker_tone

	lda	#NOTE_A5
	sta	speaker_frequency
	lda	#5
	sta	speaker_duration
	jsr	speaker_tone

done_menu_ready_noise:
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
