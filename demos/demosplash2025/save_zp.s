

save_zp:
	ldx	#0
save_zp_x:

save_zp_loop:
	lda	$00,X
	sta	zp_save,X

	dex
	bne	save_zp_loop
	lda	$00		; ensure 0 saved as well
	sta	zp_save
	rts

restore_zp:
	ldx	#0
restore_zp_x:
restore_zp_loop:
	lda	zp_save,X
	sta	$00,X
	dex
	bne	restore_zp_loop
	lda	zp_save		; ensure 0 saved as well
	sta	$00
	rts

