; this code was widely shared for playing tones on Apple II
;	by POKEing the machine language and CALLing from BASIC

; it's originally by Paul Lutus, from the Apple II Red Book p45


; it's hard to find good info on this, but loading from $C030
;	"toggles" the speaker.  So toggling twice is esentially a square wave?

; using regular load/store/bit of $C030 is safe.  Some of the more
;	advanced addressing modes can double-toggle due to how some 6502
;	implementations run the address bus

; these seem to have been calculated assuming a 1MHz clock
;	but the Apple II actually runs at roughly 1.023MHz

; or a frequency of 1/(speaker_freq*20.46e-6)

; to go other way, speaker_freq=1/(freq*20.46e-6)

; this table of notes was from
; http://eightbitsoundandfury.ld8.org/programming.html
; but seems off a bit and also assumes 1MHz clock

;				1MHz			1.023MHz
NOTE_C3		= 255	; G3=5217us = 192Hz (G3,  5218us = 196Hz	249)
NOTE_CSHARP3	= 241	; 4931us = 203Hz (G#3, 4931us = 207Hz
NOTE_D3		= 227	; 
NOTE_DSHARP3	= 214
NOTE_E3		= 202
NOTE_F3		= 191
NOTE_FSHARP3	= 180
NOTE_G3		= 170
NOTE_GSHARP3	= 161
NOTE_A3		= 152
NOTE_ASHARP3	= 143
NOTE_B3		= 135	; 1350us = 740Hz (F#5)

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

; B5 = 988 Hz, 1021us


;=====================================================
; speaker tone
;=====================================================
; A,X,Y trashed
; duration also trashed

; this was designed by basic to be poked into 770 ($302)
;	on an Applesoft CALL, X=$9d, Y=$02  (A,Y = Address to call)
; it was originally designed for Integer BASIC where Y=0 on call

	; the inner freq loop is roughly FREQ*10cycles
	; so the square wave generated has a period of
	;	freq*20*1.023us
	; or a frequency of 1/(freq*20.46e-6)

speaker_tone:
	ldy	#0							; 3
speaker_tone_loop:
	lda	$C030		; click speaker				; 4
speaker_loop:
	dey			;					; 2
	bne	freq_loop	;					; 2/3
	dec	speaker_duration	; (Duration)			; 6
	beq	done_tone						; 2/3
freq_loop:
	dex								; 2
	bne	speaker_loop						; 2/3
	ldx	speaker_frequency	; (Frequency)			; 4
	jmp	speaker_tone_loop					; 3
done_tone:
	rts

speaker_duration:
	.byte	$00
speaker_frequency:
	.byte	$00

