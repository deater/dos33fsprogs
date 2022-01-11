
tracker_init:

	; setup initial ay-3-8910 values (this depends on song)

	lda	#$38
	sta	AY_REGS+7			; $07 mixer (ABC on)
	lda	#$0E
	sta	AY_REGS+8			; $08 volume A
	lda	#$0C
	sta	AY_REGS+9			; $09 volume B
	sta	AY_REGS+10			; $0A volume C
