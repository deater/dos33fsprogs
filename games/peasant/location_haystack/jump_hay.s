; 25 124
	;===================
	; jump into hay
	;===================
	; draw rather dashing jumping into hay

jump_in_hay:

	lda	#0
	sta	HAY_JUMP_COUNT

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

jump_hay_loop:

	jsr	update_screen

	ldy	HAY_JUMP_COUNT
	ldx	hay_jump_lookup,Y

	lda	PEASANT_X
	clc
	adc	hay_jump_xadd,X
	sta	CURSOR_X
	clc
	lda	PEASANT_Y
	adc	hay_jump_yadd,X
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_mask

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	;=========================
	; move to next frame

	inc	HAY_JUMP_COUNT

	lda	HAY_JUMP_COUNT
	cmp	#14
	bne	jump_hay_loop

done_hay_jump_fall:

	jsr	stop_walking

	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	rts



hay_jump_lookup:
	.byte 0,1,2,3,  4,5,6
	.byte 0,1,2,3,  4,5,6

hay_jump_yadd:
	.byte  0, 0, 0, 0,  0,16,16

hay_jump_xadd:
	.byte  0,$FF,$FF,$FF,  0,$FF,$FF

sprites_data_l:
	.byte <jump_sprite0,<jump_sprite1,<jump_sprite2
	.byte <jump_sprite3,<jump_sprite4,<jump_sprite5
	.byte <jump_sprite6
sprites_data_h:
	.byte >jump_sprite0,>jump_sprite1,>jump_sprite2
	.byte >jump_sprite3,>jump_sprite4,>jump_sprite5
	.byte >jump_sprite6

sprites_mask_l:
	.byte <jump_mask0,<jump_mask1,<jump_mask2
	.byte <jump_mask3,<jump_mask4,<jump_mask5
	.byte <jump_mask6
sprites_mask_h:
	.byte >jump_mask0,>jump_mask1,>jump_mask2
	.byte >jump_mask3,>jump_mask4,>jump_mask5
	.byte >jump_mask6

sprites_xsize:
	.byte  2, 2, 2, 3,  4, 4, 2

sprites_ysize:
	.byte 24,23,30,28, 17,19, 9



