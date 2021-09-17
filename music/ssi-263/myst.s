;
;  myst.s
;
; Getting text-to-speech on a ssi-263 equipped mockigboard
;	for Myst?

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

	; myst

	lda	#<myst_fissure
	sta	SPEECH_PTRL
	lda	#>myst_fissure
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

myst_fissure:
	; "I REALIZED, THE MOMENT I FELL INTO THE"
        ; "FISSURE, THAT THE BOOK WOULD NOT BE"
        ; "DESTROYED AS I HAD PLANNED."
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_R		; R	; realized
	.byte PHONEME_E1	; E1
	.byte PHONEME_AY	; AY
	.byte PHONEME_L		; L
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_Y		; Y
	.byte PHONEME_Z		; Z
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA	; ,
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_THV	; THV	; the
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_M		; M	; moment
	.byte PHONEME_O		; O1
	.byte PHONEME_M		; M
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_F		; F	; fell
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_L		; L
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_I		; I1/I3	; into
	.byte PHONEME_N		; N
	.byte PHONEME_T		; T
	.byte PHONEME_IU	; IU
	.byte PHONEME_IU	; UI/UI
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_THV	; THV	; the
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_F		; F	; fissure
	.byte PHONEME_I		; I
	.byte PHONEME_Z		; Z
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_ER	; ER
	.byte PHONEME_PAUSE	; PA	; ,
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_THV	; THV	; that
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_THV	; THV	; the
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_B		; B	; book
	.byte PHONEME_OO	; OO1
	.byte PHONEME_OO	; OO1
	.byte PHONEME_OO	; OO1
	.byte PHONEME_K		; K
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_W		; W	; would
	.byte PHONEME_IU1	; IU1
	.byte PHONEME_L		; L
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_N		; N	; not
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_B		; B	; be
	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_B		; B	; burninated
	.byte PHONEME_ER	; ER
	.byte PHONEME_R		; R
	.byte PHONEME_N		; N
	.byte PHONEME_I		; I
	.byte PHONEME_N		; N
	.byte PHONEME_A		; A
	.byte PHONEME_A		; A
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AE1	; AE1	; as
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_HF	; H	; had
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_P		; P	; planned
	.byte PHONEME_L		; L
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte $FF


	; "IT CONTINUED FALLING INTO THAT STARRY",0
        ; "EXPANSE OF WHICH I HAD ONLY A",0
        ; "FLEETING GLIMPSE.",0
myst_starry:
	.byte PHONEME_I		; I1	; It
;	.byte PHONEME_I3	; I3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_K		; K	; continued
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_N		; N
	.byte PHONEME_T		; T
	.byte PHONEME_I	; I1
;	.byte PHONEME_I3	; I3
	.byte PHONEME_N		; N
;	.byte PHONEME_Y1	; Y1
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
;falling
	.byte PHONEME_I		; I1/I3	; into
	.byte PHONEME_N		; N
	.byte PHONEME_T		; T
	.byte PHONEME_IU	; IU
	.byte PHONEME_IU	; UI/UI
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_THV	; THV	; that
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
; starry
; espanse
; of
; which
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_HF	; H	; had
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH1	; EH3
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
; only
; a
; fleeting
; glimpse
	.byte $FF

	; "I HAVE TRIED TO SPECULATE WHERE IT MIGHT"
        ; "HAVE LANDED, BUT I MUST ADMIT,"
        ; "HOWEVER-- SUCH CONJECTURE IS FUTILE."
myst_speculate:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
; have
; tried
	.byte PHONEME_T		; T	; to
	.byte PHONEME_IU	; IU
	.byte PHONEME_IU	; UI/UI
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
; speculate
; where
' it
; might
; have
; landed,
; but
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
; must
; admit,
; however --
; such
; conjecture
; is
; futile
	.byte $FF

	; "STILL, THE QUESTION ABOUT WHOSE HANDS"
        ; "MIGHT SOMEDAY HOLD MY MYST BOOK ARE"
        ; "UNSETTLING TO ME."
myst_unsettling:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_R		; R	; realized
	.byte PHONEME_E1	; E1
	.byte PHONEME_AY	; AY
	.byte PHONEME_L		; L
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_Y		; Y
	.byte PHONEME_Z		; Z
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA	; ,
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte $FF

	; "I KNOW THAT MY APPREHENSIONS MIGHT"
        ; "NEVER BE ALLAYED, AND SO I CLOSE,"
        ; "REALIZING THAT PERHAPS,"
myst_allayed:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_R		; R	; realized
	.byte PHONEME_E1	; E1
	.byte PHONEME_AY	; AY
	.byte PHONEME_L		; L
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_Y		; Y
	.byte PHONEME_Z		; Z
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA	; ,
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte $FF

	; "THE ENDING HAS NOT YET BEEN WRITTEN."
myst_written:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_R		; R	; realized
	.byte PHONEME_E1	; E1
	.byte PHONEME_AY	; AY
	.byte PHONEME_L		; L
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_Y		; Y
	.byte PHONEME_Z		; Z
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA	; ,
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte $FF