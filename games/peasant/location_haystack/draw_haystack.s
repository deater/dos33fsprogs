	;===================
	; draw haystack
	;===================
	; check if in haystack
	; then draw it, at peasantX-2, peasant_Y-?

draw_haystack:

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	done_draw_haystack

	ldx	HAY_BALE_COUNT

	lda	PEASANT_X
	sec
	sbc	#2
	sta	CURSOR_X

	lda	PEASANT_Y
	sec
	sbc	#5
	sta	CURSOR_Y

	jsr	hgr_sprite_custom_bg_mask


	;=========================
	; move to next frame
	;	only if walking?

	jsr	check_moving
	bcc	done_draw_haystack

	inc	HAY_BALE_COUNT
	lda	HAY_BALE_COUNT
	cmp	#3
	bne	done_draw_haystack

	lda	#0
	sta	HAY_BALE_COUNT

done_draw_haystack:

	rts

.if 0
custom_sprites_data_l:
	.byte <haystack_sprite0,<haystack_sprite1,<haystack_sprite2
custom_sprites_data_h:
	.byte >haystack_sprite0,>haystack_sprite1,>haystack_sprite2

custom_mask_data_l:
	.byte <haystack_mask0,<haystack_mask1,<haystack_mask2
custom_mask_data_h:
	.byte >haystack_mask0,>haystack_mask1,>haystack_mask2

custom_sprites_xsize:
	.byte 6,6,6
custom_sprites_ysize:
	.byte 43,43,43

.endif
