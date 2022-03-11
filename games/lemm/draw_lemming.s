
erase_lemming:
	ldy	#0

	lda	lemming_out,Y
	beq	done_erase_lemming

	lda	lemming_y,Y
	sta	SAVED_Y1
	clc
	adc	#8
	sta	SAVED_Y2

	lda	lemming_x,Y
	tax
	inx
	jsr	hgr_partial_restore

done_erase_lemming:
	rts


draw_lemming:
	ldy	#0

	lda	lemming_out,Y
	beq	done_draw_lemming

	lda	#<lemming_fall1_sprite
	sta	INL
	lda	#>lemming_fall1_sprite
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	sta	YPOS

	jsr	hgr_draw_sprite

done_draw_lemming:
	rts

