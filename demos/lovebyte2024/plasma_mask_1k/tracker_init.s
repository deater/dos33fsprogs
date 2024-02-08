tracker_init:

	; A must be 0 when calling this!

	; setup initial ay-3-8910 values (this depends on song)

init_registers_to_zero:
	ldx	#$15			; zero $70--$85
;	lda	#0
init_loop:
	sta	AY_REGS,X
	dex
	bpl	init_loop

	lda	#$38
	sta	AY_REGS+7			; $07 mixer (ABC on)
;	lda	#$0E
;	sta	AY_REGS+8                       ; $08 volume A
;	lda	#$0C
;	sta	AY_REGS+9                       ; $09 volume B
;	sta	AY_REGS+10                      ; $0A volume C

