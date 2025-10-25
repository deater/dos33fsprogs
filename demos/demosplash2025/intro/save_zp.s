

save_zp:
	ldx	#0
save_zp_loop:
	lda	$00,X
	sta	$A000,X
	dex
	bne	save_zp_loop
	rts

restore_zp:
	ldx	#0
restore_zp_loop:
	lda	$A000,X
	sta	$00,X
	dex
	bne	restore_zp_loop
	rts

