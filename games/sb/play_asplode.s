ASPLODE_SAMPLE = $D000
ASPLODE_LENGTH = 28

play_asplode:
	; only avail if language card

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	done_play_asplode

	; switch in language card
	; read/write RAM $d000 bank 1

	 bit     $C083
	 bit     $C083


	; call the btc player

	lda	#<ASPLODE_SAMPLE
	sta	BTC_L
	lda	#>ASPLODE_SAMPLE
	sta	BTC_H

	ldx	#ASPLODE_LENGTH		; 28 pages long???
	jsr	play_audio

        ; read ROM/no-write

	bit     $c082

done_play_asplode:
	rts

