; Lake West

	;************************
	; Lake West
	;************************
lake_west:
	lda	#<(lake_w_lzsa)
	sta	getsrc_smc+1
	lda	#>(lake_w_lzsa)
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

; same message as end of cottage

; walk halfway across the screen

lake_w_message1:
	.byte	0,0,"You head east toward the",0
	.byte	0,0,"mountain atop which TROGDOR lives.",0

; walk to edge
