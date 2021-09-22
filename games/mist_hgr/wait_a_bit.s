	;====================================
	; wait for keypress or a few seconds
	;====================================
	; SPECIAL CASE
	;	$FF = wait until sound pattern 1
	;	$FE = wait until DONE_PLAYING
	;	$FD = wait until text done

wait_a_bit:
	cmp	#$FF
	beq	wait_a_bit_pattern1
	cmp	#$FE
	beq	wait_a_bit_end_song


wait_a_bit_time:

	bit	KEYRESET
	tax

keyloop:
	lda	#200			; delay a bit
	jsr	WAIT

	lda	KEYPRESS
	bmi	done_keyloop

	dex
	bne	keyloop

done_keyloop:

	sta	LAST_KEY

	bit	KEYRESET

	rts


	;=====================
	; wait for pattern 1
wait_a_bit_pattern1:
	bit	KEYRESET
keyloop2:
	lda	current_pattern_smc+1
	bne	done_keyloop2
	lda	KEYPRESS
	bmi	done_keyloop2
	bpl	keyloop2
done_keyloop2:
	sta	LAST_KEY
	bit	KEYRESET

	rts

	;=====================
	; wait for song done
wait_a_bit_end_song:
	bit	KEYRESET
keyloop3:
	lda	DONE_PLAYING
	bne	done_keyloop3
	lda	KEYPRESS
	bmi	done_keyloop3
	bpl	keyloop3
done_keyloop3:
	sta	LAST_KEY
	bit	KEYRESET

	rts


