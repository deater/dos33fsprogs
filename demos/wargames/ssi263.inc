SPEECH_PTRL	= $FE
SPEECH_PTRH	= $FF

SSI263_BASE	= $40		; First speech chip
SSI263_DRP	= SSI263_BASE+$00	; Reg0, Duration/Phoneme
SSI263_I	= SSI263_BASE+$01	; Reg1, Inflection
SSI263_RI	= SSI263_BASE+$02	; Reg2, Rate/Inflection
SSI263_CAA	= SSI263_BASE+$03	; Reg3, Control/Articulation/Amplitude
SSI263_F	= SSI263_BASE+$04	; Reg4, Filter Frequency
VIA6522_DDRB1	= $02		; 6522 Data direction port B register
VIA6522_DDRA1	= $03		; 6522 Data direction port A register
VIA6522_PCR2	= $8C           ; 6522 #2 Peripheral control register
VIA6522_IFR2	= $8D           ; 6522 #2 Interrupt flag register
VIA6522_IER2	= $8E		; 6522 #2 Interrupt enable register

VIA6522_IFR2_CA1 = $02

VIA6522_IER2_SET = $80
VIA6522_IER2_CA1 = $02

VIA6522_PCR2_CA2_LOW = $0C
VIA6522_PCR2_CA2_HI  = $0E

VIA6522_PCR2_CA1_NEG = $00
VIA6522_PCR2_CA1_POS = $01


SSI263_CAA_CTL	= $80	; control bit

SSI263_DRP_TRANSITIONED_INFLECTION		= $C0
SSI263_DRP_PHONEME_TIMING_IMMEDIATE_INFLECTION	= $80
SSI263_DRP_FRAME_TIMING_IMMEDIATE_INFLECTION	= $40
SSI263_DRP_DISABLE_AR				= $00

DURATION_LONG	= $00

PHONEME_PAUSE	= $00	; Pause
PHONEME_E	= $01	; mEEt
PHONEME_E1	= $02	; bEnt
PHONEME_Y	= $03	; bEfore
PHONEME_YI	= $04	; Year
PHONEME_AY	= $05	; plEAse
PHONEME_IE	= $06	; anY
PHONEME_I	= $07	; sIx
PHONEME_A	= $08	; mAde
PHONEME_AI	= $09	; cAre
PHONEME_EH	= $0A	; nEst
PHONEME_EH1	= $0B	; bElt
PHONEME_AE	= $0C	; dAd
PHONEME_AE1	= $0D	; After
PHONEME_AH	= $0E	; gOt
PHONEME_AH1	= $0F	; fAther
PHONEME_AW	= $10	; Office
PHONEME_O	= $11	; stOre
PHONEME_OU	= $12	; bOAt
PHONEME_OO	= $13	; lOOk
PHONEME_IU	= $14	; yOU
PHONEME_IU1	= $15	; cOUld
PHONEME_U	= $16	; tUne
PHONEME_U1	= $17	; cartOOn
PHONEME_UH	= $18	; wOnder
PHONEME_UH1	= $19	; lOve
PHONEME_UH2	= $1A	; whAt
PHONEME_UH3	= $1B	; nUt
PHONEME_ER	= $1C	; bIRd
PHONEME_R	= $1D	; Roof
PHONEME_R1	= $1E	; Rug
PHONEME_R2	= $1F	; muetteR (German)
PHONEME_L	= $20	; Lift
PHONEME_L1	= $21	; pLay
PHONEME_LF	= $22	; falL (final)
PHONEME_W	= $23	; Water
PHONEME_B	= $24	; Bag
PHONEME_D	= $25	; paiD
PHONEME_KV	= $26	; taG (glottal stop)
PHONEME_P	= $27	; Pen
PHONEME_T	= $28	; Tart
PHONEME_K	= $29	; Kit
PHONEME_HV	= $2A	; (hold vocal)
PHONEME_HVC	= $2B	; (hold vocal closure)
PHONEME_HF	= $2C	; Heart
PHONEME_HFC	= $2D	; (hold frictive closure)
PHONEME_HN	= $2E	; (hold nasal)
PHONEME_Z	= $2F	; Zero
PHONEME_S	= $30	; Same
PHONEME_J	= $31	; meaSure
PHONEME_SCH	= $32	; SHip
PHONEME_V	= $33	; Very
PHONEME_F	= $34	; Four
PHONEME_THV	= $35	; THere
PHONEME_TH	= $36	; wiTH
PHONEME_M	= $37	; More
PHONEME_N	= $38	; NiNe
PHONEME_NG	= $39	; raNG
PHONEME_CA	= $3A	; mAerchen (German)
PHONEME_COH	= $3B	; lOwe (French)
PHONEME_CU	= $3C	; fUenf (German)
PHONEME_CUH	= $3D	; menU (French)
PHONEME_E2	= $3E	; bittE (German)
PHONEME_LB	= $3F	; Lube
