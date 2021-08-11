; Lake East

	;************************
	; Lake East
	;************************
lake_east:
	lda	#<(lake_e_lzsa)
	sta	getsrc_smc+1
	lda	#>(lake_e_lzsa)
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



; walk sideways, near corner

lake_e_message1:
	.byte 0,0,"That's a nice looking lake.",0

; nearly hit head on sign, it goes away, walk off screen

