;
;  trogdor.s
;
; Getting text-to-speech on a ssi-263 equipped mockigboard
;	for Peasant's Quest

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
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_K		; K	; Can
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH	; AH	; Honestly
	.byte PHONEME_N		; N
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_S		; S
	.byte PHONEME_T		; T
	.byte PHONEME_L		; L
	.byte PHONEME_E1	; E1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_S		; S	; Say
	.byte PHONEME_A		; A
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_I		; I1	; it'll
;	.byte PHONEME_I3	; I3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_I		; I
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_B		; B	; be
	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_A		; A	; A
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_P		; P	; pleasure
	.byte PHONEME_L		; L
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_ER	; ER
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AE1	; AE1	; and
	.byte PHONEME_EH	; EH
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AE1	; AE1	; an
	.byte PHONEME_EH	; EH
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH	; AH	; honor
	.byte PHONEME_N		; N
	.byte PHONEME_ER	; ER
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_T		; T	; to
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_B		; B	; burninate
	.byte PHONEME_ER	; ER
	.byte PHONEME_R		; R
	.byte PHONEME_N		; N
	.byte PHONEME_I		; I
	.byte PHONEME_N		; N
	.byte PHONEME_A		; A
	.byte PHONEME_A		; A
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_Y		; Y	; you
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA	; ,

	.byte PHONEME_R		; R	; Rather
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH
	.byte PHONEME_TH	; TH
	.byte PHONEME_ER	; ER
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_D		; D	; Dashing
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG


	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte $FF


