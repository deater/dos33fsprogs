ASPLODE_SAMPLE = $D000
ASPLODE_LENGTH = 28	; $1C

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

	lda	sound_parts,Y		; #>ASPLODE_SAMPLE
	sta	BTC_H

	lda	sound_len,Y
	tax
	;ldx	#ASPLODE_LENGTH		; 28 pages long???
	jsr	play_audio

        ; read ROM/no-write

	bit     $c082

done_play_asplode:
	rts

; in the game
;  bim	: bullet launch
;  boom : bullet hit
;  twang : while asploding

sound_parts:
	.byte	$D0		; your
	.byte	$D8		; head
	.byte	$E0		; a
	.byte	$E1		; splode
	.byte	$D0		; whole thing
	.byte	$F0		; bim
	.byte	$F4		; boom
	.byte	$F8		; twang

sound_len:
	.byte	$8
	.byte	$8
	.byte	$6
	.byte	$10
	.byte	28
	.byte	$4
	.byte	$4
	.byte	$8
