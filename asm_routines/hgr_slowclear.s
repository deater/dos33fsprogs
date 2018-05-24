	;==========================
	; hgr clear
	;==========================
hgr_clear:
	lda	#$00
	sta	OUTL
	lda	#$20
	sta	OUTH

hgr_clear_loop:
	lda	#$0
	sta	(OUTL),Y
	iny
	bne	hgr_clear_loop

	inc	OUTH
	lda	OUTH
	cmp	#$40
	bne	hgr_clear_loop

	rts

