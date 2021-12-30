	;=========================================================
	; hgr copy from $2000 to $4000
	;=========================================================
	; copy $2000 to $4000

	; intentionally slow for the miniblind effect

hgr_copy:
	lda	$0
	sta	INL
	sta	OUTL

	lda	#$20
	sta	INH
	lda	#$40
	sta	OUTH


	ldy	#0
hgr_copy_outer:

hgr_copy_inner:
	lda	#1
	jsr	wait

	lda	(INL),Y
	sta	(OUTL),Y
	iny
	bne	hgr_copy_inner

	inc	INH
	inc	OUTH
	lda	OUTH
	cmp	#$60
	bne	hgr_copy_outer

	rts



