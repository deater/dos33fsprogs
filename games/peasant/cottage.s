; THATCHED ROOF COTTAGES

cottage:

	;************************
	; Cottage
	;************************

	lda	#<(cottage_lzsa)
	sta	getsrc_smc+1
	lda	#>(cottage_lzsa)
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

peasant_text:
	.byte 25,2,"Peasant's Quest",0
