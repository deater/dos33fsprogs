	;===================
	; draw jhonka beat
	;===================
	; draw jhonka as he beats us up

	; you say "yes"
	; prints the "I KILL YOU" message, while still jumping?
	; Jhonka/you initial position X=112,87
	;	flips left/right somehow
	; 0	arm out, X=140  Y=113
	; 1     arm out, X=140  Y=122
	; 2     club down, X=126, Y=116
	; 3	arm out, X=126  Y=107
	; 4	arm out,knees bent X=133, Y=99
	; 5	again, X=126 Y=96
	; 6 club down, knees bent, X=126  Y=95
	; 7  attack1,  X=119, Y=88
	; 8  attack2,  X=119, Y=87			peasant=1, 105,86
	; 9  attack1,  X=119, Y=88			peasant=1, 105,86
	;10  attack2,  X=119, Y=87			peasant=2, 105,88
	;11  attack1,  X=119, Y=88			peasant=2, 105,88
	;12  attack2,  X=119, Y=87			peasant=3, 105,90
	;13  attack1,  X=119, Y=88			peasant=3, 105,90
	;14  attack2,  X=119, Y=87			peasant=4, 105,95
	;15  attack1,  X=119, Y=88			peasant=4, 105,95
	;16  attack2,  X=119, Y=87			peasant=5,  98,103
	;17  attack1,  X=119, Y=88			peasant=5,  98,103
	; then leave showing as print message


jhonka_beat:
	lda	#0
	sta	BEAT_COUNT

	lda	#SUPPRESS_JHONKA
	sta	SUPPRESS_DRAWING

beat_loop:

	ldy	BEAT_COUNT
	cpy	#8
	bne	dont_suppress_yet

	lda	SUPPRESS_DRAWING
	ora	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

dont_suppress_yet:

	jsr	update_screen

	; draw peasant if needed

	ldy	BEAT_COUNT
	cpy	#8
	bcc	no_peasant_just_jhonka

	; Location at CURSOR_X CURSOR_Y

;	ldy	BEAT_COUNT
	ldx	smash_which,Y

	lda	smash_sprites_l,X
	sta	INL

	lda	smash_sprites_h,X
	sta	INH

;	lda	PEASANT_X
	lda	#15
	sta	CURSOR_X
	lda	smash_y,X
	sta	CURSOR_Y

	jsr	hgr_draw_sprite



no_peasant_just_jhonka:


	; draw jhonka

	ldy	BEAT_COUNT

	lda	beat_x,Y
	sta	SPRITE_X
	lda	beat_y,Y
	sta	SPRITE_Y

	ldx	beat_which,Y

	jsr	hgr_draw_sprite_mask

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	;=========================
	; move to next frame

	inc	BEAT_COUNT

	lda	BEAT_COUNT
	cmp	#18
	bne	beat_loop

done_beat:

	; draw both jhonka and peasant to bg

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40
	sta	DRAW_PAGE

	; draw final peasant

	ldx	#4

	lda	smash_sprites_l,X
	sta	INL

	lda	smash_sprites_h,X
	sta	INH

	lda	#15
	sta	CURSOR_X
	lda	smash_y,X
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw final jhonka

	ldy	#17
	lda	beat_x,Y
	sta	SPRITE_X
	lda	beat_y,Y
	sta	SPRITE_Y

	ldx	beat_which,Y

	jsr	hgr_draw_sprite_mask


	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

	; suppress both, to hold image at end


	lda	#(SUPPRESS_JHONKA|SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	rts

	; 0	arm out, X=140  Y=113
	; 1     arm out, X=140  Y=122
	; 2     club down, X=126, Y=116
	; 3	arm out, X=126  Y=107
	; 4	arm out,knees bent X=133, Y=99
	; 5	again, X=126 Y=96
	; 6 club down, knees bent, X=126  Y=95
	; 7  attack1,  X=119, Y=88
	; 8  attack2,  X=119, Y=87			peasant=1, 105,86
	; 9  attack1,  X=119, Y=88			peasant=1, 105,86
	;10  attack2,  X=119, Y=87			peasant=2, 105,88
	;11  attack1,  X=119, Y=88			peasant=2, 105,88
	;12  attack2,  X=119, Y=87			peasant=3, 105,90
	;13  attack1,  X=119, Y=88			peasant=3, 105,90
	;14  attack2,  X=119, Y=87			peasant=4, 105,95
	;15  attack1,  X=119, Y=88			peasant=4, 105,95
	;16  attack2,  X=119, Y=87			peasant=5,  98,103
	;17  attack1,  X=119, Y=88			peasant=5,  98,103

beat_x:
	.byte 20,20,18,18, 19,18,18,17
	.byte 17,17,17,17, 17,17,17,17
	.byte 17,17

beat_y:
	.byte 113,122,116,107, 99,96,95,88
	.byte  87, 88, 87, 88, 87,88,87,88
	.byte  87, 88


beat_which:
	.byte 7,7,4,6, 7,7,4,8
	.byte 9,8,9,8, 9,8,9,8
	.byte 9,8

	; note: 5 never used?

        ; 4 = club on right, club down, knees bent
        ; 5 = club on right, club down, standing
        ; 6 = club on right, club out, standing
        ; 7 = club on right, club out, knees bent
        ; 8 = club on right, club raised
        ; 9 = club on right, club hitting

smash_which:
	.byte 0,0,0,0, 0,0,0,0
	.byte 0,1,1,2, 2,3,3,4
	.byte 4,4

smash_y:
	.byte 82,84,86,91,99

smash_sprites_l:
	.byte <smash1_sprite,<smash2_sprite,<smash3_sprite,<smash4_sprite
	.byte <smash5_sprite

smash_sprites_h:
	.byte >smash1_sprite,>smash2_sprite,>smash3_sprite,>smash4_sprite
	.byte >smash5_sprite
