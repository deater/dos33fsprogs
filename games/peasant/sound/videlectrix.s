	;=======================
	;=======================
	; Videlectrix Theme
	;=======================
	;=======================

videlectrix_theme:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_videlectrix_theme

	ldy	#0

animation_loop:


	lda	delays,Y		; ??? do we ignore?
	bmi	done_loop

	tya
	pha

	lda	#200

	jsr	wait

	;=========================
	; play sound if needed?

	lda	notes,Y
	beq	no_note

	sta	speaker_frequency

	lda	#50
	sta	speaker_duration

	jsr	speaker_tone

no_note:
	pla				; restore Y
	tay

	iny

	jmp	animation_loop

done_loop:
done_videlectrix_theme:

	rts


notes:
	.byte	0	; title		;	.byte	0	; 1
	.byte	0	; 2
	.byte	0	; 3		;	.byte	0	; 4
	.byte	0	; 5		;	.byte	0	; 6
	.byte	0	; 7		;	.byte	0	; 8
	.byte	0	; 9		;	.byte	0	; 10
	.byte	0	; 11		;	.byte	0	; 12
	.byte	0	; 13		;	.byte	0	; 14
	.byte	NOTE_E4	; 15		;	.byte	0	; 16
	.byte	NOTE_D4	; 17		;	.byte	0	; 18
	.byte	NOTE_F4	; 19		;	.byte	0	; 20
	.byte	0	; 21		;	.byte	0	; 22
	.byte	0	; 23		;	.byte	0	; 24
	.byte	0	; 25		;	.byte	0	; 26
	.byte	NOTE_C4	; 27		;	.byte	0	; 28
	.byte	0	; 29
	.byte	0	; 30
	.byte	0	; 31
	.byte	NOTE_C5	; 32
	.byte	NOTE_C5	; 33
	.byte	0	; 33
	.byte	0	; 33
	.byte	NOTE_C4	; 34
	.byte	0	; 34



delays:
	.byte	1	; title		;	.byte	1	; 1
	.byte	1	; 2
	.byte	1	; 3		;	.byte	1	; 4
	.byte	1	; 5		;	.byte	1	; 6
	.byte	1	; 7		;	.byte	1	; 8
	.byte	1	; 9		;	.byte	1	; 10
	.byte	1	; 11		;	.byte	1	; 12
	.byte	1	; 13		;	.byte	1	; 14
	.byte	1	; 15		;	.byte	1	; 16
	.byte	1	; 17		;	.byte	1	; 18
	.byte	1	; 19		;	.byte	1	; 20
	.byte	1	; 21		;	.byte	1	; 22
	.byte	1	; 23		;	.byte	1	; 24
	.byte	1	; 25		;	.byte	1	; 26
	.byte	1	; 27		;	.byte	1	; 28
	.byte	1	; 29
	.byte	1	; 30
	.byte	1	; 31
	.byte	1	; 32
	.byte	1	; 33
	.byte	1	; 33
	.byte	1	; 33
	.byte	1	; 34
	.byte	1	; 34
	.byte	$FF

