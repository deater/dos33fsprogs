
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

	lda	lemming_status,Y
	cmp	#LEMMING_DIGGING
	beq	draw_digging_sprite


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
	jmp	draw_common


	;======================
	; digging

draw_digging_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	dig_sprite_l,X
	sta	INL
	lda	dig_sprite_h,X
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	sec
	sbc	#2
	jmp	draw_common



draw_common:
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


dig_sprite_l:
	.byte <lemming_dig1_sprite,<lemming_dig2_sprite
	.byte <lemming_dig3_sprite,<lemming_dig4_sprite
	.byte <lemming_dig5_sprite,<lemming_dig6_sprite
	.byte <lemming_dig7_sprite,<lemming_dig8_sprite
dig_sprite_h:
	.byte >lemming_dig1_sprite,>lemming_dig2_sprite
	.byte >lemming_dig3_sprite,>lemming_dig4_sprite
	.byte >lemming_dig5_sprite,>lemming_dig6_sprite
	.byte >lemming_dig7_sprite,>lemming_dig8_sprite

