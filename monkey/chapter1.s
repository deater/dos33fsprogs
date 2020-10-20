;
;

chapter1_transition:

	;===================================
	; show chpater screen and play music
	;===================================

	lda	#<part1_lzsa
	sta	LZSA_SRC_LO
	lda	#>part1_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	; copy over background
	jsr	gr_copy_to_current

	 ; flip page
	jsr	page_flip

	ldx	#$C0
	jsr	wait_a_bit


	rts
