	;======================
	; deploy baby animation
	;======================

	; frame		baby	wall	broom
	;	12	start	.	.
	;	14	left2	.	.
	;	16	left2	.	.
	;	...40	gets to opening
	;	47		small
	;	50		bigger
	;	52		full
	;	68	inside
	;	87			vertical
	;	90			more vetical
	;	92			left
	;	95			vetical
	;	97			left
	;	100			vertical
	;	102			left
	;	105			vertical
	;	107			left
	;	110			vertical
	;	112			left
	;	115			vertical
	;	117	baby gone	left
	;	119			fall hard left
	;	125			broom down	door half open
	;	127	baby mid door			door full open
	;	130	baby start down
	;	147	baby left/down	wall back mid
	;	150	baby left only	wall small
	;	152			wall back original
	;	200	baby even with fencepost
	;	222	baby head edge of screen
	;	234	baby gone
	;	240	"Way to go..." message

deploy_baby_animation:

	lda	#0
	sta	BABY_COUNT

;	lda	#SUPPRESS_JHONKA
;	sta	SUPPRESS_DRAWING

deploy_baby_loop:

	jsr	update_screen

	; draw baby

	ldy	BABY_COUNT

;	lda	baby_x,Y
;	sta	SPRITE_X
;	lda	baby_y,Y
;	sta	SPRITE_Y

;	ldx	baby_which,Y

;	jsr	hgr_draw_sprite_mask

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	;=========================
	; move to next frame

	inc	BABY_COUNT

	lda	BABY_COUNT
	cmp	#120
	bne	deploy_baby_loop

done_deploy_baby:

	rts

.if 0

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
.endif
