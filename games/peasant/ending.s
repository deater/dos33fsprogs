; o/~ Bread is a good time for me o/~

	;************************
	; Ending
	;************************
ending:
	lda	#<(trogdor_lzsa)
	sta	getsrc_smc+1
	lda	#>(trogdor_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string


	jsr	wait_until_keypress

	lda	#<(game_over_lzsa)
	sta	getsrc_smc+1
	lda	#>(game_over_lzsa)
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




