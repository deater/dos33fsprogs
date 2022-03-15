LETSGO = $D000
LETSGO_LENGTH = 14

play_letsgo:
	; only avail if language card
	;and     #SOUND_IN_LC
	;beq     done_link_noise

	; switch in language card
	; read/write RAM $d000 bank 1

	 bit     $C083
	 bit     $C083


	; call the btc player

	lda	#<LETSGO
	sta	BTC_L
	lda	#>LETSGO
	sta	BTC_H

	ldx	#LETSGO_LENGTH           ; 14 pages long???
	jsr	play_audio

        ; read/write RAM, $d000 bank 2

	bit     $c08B
	bit     $c08B


	rts

