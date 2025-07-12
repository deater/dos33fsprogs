
	;=======================
	; draw bow
	;=======================
draw_bow:

	lda	#0
	sta	BOW_INDEX

	; check if odd or even

	lda	BOW_X
	and	#$1
	eor	#$1			; our sprite X is off by one
	asl
	asl
	sta	draw_bow_smc+1

draw_bow_loop:
	clc
	lda	BOW_INDEX
draw_bow_smc:
	adc	#0
	tax

	; set xpos,ypos

	clc
	lda	BOW_X
	adc	bow_sprite_offsets,X
	sta	CURSOR_X
	lda	#159
	sta	CURSOR_Y

	; set up sprites

	lda	bow_sprites_l,X
	sta	INL
	lda	bow_sprites_h,X
	sta	INH

	jsr	hgr_draw_sprite

	inc	BOW_INDEX
	lda	BOW_INDEX
	cmp	#4
	bne	draw_bow_loop


	rts



	;=======================
	; draw string
	;=======================
draw_string:

	lda	#0
	sta	BOW_INDEX

	; check if odd or even

	lda	BOW_X
	and	#$1
	eor	#$1			; our sprite X is off by one
	asl
	sta	draw_string_smc+1

draw_string_loop:
	clc
	lda	BOW_INDEX
draw_string_smc:
	adc	#0
	tax

	; set xpos,ypos

	clc
	lda	BOW_X
	adc	string_sprite_offsets,X
	sta	CURSOR_X
	lda	#183
	sta	CURSOR_Y

	; set up sprites

	lda	string_sprites_l,X
	sta	INL
	lda	string_sprites_h,X
	sta	INH

	jsr	hgr_draw_sprite

	inc	BOW_INDEX
	lda	BOW_INDEX
	cmp	#2
	bne	draw_string_loop


	rts


bow_sprite_offsets:
	.byte 0,8,15,22,0,8,15,22

bow_sprites_l:
	.byte <bow_sprite_odd0,<bow_sprite_odd1
	.byte <bow_sprite_odd2,<bow_sprite_odd3
	.byte <bow_sprite_even0,<bow_sprite_even1
	.byte <bow_sprite_even2,<bow_sprite_even3

bow_sprites_h:
	.byte >bow_sprite_odd0,>bow_sprite_odd1
	.byte >bow_sprite_odd2,>bow_sprite_odd3
	.byte >bow_sprite_even0,>bow_sprite_even1
	.byte >bow_sprite_even2,>bow_sprite_even3


string_sprite_offsets:
	.byte 2,15,2,15

string_sprites_l:
	.byte <string_sprite_odd0,<string_sprite_odd1
	.byte <string_sprite_even0,<string_sprite_even1

string_sprites_h:
	.byte >string_sprite_odd0,>string_sprite_odd1
	.byte >string_sprite_even0,>string_sprite_even1

