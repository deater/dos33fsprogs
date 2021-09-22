;
;  myst title speech
;
; Getting text-to-speech on a ssi-263 equipped mockigboard
;	for Myst



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

	.byte PHONEME_F		; F	; falling
	.byte PHONEME_AW	; AW
	.byte PHONEME_L		; L
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

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

	.byte PHONEME_S		; S	; starry
	.byte PHONEME_T		; T
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_R		; R
	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_EH1	; EH1	; expanse
	.byte PHONEME_EH	; EH3
	.byte PHONEME_K		; K
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_S		; S
	.byte PHONEME_P		; P
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_N		; N
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH1	; UH1	; of
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_V		; V
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_W		; W	; which
	.byte PHONEME_I		; I1
;	.byte PHONEME_I3	; I3
	.byte PHONEME_T		; T
	.byte PHONEME_SCH	; SCH
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

	.byte PHONEME_O		; O1	; only
;	.byte PHONEME_O2	; O2
	.byte PHONEME_N		; N
	.byte PHONEME_L		; L
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH2	; UH2	; a
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_F		; F	; fleeting
	.byte PHONEME_L		; L
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_KV	; G	; glimpse
	.byte PHONEME_L		; L
	.byte PHONEME_I		; I
	.byte PHONEME_M		; M
	.byte PHONEME_P		; P
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

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

	.byte PHONEME_HF	; H	; have
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_V		; V
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_T		; T	; tried
	.byte PHONEME_R		; R
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_I		; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_T		; T	; to
	.byte PHONEME_IU	; IU
	.byte PHONEME_IU	; UI/UI
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; speculate
	.byte PHONEME_P		; P
	.byte PHONEME_EH1	; EH1
;	.byte PHONEME_EH3	; EH3
	.byte PHONEME_K		; K
	.byte PHONEME_K		; K
;	.byte PHONEME_Y1	; Y1
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_L		; L
;	.byte PHONEME_A1	; A1
	.byte PHONEME_AY	; AY
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_W		; W	; where
	.byte PHONEME_EH	; EH3
	.byte PHONEME_AY	; A2
	.byte PHONEME_EH	; EH3
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_I		; I	; it
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; might
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_AH	; AH2
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_HF	; H	; have
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_V		; V
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_L		; L	; landed
	.byte PHONEME_AH1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_EH	; EH3
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_B		; B	; but
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; must
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_Z		; Z
	.byte PHONEME_T		; T
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

	.byte PHONEME_HF	; H	; however
	.byte PHONEME_AH1	; AH1
;	.byte PHONEME_O2	; O2
	.byte PHONEME_U1	; U1
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_V		; V
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA	; --
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; such
	.byte PHONEME_UH1	; UH1
;	.byte PHONEME_UH3	; UH3
	.byte PHONEME_T		; T
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_K		; K	; conjecture
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_J		; J
	.byte PHONEME_E1	; E1
	.byte PHONEME_K		; K
	.byte PHONEME_T		; T
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_I		; I	; is
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_F		; F	; futile.
;	.byte PHONEME_Y1	; Y1
	.byte PHONEME_IU	; IU
;	.byte PHONEME_UI	; UI
	.byte PHONEME_T		; T
	.byte PHONEME_I		; I3
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte $FF

	; "STILL, THE QUESTION ABOUT WHOSE HANDS"
        ; "MIGHT SOMEDAY HOLD MY MYST BOOK ARE"
        ; "UNSETTLING TO ME."
myst_unsettling:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; still
	.byte PHONEME_T		; T
	.byte PHONEME_I		; I
	.byte PHONEME_L		; L
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA	; ,

	.byte PHONEME_THV	; THV	; the
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_K		; K	; question
	.byte PHONEME_W		; W
	.byte PHONEME_EH1	; EH1
;	.byte PHONEME_EH3	; EH3
	.byte PHONEME_S		; S
	.byte PHONEME_T		; T
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH1	; UH1	; about
	.byte PHONEME_B		; B
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_AH	; AH2
	.byte PHONEME_U1	; U1
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_HF	; H	; whose
	.byte PHONEME_IU	; IU
	.byte PHONEME_U1	; U1
	.byte PHONEME_U1	; U1
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_HF	; HF	; hands
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; might
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_AH	; AH2
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; someday
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_M		; M
	.byte PHONEME_D		; D
	.byte PHONEME_AI	; A1
	.byte PHONEME_I		; I3
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_HF	; HF	; hold
	.byte PHONEME_O		; O2
	.byte PHONEME_O		; O2
	.byte PHONEME_L		; L
	.byte PHONEME_L		; L
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; my
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_AH	; AH2
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; MYST
	.byte PHONEME_I		; I
	.byte PHONEME_S		; S
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_B		; B	; book
	.byte PHONEME_OO	; OO1
	.byte PHONEME_OO	; OO1
	.byte PHONEME_K		; K
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AH1	; AH1	; are
	.byte PHONEME_UH2	; UH2
	.byte PHONEME_ER	; ER
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH1	; UH1	; unsettling
	.byte PHONEME_N		; N
	.byte PHONEME_S		; S
	.byte PHONEME_EH1	; EH1
	.byte PHONEME_T		; T
	.byte PHONEME_L		; L
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA


	.byte PHONEME_T		; T	; to
	.byte PHONEME_IU	; IU
	.byte PHONEME_IU	; UI/UI
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; me
	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

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

	.byte PHONEME_N		; AH1	; know
	.byte PHONEME_OO	; OO1
	.byte PHONEME_O		; O1
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_THV	; THV	; that
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; my
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_AH	; AH2
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AE1	; AE1	; apprehensions
	.byte PHONEME_P		; P
	.byte PHONEME_R		; R
	.byte PHONEME_Y		; Y
	.byte PHONEME_HF	; HF
	.byte PHONEME_EH	; EH
	.byte PHONEME_N		; N
	.byte PHONEME_SCH	; SCH
	.byte PHONEME_U1	; U1
	.byte PHONEME_N		; N
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_M		; M	; might
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_AH	; AH2
	.byte PHONEME_Y		; Y
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_N		; N	; never
	.byte PHONEME_EH1	; EH
	.byte PHONEME_V		; V
	.byte PHONEME_R		; R
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_B		; B	; be
	.byte PHONEME_E1	; E1
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_UH1	; UH1	; allayed
	.byte PHONEME_L		; L
	.byte PHONEME_A		; A
	.byte PHONEME_Y		; Y
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA	; ,

	.byte PHONEME_AE1	; AE1	; and
	.byte PHONEME_EH	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_S		; S	; so
	.byte PHONEME_OO	; OO
	.byte PHONEME_O		; O2
	.byte PHONEME_U1	; U1
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_AH1	; AH1	; I
	.byte PHONEME_Y		; Y
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_K		; K	; close
	.byte PHONEME_L		; L
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_O		; O1
	.byte PHONEME_U1	; U1
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA	; ,

	.byte PHONEME_R		; R	; realizing
	.byte PHONEME_E1	; E1
	.byte PHONEME_AY	; AY
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_L		; L
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_Y		; Y
	.byte PHONEME_Z		; Z
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_THV	; THV	; that
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_P		; P	; perhaps
	.byte PHONEME_ER	; ER
	.byte PHONEME_HF	; HF
	.byte PHONEME_AE1	; AE1
	.byte PHONEME_EH	; EH3
	.byte PHONEME_P		; P
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte $FF

	; "THE ENDING HAS NOT YET BEEN WRITTEN."
myst_written:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_THV	; THV	; the
	.byte PHONEME_UH1	; UH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_EH1	; EH1	; ending
;	.byte PHONEME_EH3	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_D		; D
	.byte PHONEME_I		; I
	.byte PHONEME_NG	; NG
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_HF	; H	; has
	.byte PHONEME_AE1	; AE1
;	.byte PHONEME_EH3	; EH3
	.byte PHONEME_Z		; Z
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_N		; N	; not
	.byte PHONEME_AH1	; AH1
	.byte PHONEME_UH3	; UH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_YI	; YI	; yet
	.byte PHONEME_EH1	; EH1
;	.byte PHONEME_EH3	; EH3
	.byte PHONEME_T		; T
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_B		; B	; been
	.byte PHONEME_EH1	; EH1
;	.byte PHONEME_EH3	; EH3
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_R		; R	; written
	.byte PHONEME_I		; I
	.byte PHONEME_T		; T
	.byte PHONEME_N		; N
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA

	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte $FF
