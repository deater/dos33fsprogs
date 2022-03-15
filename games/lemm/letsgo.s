
LETSGO_LENGTH = 14

play_letsgo:
	; only avail if language card
	;and     #SOUND_IN_LC
	;beq     done_link_noise

	; switch in language card
	; read RAM, no write, $d000 bank 1

	; bit     $C088

	; call the btc player

	lda	#<letsgo
	sta	BTC_L
	lda	#>letsgo
	sta	BTC_H

	ldx	#LETSGO_LENGTH           ; 14 pages long???
	jsr	play_audio

        ; restore rom, no write, $d000 bank 1

;	bit     $c08A

	rts

