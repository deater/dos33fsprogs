;
;  wargames.s
;
; like from the movie

.include "hardware.inc"

.include "ssi263.inc"


speech_test:

	jsr	HOME

	lda	#4			; assume slot #4 for now
	jsr	detect_ssi263

	lda	irq_count
	clc
	adc	#'A'			; hack to show if detected or not
	sta	$400			; (B is detected, A is not)

	lda	#4			; assume slot #4 for now
	jsr	ssi263_speech_init


speech_loop:

	; trogdor

	lda	#<trogdor
	sta	SPEECH_PTRL
	lda	#>trogdor
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	wait_until_keypress

	jmp	speech_loop

wait_until_keypress:

	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET

	rts


.include "ssi263_detect.s"

.include "ssi263_simple_speech.s"

	; the document
	; "Phonetic Speech Dictionary for the SC-01 Speech Synthesizer"
	; sc01-dictionary.pdf
	; was very helpful here

trogdor:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_KV	; KV	; Greetings
	.byte PHONEME_R		; R
;	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_Z		; Z

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_P		; P	; Professor
	.byte PHONEME_R		; R
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_F		; F
	.byte PHONEME_EH1	; EH1
;	.byte PHONEME_EH1	; EH1
	.byte PHONEME_S		; S
	.byte PHONEME_O		; O
;	.byte PHONEME_O		; O
	.byte PHONEME_R		; R

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_F		; F	; Falken
	.byte PHONEME_AW	; AW
	.byte PHONEME_L		; L
	.byte PHONEME_K		; K
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_N		; N

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	; A strange game.

;	.byte PHONEME_A1	; A1	; A
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; strange
	.byte PHONEME_T		; T
	.byte PHONEME_R		; R
;	.byte PHONEME_A1	; A1
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_J		; J
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_KV	; G	; game
;	.byte PHONEME_A1	; A1
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_M		; M
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	; The only winning move is not to play.

	.byte PHONEME_THV	; THV	; The
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_OU	; O1	; Only
;	.byte PHONEME_O2	; O2
	.byte PHONEME_N		; N
	.byte PHONEME_L		; L
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_W		; W	; Winning
	.byte PHONEME_I		; I1
;	.byte PHONEME_I3	; I3
	.byte PHONEME_N		; N
	.byte PHONEME_N		; N
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_W		; M	; Move
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_V		; V
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_I		; I1	; Is
;	.byte PHONEME_I3	; I3
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_N		; N	; Not
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_T		; T	; To
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_P		; P	; Play
	.byte PHONEME_L		; L
	.byte PHONEME_A		; A1
	.byte PHONEME_I		; I3
	.byte PHONEME_Y		; Y

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte $FF


