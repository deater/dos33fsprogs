	;=======================
	; HGR Partial Restore
	;=======================
	; loads from $40 (page2)
	; save to $20    (page1)

	; restores from X = A<=to<=X
	;               Y = SAVED_Y1 to SAVED_Y2

hgr_partial_restore:
	sta	partial_restore_x1_smc+1
	stx	partial_restore_x2_smc+1

	ldx	SAVED_Y2			; handle wrap around
	cpx	#192
	bcc	partial_restore_yloop		; assume > 192 off screen negative

	ldx	#0			; X is end y-co-ord?

partial_restore_yloop:

	lda	hposn_low,X
	sta	prx_smc2+1
	sta	prx_smc1+1

	lda	hposn_high,X
	sta	prx_smc2+2
	clc
	adc	#$20
	sta	prx_smc1+2

partial_restore_x2_smc:
	ldy	#$27
partial_restore_xloop:
prx_smc1:
	lda	$d000,Y

prx_smc2:
	sta	$d000,Y
	dey
partial_restore_x1_smc:
	cpy	#$00
	bpl	partial_restore_xloop

	dex
	cpx	SAVED_Y1
	bpl	partial_restore_yloop	; urgh bcs gets stuck

	rts
