

draw_lemming:

	lda	lemming_out
	beq	done_draw_lemming

	lda	#<lemming_fall1_sprite
	sta	INL
	lda	#>lemming_fall1_sprite
	sta	INH

	ldx	lemming_x
        stx     XPOS
	lda	lemming_y
	sta	YPOS

	jsr	hgr_draw_sprite

done_draw_lemming:
	rts

