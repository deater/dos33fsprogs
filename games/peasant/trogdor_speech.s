
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

	.byte PHONEME_AH1	; AH1	; I'M
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
