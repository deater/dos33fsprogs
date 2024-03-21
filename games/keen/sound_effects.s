	;=====================
	; entry music
entry_music:
	lda	SOUND_STATUS
	bmi	done_entry_music

	; music from _mr_m_ on Commander Keen Forum, Jun 5 2009
	; 4* D5 32
	; 4* A4 32
	; D5 A4 D5 G5 (all 8th)

	lda	#0
	sta	MUSIC_PTR
entry_music_loop:
	ldx	MUSIC_PTR
	lda	entry_music_freq,X
	beq	done_entry_music
	sta	speaker_frequency
	lda	entry_music_len,X
	sta	speaker_duration
	jsr	speaker_tone

	lda	#100
	jsr	WAIT	; FIXME: won't work if language card active

	inc	MUSIC_PTR
	jmp	entry_music_loop

done_entry_music:
	rts


entry_music_freq:
	.byte NOTE_D5,NOTE_D5,NOTE_D5,NOTE_D5
	.byte NOTE_A4,NOTE_A4,NOTE_A4,NOTE_A4
	.byte NOTE_D5,NOTE_A4,NOTE_D5,NOTE_G5
	.byte 0

entry_music_len:
	.byte 16,16,16,16
	.byte 16,16,16,16
	.byte 64,64,64,64




	;=====================
	; exit music
exit_music:
	lda	SOUND_STATUS
	bmi	done_exit_music

	; all 16 notes
	; F#4 A#4 C5 D5 D#5 F5
	; G4 G4 G4

	lda	#0
	sta	MUSIC_PTR
exit_music_loop:
	ldx	MUSIC_PTR
	lda	exit_music_freq,X
	beq	done_exit_music
	sta	speaker_frequency
	lda	exit_music_len,X
	sta	speaker_duration
	jsr	speaker_tone

	lda	#100
	jsr	WAIT	; FIXME: won't work if language card active

	inc	MUSIC_PTR
	jmp	exit_music_loop

done_exit_music:
	rts

	; all 16 notes
	; F#4 A#4 C5 D5 D#5 F5
	; G4 G4 G4

exit_music_freq:
	.byte NOTE_FSHARP4,NOTE_ASHARP4,NOTE_C5,NOTE_D5
	.byte NOTE_DSHARP5,NOTE_F5,NOTE_G4,NOTE_G4
	.byte NOTE_G4
	.byte 0

exit_music_len:
	.byte 48,48,48,48
	.byte 48,48,48,48
	.byte 48



	;======================
	; noise when jump
jump_noise:

	lda	SOUND_STATUS
	bmi	done_jump_noise

;	bit	$C030

done_jump_noise:
	rts


	;======================
	; noise when bump head
head_noise:

	lda	SOUND_STATUS
	bmi	done_head_noise

	lda	#NOTE_D3
	sta	speaker_frequency
	lda	#5
	sta	speaker_duration
	jsr	speaker_tone


;	bit	$C030
;	bit	$C030

done_head_noise:
	rts


	;======================
	; noise when land after jump
land_noise:

	lda	SOUND_STATUS
	bmi	done_land_noise

;	bit	$C030

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


	;======================
	; buzzer noise
	;    C, two octaves+C?
buzzer_noise:

	lda	SOUND_STATUS
	bmi	done_buzzer_noise

	lda	#NOTE_C3
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

done_buzzer_noise:
	rts





	;======================
	; enemy noise
enemy_noise:

	lda	SOUND_STATUS
	bmi	done_enemy_noise

	lda	#NOTE_A3
	sta	speaker_frequency
	lda	#20
	sta	speaker_duration
	jsr	speaker_tone

	lda	#NOTE_A4
	sta	speaker_frequency
	lda	#10
	sta	speaker_duration
	jsr	speaker_tone

done_enemy_noise:
	rts

	;======================
	; laser noise
laser_noise:

	lda	SOUND_STATUS
	bmi	done_enemy_noise

	lda	#NOTE_D4
	sta	speaker_frequency
	lda	#15
	sta	speaker_duration
	jsr	speaker_tone

done_laser_noise:
	rts

