	;=======================
	;=======================
	; game_over
	;=======================
	;=======================


game_over_music:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_game_over_music


	lda	#0
	sta	FRAME
animate_loop:

	; play tone
	ldx	FRAME
	lda	animation_notes,X
	bne	make_beep

	; delay instead
	lda	#2
	jsr	wait_a_bit
	jmp	done_beep

make_beep:

	sta	speaker_frequency
	lda	animation_note_lens,X
	sta	speaker_duration
	jsr	speaker_tone

	ldx	FRAME
	lda	animation_pause_lens,X
	jsr	wait_a_bit

done_beep:

	inc	FRAME
	lda	FRAME
	cmp	#15
	bne	animate_loop

done_game_over_music:
        rts


animation_notes:
	.byte	NOTE_G5	; 0
	.byte	NOTE_F5	; 1
	.byte	NOTE_F5	; 2
	.byte	NOTE_E5	; 3
	.byte	NOTE_E5	; 4
	.byte	NOTE_D5	; 5
	.byte	NOTE_C5	; 6
	.byte	0	; 7
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 9
	.byte	NOTE_C4	; 10
	.byte	0	; 11

animation_note_lens:
	.byte	150	;	NOTE_G5	; 0
	.byte	50	;	NOTE_F5	; 1
	.byte	100	;	NOTE_F5	; 2
	.byte	50	;	NOTE_E5	; 3
	.byte	100	;	NOTE_E5	; 4
	.byte	50	;	NOTE_D5	; 5
	.byte	150	;	NOTE_C5	; 6
	.byte	0	; 7
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 9
	.byte	150	;	NOTE_C4	; 10
	.byte	0	; 11

animation_pause_lens:
	.byte	1	;	NOTE_G5	; 0
	.byte	1	;	NOTE_F5	; 1
	.byte	1	;	NOTE_F5	; 2
	.byte	1	;	NOTE_E5	; 3
	.byte	1	;	NOTE_E5	; 4
	.byte	1	;	NOTE_D5	; 5
	.byte	1	;	NOTE_C5	; 6
	.byte	0	; 7
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 8
	.byte	0	; 9
	.byte	1	;	NOTE_C4	; 10
	.byte	0	; 11



