PURPLE = $D000
PURPLE_LENGTH = 28

play_purple:
	; only avail if language card

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	done_play_purple

	; switch in language card
	; read/write RAM $d000 bank 1

	 bit     $C083
	 bit     $C083


	; call the btc player

	lda	#<PURPLE
	sta	BTC_L
	lda	#>PURPLE
	sta	BTC_H

	ldx	#PURPLE_LENGTH			; 28 pages long???
	jsr	play_audio

        ; read ROM/no-write

	bit     $c082

done_play_purple:
	rts

