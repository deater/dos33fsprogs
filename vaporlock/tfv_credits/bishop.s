	STA $C052
	LDA #$E0
l0305:
	LDX #$04
l0307:
	CMP $C051
	BNE l0305
	DEX
	BNE l0307
	LDA #$A0
l0311:
	LDX #$04
l0313:
	CMP $C050
	BNE l0311
	DEX
	BNE l0313
	STA $C051
	RTS