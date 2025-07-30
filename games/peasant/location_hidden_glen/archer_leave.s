	;===================
	; archer update bg
	;===================
	; update bg/collision after archer is gone

archer_update_bg:

	; update depth

	; $543: 77->11
	; $545: 77->11
	; $5C3: 77->11
	; $5C4: 17->11
	; $5C5: 77->11
	; $643: 17->11
	; $644: 17->11
	; $645: 77->11
	; $6C4: 77->11
	; $6C5: 77->11
	; $744: 17->11
	; $745: 17->11

	lda	#$11
	sta	$543
	sta	$545
	sta	$5C3
	sta	$5C4
	sta	$5C5
	sta	$643
	sta	$644
	sta	$645
	sta	$6C4
	sta	$6C5
	sta	$744
	sta	$745

	; update collision

	; $94 08->00
	; $95 08->00

	lda	#$00
	sta	collision_location+$94
	sta	collision_location+$95

	rts



	;===================
	; draw archer leave
	;===================
	; draw archer as he leaves

draw_archer_leave:
	lda	#0
	sta	ARCHER_COUNT

leave_loop:

	jsr	update_screen

	ldy	ARCHER_COUNT
	ldx	archer_lookup,Y



	lda	archer_leave_x,Y
	sta	CURSOR_X
	lda	archer_leave_y,Y
	sta	CURSOR_Y

	ldx	archer_leave_which,Y

	jsr	hgr_sprite_custom_bg_mask


	jsr	hgr_page_flip

	;=========================
	; move to next frame

	inc	ARCHER_COUNT

	lda	ARCHER_COUNT
	cmp	#22
	bne	leave_loop

done_leaving:

	rts

	; starts at 196 (28) ,81
	; walks diagonal 13 until he gets to 231 (33), 109
	; then walks right 11 until edge of screen,
	;	4 more partially on screen

archer_leave_x:
	.byte 28,28,29,29, 30,30,31,31, 32,32,33,33
	.byte 34,34,35,35, 36,36,37,37, 38,38
archer_leave_y:
	.byte 83,85,87,89, 91,93,95,97, 99,101,103,105
	.byte 107,109,109,109, 109,109,109,109, 109,109

archer_leave_which:
	.byte 1,2,0,1, 2,0,1,2, 0,1,2,0
	.byte 1,2,0,1, 2,0,1,2, 0,1


custom_sprites_data_l:
	.byte <leaving0_sprite,<leaving1_sprite,<leaving2_sprite
custom_sprites_data_h:
	.byte >leaving0_sprite,>leaving1_sprite,>leaving2_sprite

custom_mask_data_l:
	.byte <leaving0_mask,<leaving1_mask,<leaving2_mask
custom_mask_data_h:
	.byte >leaving0_mask,>leaving1_mask,>leaving2_mask

custom_sprites_xsize:
	.byte 2,2,2
custom_sprites_ysize:
	.byte 33,33,33


