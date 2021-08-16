	;=======================
	; HGR Partial Save
	;=======================
	; loads from $40
	; save to $20
	; only save from row in P2 to P2+P4
hgr_partial_save:

	clc
	lda	BOX_Y1
	sta	SAVED_Y1

	ldx	BOX_Y2
	stx	SAVED_Y2

partial_save_yloop:

	lda	hposn_low,X
	sta	psx_smc1+1
	sta	psx_smc2+1

	lda	hposn_high,X
	sta	psx_smc1+2
	sec
	sbc	#$20
	sta	psx_smc2+2

	ldy	#$27
partial_save_xloop:
psx_smc1:
	lda	$d000,Y
psx_smc2:
	sta	$d000,Y
	dey
	bpl	partial_save_xloop

	dex
	cpx	BOX_Y1
	bcs	partial_save_yloop

	rts



	;=======================
	; HGR Partial Restore
	;=======================
	; loads from $20
	; save to $40

hgr_partial_restore:

	ldx	SAVED_Y2

partial_restore_yloop:

	lda	hposn_low,X
	sta	prx_smc2+1
	sta	prx_smc1+1

	lda	hposn_high,X
	sta	prx_smc2+2
	sec
	sbc	#$20
	sta	prx_smc1+2

	ldy	#$27
partial_restore_xloop:
prx_smc1:
	lda	$d000,Y
prx_smc2:
	sta	$d000,Y
	dey
	bpl	partial_restore_xloop

	dex
	cpx	SAVED_Y1
	bcs	partial_restore_yloop	; bge

	rts
