; o/~ At the beautiful, the beautiful, River o/~

	;************************
	; River
	;************************
river:
	lda	#<(river_lzsa)
	sta	getsrc_smc+1
	lda	#>(river_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string


	jsr	wait_until_keypress

	rts


; walk up a bit

river_message1:
	.byte 0,0,"You can start playing in a",0
	.byte 0,0,"second here.",0

; walks behind tree
