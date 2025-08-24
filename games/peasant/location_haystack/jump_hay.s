
	;===================
	; jump into hay
	;===================
	; draw rather dashing jumping into hay

	; start standing 168,117?

	; 0:	crouch  (2)	168 (24)	123
	; 1:	crouch2 (6)	168 (24)	124
	; 2:	sprung  (3)	175 (25)	112
	; 3:	lean    (2)     182 (26)	106
	; 4:	arch	(2)	189 (27)	105
	; 5:	head in	(2)	203 (29)	107
	; 6:	all in	(2)	203 (29)	117
	; 12 frames then message

jump_in_hay:

	lda	#0
	sta	HAY_JUMP_COUNT
	sta	HAY_BALE_COUNT

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

jump_hay_loop:

	jsr	update_screen

	ldy	HAY_JUMP_COUNT
	ldx	hay_jump_lookup,Y

	lda	hay_jump_x,X
	sta	SPRITE_X

	lda	hay_jump_y,X
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_mask

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	;=========================
	; move to next frame

	inc	HAY_JUMP_COUNT

	lda	HAY_JUMP_COUNT
	cmp	#16
	bne	jump_hay_loop

done_hay_jump_fall:

	jsr	stop_walking

;	unsuppress drawing after we make noise

;	lda	SUPPRESS_DRAWING
;	and	#<(~SUPPRESS_PEASANT)
;	sta	SUPPRESS_DRAWING

	rts



hay_jump_lookup:
	.byte 0,0,1,1, 1,1,2,2
	.byte 3,3,4,4, 5,5,6,6


hay_jump_x:
	.byte  24,24,25,26,  27,29,29

hay_jump_y:
	.byte  123, 124, 112, 106,  105,107,117

sprites_data_l:
	.byte <jump_sprite0,<jump_sprite1,<jump_sprite2
	.byte <jump_sprite3,<jump_sprite4,<jump_sprite5
	.byte <jump_sprite6

;	.byte <haystack_sprite0,<haystack_sprite1,<haystack_sprite2

sprites_data_h:
	.byte >jump_sprite0,>jump_sprite1,>jump_sprite2
	.byte >jump_sprite3,>jump_sprite4,>jump_sprite5
	.byte >jump_sprite6

;	.byte >haystack_sprite0,>haystack_sprite1,>haystack_sprite2

sprites_mask_l:
	.byte <jump_mask0,<jump_mask1,<jump_mask2
	.byte <jump_mask3,<jump_mask4,<jump_mask5
	.byte <jump_mask6

;	.byte <haystack_mask0,<haystack_mask1,<haystack_mask2

sprites_mask_h:
	.byte >jump_mask0,>jump_mask1,>jump_mask2
	.byte >jump_mask3,>jump_mask4,>jump_mask5
	.byte >jump_mask6

;	.byte >haystack_mask0,>haystack_mask1,>haystack_mask2

sprites_xsize:
	.byte  2, 2, 2, 3,  4, 4, 2

;	.byte  6,6,6

sprites_ysize:
	.byte 24,23,30,28, 17,19, 9

;	.byte 43,43,43

