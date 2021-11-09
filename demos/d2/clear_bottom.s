; $650,$6d0,$750,$7d0
clear_both_bottoms:
	lda	#' '|$80
	ldx	#$F7
cbloop:
	sta	$600,X
	sta	$700,X
	sta	$A00,X
	sta	$B00,X
	dex
	bne	cbloop
	rts
