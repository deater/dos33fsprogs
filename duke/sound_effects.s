

jump_noise:

	lda	SOUND_STATUS
	bmi	done_jump_noise

	bit	$C030

done_jump_noise:
	rts
