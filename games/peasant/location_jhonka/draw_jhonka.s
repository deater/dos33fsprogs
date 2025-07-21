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
	.byte  5,5,6,6,5,6			; jhonka0..jhonka5

sprites_ysize:
        .byte 24,26,26,23,31,24,24,26		; jhonka0..jhonka5


sprites_data_l:
        .byte <jhonka0_sprite,<jhonka1_sprite,<jhonka2_sprite
        .byte <jhonka3_sprite,<jhonka4_sprite,<jhonka5_sprite

sprites_data_h:
        .byte >jhonka0_sprite,>jhonka1_sprite,>jhonka2_sprite
        .byte >jhonka3_sprite,>jhonka4_sprite,>jhonka5_sprite

sprites_mask_l:
        .byte <jhonka0_mask,<jhonka1_mask,<jhonka2_mask
        .byte <jhonka3_mask,<jhonka4_mask,<jhonka5_mask

sprites_mask_h:
        .byte >jhonka0_mask,>jhonka1_mask,>jhonka2_mask
        .byte >jhonka3_mask,>jhonka4_mask,>jhonka5_mask
