
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


draw_falling_sprite:

	lda	lemming_frame,Y
	and	#$3
	tax

	lda	lemming_direction,Y
	bpl	draw_falling_right

draw_falling_left:
	lda	lfall_sprite_l,X
	sta	INL
	lda	lfall_sprite_h,X
	jmp	draw_falling_common

draw_falling_right:
	lda	rfall_sprite_l,X
	sta	INL
	lda	rfall_sprite_h,X

draw_falling_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	sta	YPOS

	jsr	hgr_draw_sprite

done_draw_lemming:
	rts


lfall_sprite_l:
	.byte <lemming_lfall1_sprite,<lemming_lfall2_sprite
	.byte <lemming_lfall3_sprite,<lemming_lfall4_sprite
lfall_sprite_h:
	.byte >lemming_lfall1_sprite,>lemming_lfall2_sprite
	.byte >lemming_lfall3_sprite,>lemming_lfall4_sprite

rfall_sprite_l:
	.byte <lemming_rfall1_sprite,<lemming_rfall2_sprite
	.byte <lemming_rfall3_sprite,<lemming_rfall4_sprite
rfall_sprite_h:
	.byte >lemming_rfall1_sprite,>lemming_rfall2_sprite
	.byte >lemming_rfall3_sprite,>lemming_rfall4_sprite


