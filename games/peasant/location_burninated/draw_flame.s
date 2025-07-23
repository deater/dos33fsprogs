	;========================
	; animate flame
	;=========================
draw_flame:

	; only at night

	lda	GAME_STATE_1
	and	#NIGHT
	beq	done_animate_flame

	lda     FRAME
	lsr
	and	#$3
	tay

	ldx	flame_sequence,Y

	lda	flame_sprite_l,X
	sta	INL
	lda	flame_sprite_h,X
	sta	INH

	lda	#11		; 77/7 = 11
	sta     CURSOR_X
	lda	#118
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		;
done_animate_flame:
	rts

flame_sequence:
	.byte 0,1,2,3

flame_sprite_l:
	.byte <flame0,<flame1,<flame2,<flame3

flame_sprite_h:
	.byte >flame0,>flame1,>flame2,>flame3
