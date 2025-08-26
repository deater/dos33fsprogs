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

	lda	PEASANT_X
	clc
	adc	mud_xadd,X
	sta	CURSOR_X
	clc
	lda	PEASANT_Y
	adc	mud_yadd,X
	sta	CURSOR_Y

	jsr	hgr_sprite_custom_bg_mask

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

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
	; 5:	only feet sticking up, left leg higher, mud
	; 6:	right leg up, mud
	; 7:	left leg up, less mud
	; 8:    right leg, no mud
	; 9:	left leg, no mud
	; 8,9,8,9,8,9,8,9,8,9,8,9
	; 10:    pull head up
	; 11:	pull up more
	; 12:	up on elbows
	; 13:	ankle deep
	; 14:	standing face forward (5 frames?)
	; print message


mud_lookup:
	.byte 0,1,2,3,  4,5,6,7
	.byte 8,9,8,9,  8,9,8,9
	.byte 8,9,8,10, 11,12,13,14
	.byte 14,14,14,14

mud_yadd:
	.byte  0, 0, 0, 0,  0,16,16,16
	.byte 16,16,19,19, 16, 6, 0

mud_xadd:
	.byte  0,$FF,$FF,$FF,  0,$FF,$FF,$FF
	.byte $FF,$FF,$FF,0, 0, 0, 0


custom_sprites_data_l:
	.byte <fall0_sprite,<fall1_sprite,<fall2_sprite
	.byte <fall3_sprite,<fall4_sprite,<fall5_sprite
	.byte <fall6_sprite,<fall7_sprite,<fall8_sprite
	.byte <fall9_sprite,<fall10_sprite,<fall11_sprite
	.byte <fall12_sprite,<fall13_sprite,<fall14_sprite

	.byte <blown_sprite0,<blown_sprite1,<blown_sprite2
	.byte <blown_sprite3,<blown_sprite4

custom_sprites_data_h:
	.byte >fall0_sprite,>fall1_sprite,>fall2_sprite
	.byte >fall3_sprite,>fall4_sprite,>fall5_sprite
	.byte >fall6_sprite,>fall7_sprite,>fall8_sprite
	.byte >fall9_sprite,>fall10_sprite,>fall11_sprite
	.byte >fall12_sprite,>fall13_sprite,>fall14_sprite

	.byte >blown_sprite0,>blown_sprite1,>blown_sprite2
	.byte >blown_sprite3,>blown_sprite4

custom_mask_data_l:
	.byte <fall0_mask,<fall1_mask,<fall2_mask
	.byte <fall3_mask,<fall4_mask,<fall5_mask
	.byte <fall6_mask,<fall7_mask,<fall8_mask
	.byte <fall9_mask,<fall10_mask,<fall11_mask
	.byte <fall12_mask,<fall13_mask,<fall14_mask

	.byte <blown_mask0,<blown_mask1,<blown_mask2
	.byte <blown_mask3,<blown_mask4

custom_mask_data_h:
	.byte >fall0_mask,>fall1_mask,>fall2_mask
	.byte >fall3_mask,>fall4_mask,>fall5_mask
	.byte >fall6_mask,>fall7_mask,>fall8_mask
	.byte >fall9_mask,>fall10_mask,>fall11_mask
	.byte >fall12_mask,>fall13_mask,>fall14_mask

	.byte >blown_mask0,>blown_mask1,>blown_mask2
	.byte >blown_mask3,>blown_mask4

custom_sprites_xsize:
	.byte  2, 4, 4, 4,  2, 4, 4, 4
	.byte  4, 4, 4, 2,  2, 2, 2

	.byte  6, 6, 7, 4, 2

custom_sprites_ysize:
	.byte 30,29,18,24, 30,12,12,12
	.byte 12,12, 9, 9, 13,23,30

	.byte 43,35,32,26,11

