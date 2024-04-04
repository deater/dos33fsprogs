	;=====================
	; entry music
entry_music:
	rts

	;=====================
	; exit music
exit_music:
	rts

	;======================
	; noise when jump
jump_noise:
	rts


	;======================
	; noise when bump head
head_noise:
	rts


	;======================
	; noise when land after jump
land_noise:

	lda	SOUND_STATUS
	bmi	done_land_noise

done_land_noise:
	rts


	;======================
	; pickup noise
pickup_noise:

	lda	SOUND_STATUS
	bmi	done_pickup_noise

done_pickup_noise:
	rts


	;======================
	; buzzer noise
	;    C, two octaves+C?
buzzer_noise:

	lda	SOUND_STATUS
	bmi	done_buzzer_noise


done_buzzer_noise:
	rts





	;======================
	; enemy noise
enemy_noise:

	lda	SOUND_STATUS
	bmi	done_enemy_noise

done_enemy_noise:
	rts

	;======================
	; laser noise
laser_noise:

	lda	SOUND_STATUS
	bmi	done_enemy_noise


done_laser_noise:
	rts

