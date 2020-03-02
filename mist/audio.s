; Based on BTC.SYSTEM by Oliver Schmidt

; How to generate proper audio for this:

; -Open MP3 in Audacity
; -Change Project Rate (Hz) to 33,000 (bottom left box)
; -Tracks --> Mix... --> Mix Stereo Down to Mono
; -File --> Export --> Export as WAV
; - Select "WAV (Microsoft) signed 16-bit PCM"
; - Under "Edit Metadata Tags" hit "Clear", then "Okay"
; -Open saved WAV file in BTc Sound Encoder 3.0
; -Change Algorithm to "1 bit" (leave fineness as BTc16)
; -File --> Export binary file .BTC format


spkr	=	$C030

;****************************************************************
;*                        Audio playback                        *
;****************************************************************
; audio file in BTC_L/BTC_H
; pages to play in X


play_audio:
	ldy	#0

 ; loop here as long as BITs are [F]alse (aka 0)
F_NX:	NOP			; 2 2
	NOP			; 2 2
	NOP			; 2 2
	BIT	$00		; 3 3
F_RD:	LDA	(BTC_L),y	; 5 5 5
	ASL			; 2 2 2
	BCS	T_1_SW		; 2/3 2
	NOP			; 2 2
	NOP			; 2 2
	NOP			; 2 2
	NOP			; 2 2
F_1:	JSR	delay		; 6 (+13) 19
	ASL			; 2 2 = 31
	BCS	T_2_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
F_2:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCS	T_3_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
F_3:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCS	T_4_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
F_4:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCS	T_5_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
F_5:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCS	T_6_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
F_6:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCS	T_7_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
F_7:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCS	T_8_SW		; 2/3 2 2
	NOP			; 2 2 2
	NOP			; 2 2 2
	NOP			; 2 2 2
	NOP			; 2 2 2
F_8:	INY			; 2 2 2
	BNE	F_NX		; 2/3 3 = 31 2
	INC	BTC_H		; 5 5
	DEX			; 2 2
	BNE	F_RD		; 2/3 3 = 31
	RTS
				; click speaker on transitions
T_1_SW:	STA	spkr		; 4 [SW]itch to [T]rue on BIT [1]
	BCS	T_1		; 3 (always)
T_2_SW:	STA	spkr		; 4 [SW]itch to [T]rue on BIT [2]
	BCS	T_2		; 3 (always)
T_3_SW:	STA	spkr		; 4 [SW]itch to [T]rue on BIT [3]
	BCS	T_3		; 3 (always)
T_4_SW:	STA	spkr		; 4 [SW]itch to [T]rue on BIT [4]
	BCS	T_4		; 3 (always)
T_5_SW:	STA	spkr		; 4 [SW]itch to [T]rue on BIT [5]
	BCS	T_5		; 3 (always)
T_6_SW:	STA	spkr		; 4 [SW]itch to [T]rue on BIT [6]
	BCS	T_6		; 3 (always)
T_7_SW:	STA	spkr		; 4 [SW]itch to [T]rue on BIT [7]
	BCS	T_7		; 3 (always)
T_8_SW:	STA	spkr		; 4 [SW]itch to [T]rue on BIT [8]
	BCS	T_8		; 3 (always)

F_1_SW:	STA	spkr		; 4 [SW]itch to [F]alse on BIT [1]
	BCC	F_1		; 3 (always)
F_2_SW:	STA	spkr		; 4 [SW]itch to [F]alse on BIT [2]
	BCC	F_2		; 3 (always)
F_3_SW:	STA	spkr		; 4 [SW]itch to [F]alse on BIT [3]
	BCC	F_3		; 3 (always)
F_4_SW:	STA	spkr		; 4 [SW]itch to [F]alse on BIT [4]
	BCC	F_4		; 3 (always)
F_5_SW:	STA	spkr		; 4 [SW]itch to [F]alse on BIT [5]
	BCC	F_5		; 3 (always)
F_6_SW:	STA	spkr		; 4 [SW]itch to [F]alse on BIT [6]
	BCC	F_6		; 3 (always)
F_7_SW:	STA	spkr		; 4 [SW]itch to [F]alse on BIT [7]
	BCC	F_7		; 3 (always)
F_8_SW:	STA	spkr		; 4 [SW]itch to [F]alse on BIT [8]
	BCC	F_8		; 3 (always)

 ; loop here as long as BITs are [T]rue (aka 1)
T_NX:	NOP			; 2
	NOP			; 2
	NOP			; 2
	BIT	$00		; 3
T_RD:	LDA	(BTC_L),y		; 5
	ASL			; 2
	BCC	F_1_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
T_1:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCC	F_2_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
T_2:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCC	F_3_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
T_3:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCC	F_4_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
T_4:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCC	F_5_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
T_5:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCC	F_6_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
T_6:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCC	F_7_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
T_7:	JSR	delay		; 6 (+13)
	ASL			; 2
	BCC	F_8_SW		; 2/3
	NOP			; 2
	NOP			; 2
	NOP			; 2
	NOP			; 2
T_8:	INY			; 2
	BNE	T_NX		; 2/3
	INC	BTC_H		; 5
	DEX			; 2
	BNE	T_RD		; 2/3
	RTS

delay:
	nop			; 2
	nop			; 2
	BIT	$00		; 3
	RTS			; 6 = 13


