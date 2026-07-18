
	;=======================
	;=======================
	; kerrek draw
	;=======================
	;=======================
kerrek_draw:

	; first, only if kerrek out

	lda	KERREK_STATE
	bpl	kerrek_no_draw

	; next, see if kerrek alive
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_no_draw
	beq	kerrek_actually_draw

kerrek_no_draw:
	rts

kerrek_actually_draw:

	lda	KERREK_X
	sta	SPRITE_X
	lda	KERREK_Y
	sta	SPRITE_Y

	ldx	KERREK_COUNT

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=LEFT
	beq	kerrek_correct_dir

	txa				; could just OR with 8?
	clc
	adc	#$8
	tax

kerrek_correct_dir:
	jsr	hgr_draw_sprite_mask

	rts				; tail call?




sprites_mask_l:
	.byte <kerrek_walk0l_mask,<kerrek_walk1l_mask
	.byte <kerrek_walk2l_mask,<kerrek_walk3l_mask
	.byte <kerrek_walk4l_mask,<kerrek_walk5l_mask
	.byte <kerrek_walk6l_mask,<kerrek_walk7l_mask

	.byte <kerrek_walk0r_mask,<kerrek_walk1r_mask
	.byte <kerrek_walk2r_mask,<kerrek_walk3r_mask
	.byte <kerrek_walk4r_mask,<kerrek_walk5r_mask
	.byte <kerrek_walk6r_mask,<kerrek_walk7r_mask


	; right first?
	.byte <kerrek_body0r_mask,<kerrek_body1r_mask
	.byte <kerrek_body2r_mask,<kerrek_body3r_mask
	; left next
	.byte <kerrek_body0l_mask,<kerrek_body1l_mask
	.byte <kerrek_body2l_mask,<kerrek_body3l_mask
	; flies
	.byte <kerrek_flies0_mask,<kerrek_flies1_mask,<kerrek_flies2_mask

sprites_mask_h:
	.byte >kerrek_walk0l_mask,>kerrek_walk1l_mask
	.byte >kerrek_walk2l_mask,>kerrek_walk3l_mask
	.byte >kerrek_walk4l_mask,>kerrek_walk5l_mask
	.byte >kerrek_walk6l_mask,>kerrek_walk7l_mask

	.byte >kerrek_walk0r_mask,>kerrek_walk1r_mask
	.byte >kerrek_walk2r_mask,>kerrek_walk3r_mask
	.byte >kerrek_walk4r_mask,>kerrek_walk5r_mask
	.byte >kerrek_walk6r_mask,>kerrek_walk7r_mask


	; right first?
	.byte >kerrek_body0r_mask,>kerrek_body1r_mask
	.byte >kerrek_body2r_mask,>kerrek_body3r_mask
	; left next
	.byte >kerrek_body0l_mask,>kerrek_body1l_mask
	.byte >kerrek_body2l_mask,>kerrek_body3l_mask
	; flies
	.byte >kerrek_flies0_mask,>kerrek_flies1_mask,>kerrek_flies2_mask

sprites_data_l:
	.byte <kerrek_walk0l_sprite,<kerrek_walk1l_sprite
	.byte <kerrek_walk2l_sprite,<kerrek_walk3l_sprite
	.byte <kerrek_walk4l_sprite,<kerrek_walk5l_sprite
	.byte <kerrek_walk6l_sprite,<kerrek_walk7l_sprite

	.byte <kerrek_walk0r_sprite,<kerrek_walk1r_sprite
	.byte <kerrek_walk2r_sprite,<kerrek_walk3r_sprite
	.byte <kerrek_walk4r_sprite,<kerrek_walk5r_sprite
	.byte <kerrek_walk6r_sprite,<kerrek_walk7r_sprite

	; right first?
	.byte <kerrek_body0r_sprite,<kerrek_body1r_sprite
	.byte <kerrek_body2r_sprite,<kerrek_body3r_sprite
	; left next
	.byte <kerrek_body0l_sprite,<kerrek_body1l_sprite
	.byte <kerrek_body2l_sprite,<kerrek_body3l_sprite
	; flies
	.byte <kerrek_flies0_sprite,<kerrek_flies1_sprite,<kerrek_flies2_sprite

sprites_data_h:
	.byte >kerrek_walk0l_sprite,>kerrek_walk1l_sprite
	.byte >kerrek_walk2l_sprite,>kerrek_walk3l_sprite
	.byte >kerrek_walk4l_sprite,>kerrek_walk5l_sprite
	.byte >kerrek_walk6l_sprite,>kerrek_walk7l_sprite

	.byte >kerrek_walk0r_sprite,>kerrek_walk1r_sprite
	.byte >kerrek_walk2r_sprite,>kerrek_walk3r_sprite
	.byte >kerrek_walk4r_sprite,>kerrek_walk5r_sprite
	.byte >kerrek_walk6r_sprite,>kerrek_walk7r_sprite

	; right first?
	.byte >kerrek_body0r_sprite,>kerrek_body1r_sprite
	.byte >kerrek_body2r_sprite,>kerrek_body3r_sprite
	; left next
	.byte >kerrek_body0l_sprite,>kerrek_body1l_sprite
	.byte >kerrek_body2l_sprite,>kerrek_body3l_sprite
	; flies
	.byte >kerrek_flies0_sprite,>kerrek_flies1_sprite,>kerrek_flies2_sprite

sprites_xsize:
	.byte 3,3,3,3, 3,3,3,3, 3,3,3,3, 3,3,3,3

	.byte 7,7,7,7, 7,7,7,7, 3,3,3
sprites_ysize:
	.byte 48,48,48,48, 48,48,48,48, 48,48,48,48, 48,48,48,48

	.byte 14,14,14,14, 14,14,14,14, 11,11,10
