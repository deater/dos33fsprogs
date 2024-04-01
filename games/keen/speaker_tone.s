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
NOTE_C3		= 255	; G3  5217us = 192Hz (G3,  5218us = 196Hz	249)
NOTE_CSHARP3	= 241	; G#3 4931us = 203Hz (G#3, 4931us = 207Hz
NOTE_D3		= 227	; A3
NOTE_DSHARP3	= 214   ; A#3
NOTE_E3		= 202   ; B3
NOTE_F3		= 191   ; C4
NOTE_FSHARP3	= 180   ; C#4
NOTE_G3		= 170   ; D4
NOTE_GSHARP3	= 161   ; D#4
NOTE_A3		= 152   ; E3
NOTE_ASHARP3	= 143   ; F3
NOTE_B3		= 135	; F#3

NOTE_C4		= 128	; G
NOTE_CSHARP4	= 121	; G#
NOTE_D4		= 114	; A
NOTE_DSHARP4	= 108	; A#
NOTE_E4		= 102	; B3
NOTE_F4		= 96	; C
NOTE_FSHARP4	= 91	; C#
NOTE_G4		= 85	; D
NOTE_GSHARP4	= 81	; D#
NOTE_A4		= 76	; E
NOTE_ASHARP4	= 72	; F
NOTE_B4		= 68	; F#

NOTE_C5		= 64	; G
NOTE_CSHARP5	= 60	; G#
NOTE_D5		= 57	; A
NOTE_DSHARP5	= 54	; A#
NOTE_E5		= 51	; B3
NOTE_F5		= 48	; C
NOTE_FSHARP5	= 45	; C#
NOTE_G5		= 43	; D
NOTE_GSHARP5	= 40	; D#
NOTE_A5		= 38	; E
NOTE_ASHARP5	= 36	; F
NOTE_B5		= 34	; F#

;=====================================================
; speaker tone
;=====================================================
; A,X,Y trashed
; duration also trashed

; this was designed by basic to be poked into 770 ($302)
;	on an Applesoft CALL, X=$9d, Y=$02  (A,Y = Address to call)

; it was originally designed for Integer BASIC where Y=0 on call
;	and it was poked to $00 (zero page)

	; the inner freq loop is roughly FREQ*10cycles
	; so the square wave generated has a period of
	;	freq*20*1.023us
	; or a frequency of 1/(freq*20.46e-6)

	; more exactly, it is (4+10F)+(13+10F) = 20F+17

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

