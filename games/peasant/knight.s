; o/~ One knight in Bangkok makes a hard man humble o/~

	;************************
	; Knight
	;************************
knight:
	lda	#<(knight_lzsa)
	sta	getsrc_smc+1
	lda	#>(knight_lzsa)
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
