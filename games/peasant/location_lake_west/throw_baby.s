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
