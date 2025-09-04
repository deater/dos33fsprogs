; "Also I lost baby Bertner somewhere..."

	;===================
	; throw baby animation
	;===================

	; walkto 77,101 and face right
	; throw0: 2
	; throw1: 2
	; throw2: 2
	; throw3: 6		elbow up
	; throw4: 8		reaching into pocket
	; throw5: 2		first baby
	; throw6: 2
	; throw7: 8 (sound effect) baby vertical
	; throw8: 2 (more sound)		baby horizontal
	; throw9: 2
	; throw10:2... baby on loose  baby1 (left/diagonal)
	; throw10: 2		      baby0 (left/horizontal)
	; throw10: 2..                baby2 (vertical/up)
	; throw10: 2..                baby3 (right/diagonal)
	; throw10: 2..                baby2 (vertical/up)
	; throw9:  2 (w/o baby)
	; throw0:  15
	; message: "Something tells you...."


throw_baby:
	lda	#0
	sta	BABY_COUNT

	; custom draw peasant

	lda	SUPPRESS_DRAWING
	ora	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

baby_loop:

;	ldy	BABY_COUNT
;	cpy	#8
;	bne	dont_suppress_yet
;dont_suppress_yet:

	jsr	update_screen

	; draw peasant

	ldy	BABY_COUNT

	ldx	throw_which,Y

	lda	throw_x,X
	sta	SPRITE_X

	lda	#101
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_mask

	jsr	hgr_page_flip

	jsr	wait_until_keypress


	; draw baby if needed

	;=========================
	; move to next frame

	inc	BABY_COUNT

	lda	BABY_COUNT
	cmp	#30
	bne	baby_loop

done_throw:

	lda	#0
	sta	SUPPRESS_DRAWING

	rts


	;=========================
	; floating with bottle sequence

	; throw0:  4	float0
	; throw0:  8    float1
	; throw0:  6	float2
	;	go 14 lefts, 28
	;	two each?
	; throw0:  3	float0, but slightly to left
	; throw0:  2    float0, slightly more left
	; throw0:  3	float1, slightly more left
	; throw0:  3	float1, slightly more left
	; throw0:  2	float2, slightly more left
	; throw0:  2	float2,...
	; throw0:  2	float0....
	; throw0:  2	float0....
	; throw0:  2	float1....
	; throw0:  2	float1....
	; throw0:  2	float2....
	; throw0:  2	float2....
	; throw0:  2	float0....
	; throw8:  2
	; throw7:  2
	; throw6
	; throw0:  5
	; message: "you won't be...." (points)

baby_swim:
	rts


	; throw0: 2
	; throw1: 2
	; throw2: 2
	; throw3: 6		elbow up
	; throw4: 8		reaching into pocket
	; throw5: 2		first baby
	; throw6: 2
	; throw7: 8 (sound effect) baby vertical
	; throw8: 2 (more sound)		baby horizontal
	; throw9: 2
	; throw10:2... baby on loose  baby1 (left/diagonal)
	; throw10: 2		      baby0 (left/horizontal)
	; throw10: 2..                baby2 (vertical/up)
	; throw10: 2..                baby3 (right/diagonal)
	; throw10: 2..                baby2 (vertical/up)
	; throw9:  2 (w/o baby)
	; throw0:  15

throw_which:
	.byte 0,1,2,3,   3,3,4,4
	.byte 4,4,5,6,   7,7,7,7
	.byte 8,9,10,10, 10,10,10,9
	.byte 0,0,0,0,   0,0
	.byte 0,0

throw_x:
	.byte 11,11,11,11, 11,11,10,10
	.byte 11,11,11

sprites_xsize:
	.byte 2,2,2,2, 2,2,3,3
	.byte 3,3,3

sprites_ysize:
	.byte 30,30,30,30, 30,30,30,30
	.byte 30,30,30

sprites_data_l:
	.byte <throw_sprite0,<throw_sprite1,<throw_sprite2,<throw_sprite3
	.byte <throw_sprite4,<throw_sprite5,<throw_sprite6,<throw_sprite7
	.byte <throw_sprite8,<throw_sprite9,<throw_sprite10

sprites_data_h:
	.byte >throw_sprite0,>throw_sprite1,>throw_sprite2,>throw_sprite3
	.byte >throw_sprite4,>throw_sprite5,>throw_sprite6,>throw_sprite7
	.byte >throw_sprite8,>throw_sprite9,>throw_sprite10

sprites_mask_l:
	.byte <throw_mask0,<throw_mask1,<throw_mask2,<throw_mask3
	.byte <throw_mask4,<throw_mask5,<throw_mask6,<throw_mask7
	.byte <throw_mask8,<throw_mask9,<throw_mask10

sprites_mask_h:
	.byte >throw_mask0,>throw_mask1,>throw_mask2,>throw_mask3
	.byte >throw_mask4,>throw_mask5,>throw_mask6,>throw_mask7
	.byte >throw_mask8,>throw_mask9,>throw_mask10
