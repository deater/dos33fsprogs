	;===================
	; make muddy
	;===================
	; muddy if GAME_STATE_1 and PUDDLE_WET
	; (also implied by GAME_STATE_3 and KERREK_DEAD but not GOT_RICHES)

make_muddy:

	lda	GAME_STATE_1
	and	#PUDDLE_WET
	beq	no_make_muddy

	;========================
	; draw mud to background


	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE
	lda	#$40
	sta	DRAW_PAGE		; draw to $6000

	; mud sprite top

	lda	#11			; 77/7=11
	sta	CURSOR_X
	lda	#126
	sta	CURSOR_Y
	lda	#<mud_sprite0
	sta	INL
	lda	#>mud_sprite0
	sta	INH

	jsr	hgr_draw_sprite

	; mud sprite top

	lda	#11			; 77/7=11
	sta	CURSOR_X
	lda	#140
	sta	CURSOR_Y
	lda	#<mud_sprite1
	sta	INL
	lda	#>mud_sprite1
	sta	INH

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

no_make_muddy:

	rts



	;===================
	; falling into mud
	;===================
	; draw rather dashing falling into mud

fall_into_mud:

	lda	#0
	sta	MUD_COUNT

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

mud_fall_loop:

	jsr	update_screen

	ldy	MUD_COUNT
	ldx	mud_lookup,Y

;	lda	archer_leave_x,X
	lda	PEASANT_X
	sta	CURSOR_X
;	lda	archer_leave_y,X
	lda	PEASANT_Y
	; adc ?
	sta	CURSOR_Y

;	jsr	hgr_sprite_custom_bg_mask

	jsr	hgr_page_flip

	;=========================
	; move to next frame

	inc	MUD_COUNT

	lda	MUD_COUNT
	cmp	#28
	bne	mud_fall_loop

done_mud_fall:

	jsr	stop_walking

	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	rts


	; fall in place?
	; facing right?  (check to see what happens when enter from right)

	; 0:	put on brown pants
	; 1:    slip backward, feet up
	; 2:    sideways
	; 3:    mostly flipped up in air
	; 4:	totally upside down
	; 5:	only feet sticking up, left leg higher
	; 6:	right leg up
	; 5,6,5,6,5,6,5,6,5,6,5,6
	; 7:    pull head up
	; 8:	pull up more
	; 9:	up on elbows
	; 10:	ankle deep
	; 11:	standing face forward (5 frames?)
	; print message


mud_lookup:
	.byte 0,1,2,3, 4,5,6,5
	.byte 6,5,6,5, 6,5,6,5
	.byte 6,5,6,7, 8,9,10,11
	.byte 11,11,11,11

custom_sprites_data_l:
;	.byte <leaving0_sprite,<leaving1_sprite,<leaving2_sprite
custom_sprites_data_h:
;	.byte >leaving0_sprite,>leaving1_sprite,>leaving2_sprite

custom_mask_data_l:
;	.byte <leaving0_mask,<leaving1_mask,<leaving2_mask
custom_mask_data_h:
;	.byte >leaving0_mask,>leaving1_mask,>leaving2_mask

custom_sprites_xsize:
;	.byte 2,2,2
custom_sprites_ysize:
;	.byte 33,33,33



