tracker_init:

	; setup initial ay-3-8910 values (this depends on song)

	; clear out $60-$90
init_registers_to_zero:

	; done elsewhere

;	ldx	#$30			; init registers to zero
;	lda	#0
;init_loop:
;	sta	AY_REGS-16,X
;	dex
;	bpl	init_loop

	lda	#$38				; ABC channels on
	sta	AY_REGS+7			; $07 mixer
