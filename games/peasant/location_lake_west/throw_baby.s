; "Also I lost baby Bertner somewhere..."

	;======================
	;======================
	; throw baby animation
	;======================
	;======================

	; walkto 77,101 and face right
	; 0            throw0: 2
	; 1            throw1: 2
	; 2            throw2: 2
	; 3,4,5        throw3: 6		elbow up
	; 6,7,8,9      throw4: 8		reaching into pocket
	; 10           throw5: 2		first baby
	; 11,12,13,14  throw6: 2
	; 15           throw7: 8 (sound effect) baby vertical
	; 16           throw8: 2 (more sound)		baby horizontal
	; 17           throw9: 2                   baby0 (horizontal)
	; 18           throw10:2... baby on loose  baby1 (left/diagonal)
	; 19           throw10: 2		   baby0 (left/horizontal)
	; 20           throw10: 2..                baby2 (vertical/up)
	; 21           throw10: 2..                baby3 (right/diagonal)
	; 22           throw10: 2..                baby2 (vertical/up)
	; 23           throw9:  2 (w/o baby)
	; 24..30       throw0:  15
	; message: "Something tells you...."


throw_baby:
	lda	#0
	sta	BABY_COUNT

	; custom draw peasant

	lda	SUPPRESS_DRAWING
	ora	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

baby_loop:

	jsr	update_screen

	; draw peasant

	ldy	BABY_COUNT

	ldx	throw_which,Y

	lda	throw_x,X
	sta	SPRITE_X

	lda	#101
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_mask

	; draw baby if needed
	; only from 17...22

	lda	BABY_COUNT
	cmp	#17
	bcc	no_baby_today		; blt
	cmp	#23
	bcs	no_baby_today		; bge

	sec
	sbc	#17
	tay

	ldx	baby_which,Y

	lda	baby_x,Y
	sta	SPRITE_X

	lda	baby_y,Y
	sta	SPRITE_Y


	jsr	hgr_draw_sprite_mask

no_baby_today:



	jsr	hgr_page_flip

;	jsr	wait_until_keypress

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


	;===============================
	;===============================
	; swimming with bottle sequence
	;===============================
	;===============================

	; start at 126,123

	; down to 98,123

	; frame
	; 0,1      126,123   float0	0,18+0  0
	; 2,3,4,5  126,123   float1	1,18+0  1
	; 6,7,8    126,123   float2	2,18+0  2
	; 9        124       float0	0,17+5  3
	; 10       122       float0     0,17+3  4
	; 11       120       float1     1,17+1  5
	; 12       118       float1     1,16+6  6
	; 13       116       float2     2,16+4  7
	; 14       114       float2     3,16+2  8
	; 15       112       float0     0,16+0  0
	; 16       110       float0	0,15+5	3
	; 17       108       float1	1,15+3  9
	; 18       106       float1	1,15+1  5
	; 19       104       float2	2,14+6  10
	; 20       102       float2	2,14+4	7
	; 21       100       float0	0,14+2  11
	; 22        98       float0	0,14+0  0
	; 23	throw8
	; 24	throw7
	; 25	throw6
	; 26,27,28	throw0
	; message: "you won't be...." (points)


baby_swim:
	lda	#0
	sta	BABY_COUNT

	; custom draw peasant

	lda	SUPPRESS_DRAWING
	ora	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

swim_loop:

	jsr	update_screen

	; draw peasant

	; if less than 23 than throw0
	; if    23=throw8
	;	24=throw7
	;	25=throw6
	;	else throw0

	ldx	#0		; regular peasant

	lda	BABY_COUNT
	cmp	#26
	bcs	regular_peasant

	sec
	lda	#31
	sbc	BABY_COUNT
	cmp	#9
	bcs	regular_peasant

	tax

regular_peasant:

	lda	throw_x,X
	sta	SPRITE_X

	lda	#101
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_mask

	;======================
	; draw baby if needed
	; only if < 23

	ldy	BABY_COUNT
	cpy	#23
	bcs	again_no_baby_today		; blt

	ldx	swim_which,Y

	lda	swim_sprite_l,X
	sta	INL
	lda	swim_sprite_h,X
	sta	INH

	lda	swim_x,Y
	sta	CURSOR_X

	lda	#123
	sta	CURSOR_Y

	jsr	hgr_draw_sprite		; inl/inh, cursorx,cursory

again_no_baby_today:



	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	;=========================
	; move to next frame

	inc	BABY_COUNT

	lda	BABY_COUNT
	cmp	#29
	bne	swim_loop

done_swim:

	lda	#0
	sta	SUPPRESS_DRAWING

	rts

throw_which:
	.byte 0,1,2,3,   3,3,4,4
	.byte 4,4,5,6,   7,7,7,7
	.byte 8,9,10,10, 10,10,10,9
	.byte 0,0,0,0,   0,0



	; 17           throw9: 2                   baby0 (horizontal)
	; 18           throw10:2... baby on loose  baby1 (left/diagonal)
	; 19           throw10: 2		   baby0 (left/horizontal)
	; 20           throw10: 2..                baby2 (vertical/up)
	; 21           throw10: 2..                baby3 (right/diagonal)
	; 22           throw10: 2..                baby2 (vertical/up)

BABY_OFFSET = 11 	; offset in sprite table

baby_which:
	.byte 0+BABY_OFFSET,1+BABY_OFFSET,0+BABY_OFFSET
	.byte 2+BABY_OFFSET,3+BABY_OFFSET,2+BABY_OFFSET
baby_x:
	.byte 13,14,16, 18,20,22
baby_y:
	.byte 108,97,96, 96,100,110

throw_x:
	.byte 11,11,11,11, 11,11,10,10
	.byte 11,11,11

sprites_xsize:
	.byte 2,2,2,2, 2,2,3,3
	.byte 3,3,3

	.byte 2,2,2,2

sprites_ysize:
	.byte 30,30,30,30, 30,30,30,30
	.byte 30,30,30

	.byte 9,12,12,12

sprites_data_l:
	.byte <throw_sprite0,<throw_sprite1,<throw_sprite2,<throw_sprite3
	.byte <throw_sprite4,<throw_sprite5,<throw_sprite6,<throw_sprite7
	.byte <throw_sprite8,<throw_sprite9,<throw_sprite10

	.byte <baby_sprite0,<baby_sprite1,<baby_sprite2,<baby_sprite3

sprites_data_h:
	.byte >throw_sprite0,>throw_sprite1,>throw_sprite2,>throw_sprite3
	.byte >throw_sprite4,>throw_sprite5,>throw_sprite6,>throw_sprite7
	.byte >throw_sprite8,>throw_sprite9,>throw_sprite10

	.byte >baby_sprite0,>baby_sprite1,>baby_sprite2,>baby_sprite3

sprites_mask_l:
	.byte <throw_mask0,<throw_mask1,<throw_mask2,<throw_mask3
	.byte <throw_mask4,<throw_mask5,<throw_mask6,<throw_mask7
	.byte <throw_mask8,<throw_mask9,<throw_mask10

	.byte <baby_mask0,<baby_mask1,<baby_mask2,<baby_mask3

sprites_mask_h:
	.byte >throw_mask0,>throw_mask1,>throw_mask2,>throw_mask3
	.byte >throw_mask4,>throw_mask5,>throw_mask6,>throw_mask7
	.byte >throw_mask8,>throw_mask9,>throw_mask10

	.byte >baby_mask0,>baby_mask1,>baby_mask2,>baby_mask3


	; 0,1      126,123   float0	0,18+0  0
	; 2,3,4,5  126,123   float1	1,18+0  1
	; 6,7,8    126,123   float2	2,18+0  2

swim_which:
	.byte	0,0,1,1,  1,1,2,2
	.byte	2,3,4,5,  6,7,8,0
	.byte	3,9,5,10, 7,11,0

swim_x:
	.byte	18,18,18,18, 18,18,18,18
	.byte	18,17,17,17, 16,17,16,16
	.byte	15,15,15,15, 15,14,14

swim_sprite_l:
	.byte	<swim_sprite0,<swim_sprite1,<swim_sprite2,<swim_sprite3
	.byte	<swim_sprite4,<swim_sprite5,<swim_sprite6,<swim_sprite7
	.byte	<swim_sprite8,<swim_sprite9,<swim_sprite10,<swim_sprite11

swim_sprite_h:
	.byte	>swim_sprite0,>swim_sprite1,>swim_sprite2,>swim_sprite3
	.byte	>swim_sprite4,>swim_sprite5,>swim_sprite6,>swim_sprite7
	.byte	>swim_sprite8,>swim_sprite9,>swim_sprite10,>swim_sprite11





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
