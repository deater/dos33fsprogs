fast_hclr:
	lda	HGR_PAGE
	sta	hclr_smc+2
	ldy	#0
hclr_outer:
	tya
hclr_inner:
hclr_smc:
	sta	$2000,Y
	iny
	bne	hclr_inner

	inc	hclr_smc+2
	lda	hclr_smc+2
	and	#$1f
	bne	hclr_outer

	rts
