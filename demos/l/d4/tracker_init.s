tracker_init:

	; setup initial ay-3-8910 values (this depends on song)

init_registers_to_zero:
	ldx	#$13			; zero $70--$83
	lda	#0
;	sta	SONG_OFFSET		; also init song stuff
;	sta	SONG_COUNTDOWN
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

