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

;	lda	#<trogdor_honestly
;	sta	SPEECH_PTRL
;	lda	#>trogdor_honestly
;	sta	SPEECH_PTRH

;	lda	#<trogdor_sup
;	sta	SPEECH_PTRL
;	lda	#>trogdor_sup
;	sta	SPEECH_PTRH

	lda	#<trogdor_surprised
	sta	SPEECH_PTRL
	lda	#>trogdor_surprised
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


	; "I can honestly say it'll",13
	; "be a pleasure and an honor",13
	; "to burninate you, Rather",13
	; "Dashing.",34,0
trogdor_honestly:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_K		; K	; can
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AH	; AH	; honestly
	.byte PHONEME_N		; N
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_S		; S
	.byte PHONEME_T		; T
	.byte PHONEME_L		; L
	.byte PHONEME_E1	; E1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; say
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



	; "Sup, mortal," booms
	; Trogdor. "I really"
	; "appreciate you making the"
	; "effort to come all the way"
	; "up here and vanquish me and"
	; "all. But, I'm kinda"
	; "indestructible."
trogdor_sup:
	.byte PHONEME_S		; S	'sup
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_P		; P
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA


	.byte PHONEME_M		; M	mortal
	.byte PHONEME_O		; O2
	.byte PHONEME_O		; O2
	.byte PHONEME_R		; R
	.byte PHONEME_T		; T
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA	,

	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_R		; R	really
	.byte PHONEME_E1	; E1
	.byte PHONEME_AY	; AY
	.byte PHONEME_L		; L
	.byte PHONEME_E1	; E1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH1	; UH1	appreciate
	.byte PHONEME_P		; P
	.byte PHONEME_R		; R
	.byte PHONEME_E1	; E1
	.byte PHONEME_SCH	; SH
	.byte PHONEME_E1	; E1
	.byte PHONEME_A		; A2
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

	.byte PHONEME_M		; M	; making
	.byte PHONEME_A		; A1
	.byte PHONEME_AY	; AY
	.byte PHONEME_K		; K
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_THV	; THV   ; the
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_EH	; EH	; effort
	.byte PHONEME_F		; F
	.byte PHONEME_F		; F
	.byte PHONEME_O		; O2
	.byte PHONEME_R		; R
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_T		; T	; to
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_K		; K	; come
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_M		; M
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AW	; AW	; all
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_THV	; THV   ; the
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_W		; W	; way
	.byte PHONEME_A		; A2
	.byte PHONEME_A		; A2
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH1	; UH1	; up
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_P		; P
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_HF	; H	; here
	.byte PHONEME_AY	; AY
	.byte PHONEME_E		; I
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AE1	; AE1	; and
	.byte PHONEME_EH	; EH
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_V		; V	; vanquish
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_I		; I3
	.byte PHONEME_NG	; NG
	.byte PHONEME_K		; K
	.byte PHONEME_W		; W
	.byte PHONEME_I		; I
	.byte PHONEME_SCH	; SH
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; me
	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AE1	; AE1	; and
	.byte PHONEME_EH	; EH
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AW	; AW	; all
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA	.
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_B		; B	; But
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA	; ,

	.byte PHONEME_AH1	; AH1	; I'm
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_Y		; M
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_K		; K	; kinda
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_Y		; Y
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_I		; I	; indestructable
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_E		; E
	.byte PHONEME_S		; S
	.byte PHONEME_T		; T
	.byte PHONEME_R		; R
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_K		; K
	.byte PHONEME_T		; T
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_B		; B
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_L		; L

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte $FF



	; "Yeah, I can't be killed."
	; "I'm surprised nobody"
	; "mentioned that to you. I'll"
	; "admit though, you've"
	; "gotten farther than"
	; "anybody else ever has. I"
	; "bet they'll make a statue"
	; "or something in honor of"
	; "you somewheres."

trogdor_surprised:

	.byte PHONEME_Y		; Y	Yeah,
	.byte PHONEME_A		; AH
	.byte PHONEME_UH	; EH
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA ,

	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_K		; K	; can't
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_B		; B	; be
	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_K		; K	; killed
	.byte PHONEME_I		; I
	.byte PHONEME_L		; L
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA	.

	.byte PHONEME_AH1	; AH1	; I'm
	.byte PHONEME_Y		; Y
	.byte PHONEME_Y		; M
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	surprised
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_P		; P
	.byte PHONEME_R		; R
	.byte PHONEME_AH1	; AH3
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_Z		; Z
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_N		; N	nobody
	.byte PHONEME_OO	; OO1
	.byte PHONEME_OU	; O1
	.byte PHONEME_B		; B
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_D		; D
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	mentioned
	.byte PHONEME_EH	; EH1
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_THV	; THV   ; that
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_T		; T	; to
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_Y		; Y	; you
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA	; .
	.byte PHONEME_PAUSE	; PA	; .

	.byte PHONEME_AH1	; AH1	; I'll
	.byte PHONEME_Y		; Y
	.byte PHONEME_UH	; UH
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AE1	; AE1	; admit
	.byte PHONEME_EH	; EH3
	.byte PHONEME_D		; D
	.byte PHONEME_M		; M
	.byte PHONEME_I		; I
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AE1	; TH	; though
;	.byte PHONEME_OO	; OO1
	.byte PHONEME_OU	; O1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA 	; ,

	.byte PHONEME_Y		; Y	; you've
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_V		; V
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_KV	; KV	; gotten
	.byte PHONEME_AH	; AH1
	.byte PHONEME_T		; T
	.byte PHONEME_EH	; EH
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_F		; F	; farther
	.byte PHONEME_AH	; AH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_R		; R
	.byte PHONEME_TH	; TH
	.byte PHONEME_ER	; ER
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_TH	; TH	; than
	.byte PHONEME_EH1	; EH1
;	.byte PHONEME_EH3	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_EH	; EH2	; anybody
	.byte PHONEME_EH	; EH2
	.byte PHONEME_N		; N
	.byte PHONEME_Y		; Y
	.byte PHONEME_B		; B
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_D		; D
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_EH1	; EH1	; else
	.byte PHONEME_EH	; EH2
	.byte PHONEME_L		; L
	.byte PHONEME_S		; S
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_EH1	; EH1	; ever
	.byte PHONEME_V		; V
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_HF	; H	; has
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA	; .

	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_B		; B	; bet
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_TH	; TH	; they'll
	.byte PHONEME_AI	; AI
	.byte PHONEME_Y		; Y
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; make
	.byte PHONEME_AI	; AI
	.byte PHONEME_K		; K
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH	; UH	; a
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; statue
	.byte PHONEME_T		; T
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_T		; T
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH	; O1	; or
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; something
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_M		; M
	.byte PHONEME_TH	; TH
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_I		; I1	; in
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AH	; AH	; honor
	.byte PHONEME_N		; N
	.byte PHONEME_UH	; O1
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH1	; UH1   ; of
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_V		; V
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_Y		; Y	; you
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; somewheres
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_M		; M
	.byte PHONEME_W		; W
	.byte PHONEME_EH	; EH3
	.byte PHONEME_A		; A2
	.byte PHONEME_EH	; EH3
	.byte PHONEME_R		; R
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA	.


	.byte $FF
