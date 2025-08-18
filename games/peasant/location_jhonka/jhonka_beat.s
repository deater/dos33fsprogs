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

	jsr	update_screen

	; draw peasant if needed

	; draw jhonka

	ldy	BEAT_COUNT

	lda	beat_x,Y
	sta	SPRITE_X
	lda	beat_y,Y
	sta	SPRITE_Y

	ldx	beat_which,Y

	jsr	hgr_draw_sprite_mask

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	;=========================
	; move to next frame

	inc	BEAT_COUNT

	lda	BEAT_COUNT
	cmp	#18
	bne	beat_loop

done_beat:

	lda	#0
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
	.byte 7,7,4,5, 7,7,4,8
	.byte 9,8,9,8, 9,8,9,8
	.byte 9,8

	; note: 6 never used?

        ; 4 = club on right, club down, knees bent
        ; 5 = club on right, club down, standing
        ; 6 = club on right, club out, standing
        ; 7 = club of right, club out, knees bent
        ; 8 = club on right, club raised
        ; 9 = club on right, club hitting

