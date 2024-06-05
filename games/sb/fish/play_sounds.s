FISH_SAMPLE = $D000
FISH_LENGTH = 17	; $11
BOAT_SAMPLE = $E100
BOAT_LENGTH = 20	; $14

play_fish:
	; only avail if language card

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	done_play_fish

	; switch in language card
	; read/write RAM $d000 bank 1

	 bit     $C083
	 bit     $C083

	; call the btc player

	lda	#<FISH_SAMPLE
	sta	BTC_L

	lda	#>FISH_SAMPLE
	sta	BTC_H

	ldx	#FISH_LENGTH
	jsr	play_audio

        ; read ROM/no-write

	bit     $c082

done_play_fish:
	rts


play_boat:
	; only avail if language card

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	done_play_boat

	; switch in language card
	; read/write RAM $d000 bank 1

	 bit     $C083
	 bit     $C083

	; call the btc player

	lda	#<BOAT_SAMPLE
	sta	BTC_L

	lda	#>BOAT_SAMPLE
	sta	BTC_H

	ldx	#BOAT_LENGTH
	jsr	play_audio

        ; read ROM/no-write

	bit     $c082

done_play_boat:
	rts
