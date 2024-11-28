BACK_SAMPLE = $D000
BACK_LENGTH = 30	; $1E

play_back_off:
	; only avail if language card

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	done_play_back_off

	; switch in language card
	; read/write RAM $d000 bank 1

	 bit     $C083
	 bit     $C083


	; call the btc player

	lda	#<BACK_SAMPLE
	sta	BTC_L

	lda	sound_parts,Y		; #>BACK_SAMPLE
	sta	BTC_H

	lda	sound_len,Y
	tax
	;ldx	#BACK_LENGTH		; 28 pages long???
	jsr	play_audio

        ; read ROM/no-write

	bit     $c082

done_play_back_off:
	rts


sound_parts:
	.byte	$D0		; back
	.byte	$D8		; off
	.byte	$E0		; baby
	.byte	$D0		; all
sound_len:
	.byte	$8
	.byte	$8
	.byte	$E
	.byte	30		; $1E

