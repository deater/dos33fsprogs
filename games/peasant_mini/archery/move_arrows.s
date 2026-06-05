; use BG palette when drawing transparent sprites

USE_BG_PALETTE = 1

	;=======================
	; draw arrow move
	;=======================
draw_arrow_move:

	ldy	FRAME

	; set X-coord

	clc
	lda	BOW_X
	adc	#15
	sta	SPRITE_X

	; set Y-coord

	; note bow starts at 149 - 83 = 66

	lda	shoot_sprite_y,Y
	clc
	adc	#64
	sta	SPRITE_Y

	; get sprite

	lda	shoot_sprite_which,Y
	bmi	skip_draw_arrow_move

	tax				; which sprite in X

	jsr	hgr_draw_sprite_mask

	clc
	rts

skip_draw_arrow_move:
	sec
	rts


sprites_xsize:
	.byte	2,2,2,2,2
	.byte	2,2,2,2,2

sprites_ysize:
	.byte 30,12, 8, 5, 6
	.byte  9, 9, 9, 8, 8

sprites_data_h:
	.byte >shoot0e_sprite,>shoot1e_sprite,>shoot2e_sprite
	.byte >hit1e_sprite,>hit2e_sprite
	.byte >miss1e_sprite,>miss2e_sprite,>miss3e_sprite
	.byte >miss4e_sprite,>miss5e_sprite

sprites_data_l:
	.byte <shoot0e_sprite,<shoot1e_sprite,<shoot2e_sprite
	.byte <hit1e_sprite,<hit2e_sprite
	.byte <miss1e_sprite,<miss2e_sprite,<miss3e_sprite
	.byte <miss4e_sprite,<miss5e_sprite

sprites_mask_h:
	.byte >shoot0e_mask,>shoot1e_mask,>shoot2e_mask
	.byte >hit1e_mask,>hit2e_mask
	.byte >miss1e_mask,>miss2e_mask,>miss3e_mask
	.byte >miss4e_mask,>miss5e_mask

sprites_mask_l:
	.byte <shoot0e_mask,<shoot1e_mask,<shoot2e_mask
	.byte <hit1e_mask,<hit2e_mask
	.byte <miss1e_mask,<miss2e_mask,<miss3e_mask
	.byte <miss4e_mask,<miss5e_mask


	; this is all really complex
	; the flash game plays a movie to view the arrow
	; it has 43 frames

	; frame 0..6 (12)  are standard in all cases

	; if at that point hit the target
	;	7..19 (25)

	; if miss target
	;	20..37 (43)


shoot_sprite_which:
;	.byte	-0, -0, -0, -0, -0	; first 5 frames just regular arrow

	; shoot sprites

	.byte	0, 0, 0, 0, 0		; next 5 frames are launched
	.byte	1, 1			; next 2 smaller

	; hit sprites
hit_sprite_which:
	.byte	2,3,4,3, 2,3,4,3,2, 2,2,2,2,2,$FF

	; miss sprites
miss_sprite_which:
	.byte	5,6,7,8, 9,8,9,7,7, 7,7,7,7,7,$FF


shoot_sprite_y:
	.byte	83, 72, 54, 44, 26
	.byte	19,  9

hit_sprite_y:
	.byte	2,1,0,3,  2,1,0,1,2, 2,2,2,2,2,$FF

miss_sprite_y:
	.byte	11,12,24,25, 25,25,25,24,24, 24,24,24,24,24,$FF





