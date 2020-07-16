linking_noise = $d000
LINKING_NOISE_LENGTH = 43

	;============================
	; play the linking noise
	;============================
play_link_noise:
	lda	SOUND_STATUS
	bmi	done_link_noise

	; only avail if language card
	and	#SOUND_IN_LC
	beq	done_link_noise

	; switch in language card
	; read RAM, no write, $d000 bank 1

	bit	$C088

	; call the btc player

	lda	#<linking_noise
	sta	BTC_L
	lda	#>linking_noise
	sta	BTC_H
	ldx	#LINKING_NOISE_LENGTH           ; 45 pages long???
	jsr	play_audio

	; restore rom, no write, $d000 bank 1

	bit	$c08A

done_link_noise:
	rts
