	;===================
	; draw jhonka
	;===================
	; draw jhonka when necessary
	;	see lower down for the progression
	; TODO: handle when someone stands in way

draw_jhonka:
	; first check if he's there

	lda	KERREK_STATE
	and	#$f
	beq	done_draw_jhonka


	lda	JHONKA_COUNT
	cmp	#26
	bne	no_reset_jhonka

	lda	#0
	sta	JHONKA_COUNT

no_reset_jhonka:

	ldy	JHONKA_COUNT
	ldx	jhonka_lookup,Y

	lda	jhonka_x,Y
	sta	SPRITE_X
	lda	jhonka_y,Y
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_mask

	;=========================
	; move to next frame

	inc	JHONKA_COUNT

done_draw_jhonka:

	rts

	;========================
	; 0 for 24 cycles
	; 1 (taller, club down) for 16?
	; 0 (down, club down)  for 16?
	; 1 (taller, club down) for 16?
	; 0 (down, club down)  for 16?
	; 2 (taller, club out) for 6
	; 3 (smaller, club out) but 2 pixels in air? for 6
	; 3 (smaller, club out) but 2 pixels in air? for 6



jhonka_lookup:
	.byte 0,0,0,0;,0,0,0,0
	.byte 1,1,1,1,0,0,0,0
	.byte 1,1,1,1,0,0,0,0
	.byte 2,2,3,3,3,3

	; 168,123  (168/7=24)

jhonka_x:
	.byte 24,24,24,24;,24,24,24,24
	.byte 24,24,24,24,24,24,24,24
	.byte 24,24,24,24,24,24,24,24
	.byte 23,23,23,23,23,23

jhonka_y:
	.byte 123,123,123,123;,123,123,123,123
	.byte 121,121,121,121,123,123,123,123
	.byte 121,121,121,121,123,123,123,123
	.byte 121,121,121,124,124,124

sprites_xsize:
	.byte  5,5,6,6			; jhonka0..jhonka3
	.byte  5,5,6,6			; jhonka4..jhonka7
	.byte  5,6			; jhonka8..jhonka9

sprites_ysize:
        .byte 24,26,26,23		; jhonka0..jhonka3
        .byte 24,26,26,23		; jhonka4..jhonka7
	.byte 31,24			; jhonka8..jhonka9

	; note: 6 never used?

	; 0 = club on left,  club down, knees bent
	; 1 = club on left,  club down, standing
	; 2 = club on left,  club out, standing
	; 3 = club of left,  club out, knees bent
	; 4 = club on right, club down, knees bent
	; 5 = club on right, club down, standing
	; 6 = club on right, club out, standing
	; 7 = club of right, club out, knees bent
	; 8 = club on right, club raised
	; 9 = club on right, club hitting

sprites_data_l:
        .byte <jhonka0_sprite,<jhonka1_sprite,<jhonka2_sprite,<jhonka3_sprite
	.byte <jhonka4_sprite,<jhonka5_sprite,<jhonka6_sprite,<jhonka7_sprite
	.byte <jhonka8_sprite,<jhonka9_sprite

sprites_data_h:
        .byte >jhonka0_sprite,>jhonka1_sprite,>jhonka2_sprite,>jhonka3_sprite
	.byte >jhonka4_sprite,>jhonka5_sprite,>jhonka6_sprite,>jhonka7_sprite
	.byte >jhonka8_sprite,>jhonka9_sprite

sprites_mask_l:
        .byte <jhonka0_mask,<jhonka1_mask,<jhonka2_mask,<jhonka3_mask
	.byte <jhonka4_mask,<jhonka5_mask,<jhonka6_mask,<jhonka7_mask
	.byte <jhonka8_mask,<jhonka9_mask

sprites_mask_h:
        .byte >jhonka0_mask,>jhonka1_mask,>jhonka2_mask,>jhonka3_mask
	.byte >jhonka4_mask,>jhonka5_mask,>jhonka6_mask,>jhonka7_mask
	.byte >jhonka8_mask,>jhonka9_mask
