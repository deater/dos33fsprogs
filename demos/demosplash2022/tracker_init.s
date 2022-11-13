tracker_init:

	; setup initial ay-3-8910 values (this depends on song)

	; claer out $70-$90
init_registers_to_zero:
	ldx	#$20			; init registers to zero
	lda	#0
init_loop:
	sta	AY_REGS,X
	dex
	bpl	init_loop

	lda	#$38				; ABC channels on
	sta	AY_REGS+7			; $07 mixer
