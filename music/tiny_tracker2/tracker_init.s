
tracker_init:

	; create Frequency Table
	ldx	#11
make_freq_loop:
	sec
	lda	frequency_lookup_low,X
	ror
	sta	frequency_lookup_low+16,X
	lsr
	sta	frequency_lookup_low+32,X
	lsr
	sta	frequency_lookup_low+48,X

	dex
	bpl	make_freq_loop

	inx
	stx	frequency_lookup_low+28

	; setup initial ay-3-8910 values (this depends on song)

	lda	#$38
	sta	AY_REGS+7			; $07 mixer (ABC on)
	lda	#$0E
	sta	AY_REGS+8			; $08 volume A
	lda	#$0C
	sta	AY_REGS+9			; $09 volume B
	sta	AY_REGS+10			; $0A volume C
