tracker_init:

	; setup initial ay-3-8910 values (this depends on song)

init_registers_to_zero:
	ldx	#$13			; clear more than have to for other
	lda	#0			; vars
;	sta	SONG_OFFSET		; also in
;	sta	SONG_COUNTDOWN
init_loop:
	sta	AY_REGS,X
	dex
	bpl	init_loop

;	jsr	ay3_write_regs

	lda	#$38
	sta	AY_REGS+7			; $07 mixer (ABC on)
;	lda	#$0E
;	sta	AY_REGS+8			; $08 volume A
;	lda	#$0C
;	sta	AY_REGS+9			; $09 volume B
;	sta	AY_REGS+10			; $0A volume C
