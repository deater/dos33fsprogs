	;=======================
	; HGR Partial Restore
	;=======================
	; loads from $20
	; save to $40

	; restores from X = A<=to<=X
	;               Y = SAVED_Y1 to SAVED_Y2

hgr_partial_restore:
	sta	partial_restore_x1_smc+1	; update smc with xtart
	stx	partial_restore_x2_smc+1	; update smc with xend

	ldx	SAVED_Y2			; X = yend

partial_restore_yloop:

	lda	hposn_low,X			; get hgr line low address
	sta	prx_smc2+1			; update smc
	sta	prx_smc1+1

	lda	hposn_high,X			; get hgr line high adress
						; in peasant's quest this
						; defaults to the $40 (page2)

	sta	prx_smc2+2			; dest (page2)
	eor	#$60
	sta	prx_smc1+2			; src (page1)

partial_restore_x2_smc:
	ldy	#$27		; xend (smc)
partial_restore_xloop:
prx_smc1:
	lda	$d000,Y
prx_smc2:
	sta	$d000,Y
	dey
partial_restore_x1_smc:
	cpy	#$00		; xstart (smc)
	bpl	partial_restore_xloop

	dex
	cpx	SAVED_Y1
	bcs	partial_restore_yloop	; bge

	rts
