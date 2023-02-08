; based on code from here
; http://eightbitsoundandfury.ld8.org/programming.html

; A,X,Y trashed
; duration also trashed

NOTE_C3		=	255
NOTE_CSHARP3	=	241
NOTE_D3		=	227
NOTE_DSHARP3	=	214
NOTE_E3		=	202
NOTE_F3		=	191
NOTE_FSHARP3	=	180
NOTE_G3		=	170
NOTE_GSHARP3	=	161
NOTE_A3		=	152
NOTE_ASHARP3	=	143
NOTE_B3		=	135

NOTE_C4		=	128
NOTE_CSHARP4	=	121
NOTE_D4		=	114
NOTE_DSHARP4	=	108
NOTE_E4		=	102
NOTE_F4		=	96
NOTE_FSHARP4	=	91
NOTE_G4		=	85
NOTE_GSHARP4	=	81
NOTE_A4		=	76
NOTE_ASHARP4	=	72
NOTE_B4		=	68

NOTE_C5		=	64
NOTE_CSHARP5	=	60
NOTE_D5		=	57
NOTE_DSHARP5	=	54
NOTE_E5		=	51
NOTE_F5		=	48
NOTE_FSHARP5	=	45
NOTE_G5		=	43
NOTE_GSHARP5	=	40
NOTE_A5		=	38
NOTE_ASHARP5	=	36
NOTE_B5		=	34



speaker_tone:
	lda	$C030		; click speaker
speaker_loop:
	dey			; y never set?
	bne	slabel1		; duration roughly 256*?
	dec	speaker_duration	; (Duration)
	beq	done_tone
slabel1:
	dex
	bne	speaker_loop
	ldx	speaker_frequency	; (Frequency)
	jmp	speaker_tone
done_tone:
	rts

speaker_duration:
	.byte	$00
speaker_frequency:
	.byte	$00

