
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
	asl				; 0 or 4 based on odd or even
	asl
	sta	draw_bow_smc+1

	; our bow is so wide it takes 4 sprites to draw it!

draw_bow_loop:
	clc
	lda	BOW_INDEX
draw_bow_smc:
	adc	#0
	tax

	; set xpos,ypos

	clc
	lda	BOW_X
	adc	bow_sprite_x_offsets,X
	sta	CURSOR_X

	clc
	lda	#159
	adc	bow_sprite_y_offsets,X
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
	adc	string_sprite_x_offsets,X
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



	;=======================
	; draw drawn string
	;=======================
draw_drawn_string:

	lda	#0
	sta	BOW_INDEX

	; check if odd or even

	lda	BOW_X
	and	#$1
	eor	#$1			; our sprite X is off by one
	asl
	sta	drawn_string_smc+1

drawn_string_loop:
	clc
	lda	BOW_INDEX
drawn_string_smc:
	adc	#0
	tax

	; set xpos,ypos

	clc
	lda	BOW_X
	adc	string_drawn_x_offsets,X
	sta	CURSOR_X
	lda	#183
	sta	CURSOR_Y

	; set up sprites

	lda	string_drawn_l,X
	sta	INL
	lda	string_drawn_h,X
	sta	INH

	jsr	hgr_draw_sprite

	inc	BOW_INDEX
	lda	BOW_INDEX
	cmp	#2
	bne	drawn_string_loop

	rts



bow_sprite_x_offsets:
	.byte 1,8,15,22,1,8,15,22

bow_sprite_y_offsets:
	.byte 9,0,0,9,9,0,0,9

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


string_sprite_x_offsets:
	.byte 2,15,2,15

string_drawn_x_offsets:
	.byte 3,21,3,21

string_sprites_l:
	.byte <string_sprite_odd0,<string_sprite_odd1
	.byte <string_sprite_even0,<string_sprite_even1

string_sprites_h:
	.byte >string_sprite_odd0,>string_sprite_odd1
	.byte >string_sprite_even0,>string_sprite_even1

string_drawn_l:
	.byte <string_drawn_odd0,<string_drawn_odd1
	.byte <string_drawn_even0,<string_drawn_even1

string_drawn_h:
	.byte >string_drawn_odd0,>string_drawn_odd1
	.byte >string_drawn_even0,>string_drawn_even1


	;=======================
	; draw arrow
	;=======================
	; note: currently we aren't centered because of the weird
	;	Apple II 3.5-pixel tiles
	; 	Is this worth fixing?

draw_arrow:

	lda	BOW_X
	clc
	adc	#15
	sta	CURSOR_X

	lda	#149
	sta	CURSOR_Y

	lda	BOW_X
	lsr
	bcs	draw_arrow_even
draw_arrow_odd:
	lda	#<arrow_odd_sprite
	sta	INL
	lda	#>arrow_odd_sprite
	jmp	draw_arrow_common
draw_arrow_even:
	lda	#<arrow_even_sprite
	sta	INL
	lda	#>arrow_even_sprite
draw_arrow_common:

	sta	INH

	jmp	hgr_draw_sprite		; tailcall



	;=======================
	; draw arrow nostring
	;=======================
	; used when the bow is drawn
	; wasteful (almost the same as regular sprite, in theory we could
	;	live patch it? hmmmm)
	; but simple

draw_arrow_nostring:

	lda	BOW_X
	clc
	adc	#15
	sta	CURSOR_X

	lda	#149
	sta	CURSOR_Y

	lda	BOW_X
	lsr
	bcs	draw_arrow_ns_even
draw_arrow_ns_odd:
	lda	#<arrow_nostring_odd_sprite
	sta	INL
	lda	#>arrow_nostring_odd_sprite
	jmp	draw_arrow_ns_common
draw_arrow_ns_even:
	lda	#<arrow_nostring_even_sprite
	sta	INL
	lda	#>arrow_nostring_even_sprite
draw_arrow_ns_common:

	sta	INH

	jmp	hgr_draw_sprite		; tail call

