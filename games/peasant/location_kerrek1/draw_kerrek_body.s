	;===================================
	; check if kerrek dead and onscreen
	;===================================
check_kerrek_dead_onscreen:
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_is_dead

	; o/~ the kerrek's not dead o/~
kerrek_not_dead:
	clc
	rts

kerrek_is_dead:

	; check if this screen
	; if KERREK_STATE/KERREK_ROW1 and MAP_LOCATION is LOCATION_KERREK_1

	lda	KERREK_STATE
	and	#KERREK_ROW1
	beq	kerrek_body_row2
kerrek_body_row1:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_1
	beq	kerrek_is_dead_and_correct_screen
kerrek_wrong_row:
	clc
	rts

kerrek_body_row2:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_2
	bne	kerrek_wrong_row

kerrek_is_dead_and_correct_screen:
	sec
	rts


	;=======================
	;=======================
	; draw kerrek body
	;=======================
	;=======================
	; draw dead body on background
	; + only if dead
	; + only if on current screen
	; + which sprite depends on if we have belt and post-belt count

kerrek_draw_body:
	; check if dead/right screen

	jsr	check_kerrek_dead_onscreen	; carry set if dead/onscreen
	bcs	kerrek_really_draw_body

	rts

kerrek_really_draw_body:

	; draw to back buffer

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	; do we need to adjust?
	; we probably need to add at least 20 to the Y, what value exactly?

	lda	KERREK_X
	sta	SPRITE_X
	clc
	lda	KERREK_Y
	adc	#40
	sta	SPRITE_Y

	; have to set X to which sprite to show
	; if facing right, 0..3, if facing left 4..7
	; if not have belt, show #0
	; if KERREK_STATE bottom bits >=15 then show 3
	; if KERREK_STATE bottom bits >=10 then show 2
	; else show 1

	ldx	#0

	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	beq	adjust_for_left_right

	ldx	#1

	lda	KERREK_STATE
	and	#$f
	cmp	#15
	bcs	draw_skeleton
	cmp	#10
	bcs	draw_decay
	bcc	adjust_for_left_right

draw_decay:
	ldx	#2
	bne	adjust_for_left_right		; bra

draw_skeleton:
	ldx	#3
						; fallthrough

adjust_for_left_right:

	; if right, fine, otherwise increment

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=left, 1=right
	bne	kerrek_body_fine

	inx
	inx
	inx
	inx
kerrek_body_fine:

	jsr	hgr_draw_sprite_mask

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

no_draw_body:


	rts





	;=======================
	;=======================
	; draw kerrek flies
	;=======================
	;=======================
	; draw dead body on background
	; + only if dead
	; + only if on current screen
	; + only if post-belt count between 10 and 14

kerrek_draw_flies:
	; check if dead

	jsr	check_kerrek_dead_onscreen	; carry set if dead/onscreen
	bcs	kerrek_really_draw_flies

kerrek_draw_flies_early_out:
	rts

kerrek_really_draw_flies:

	; check if right state of decomposition
	lda	KERREK_STATE
	and	#$f
	cmp	#10
	bcc	kerrek_draw_flies_early_out
	cmp	#15
	bcs	kerrek_draw_flies_early_out

	; adjust; FIXME: adjust based on which direction facing?

	clc
	lda	KERREK_X
	adc	#1
	sta	SPRITE_X

	lda	KERREK_STATE	; left=0, right $20
	and	#KERREK_RIGHT
	beq	flies_x_ok

	inc	SPRITE_X	; adjust
	inc	SPRITE_X


flies_x_ok:

	clc
	lda	KERREK_Y
	adc	#33
	sta	SPRITE_Y

	; only 3 frames.

	; only every other frame

	lda	FRAME
	and	#1
	beq	done_fly_adjust

	inc	FLY_COUNT
	lda	FLY_COUNT
	cmp	#3
	bcc	fly_adjust
	lda	#0
	sta	FLY_COUNT
fly_adjust:
	clc
	adc	#8		; skip body sprites
	tax

	jsr	hgr_draw_sprite_mask

done_fly_adjust:
	rts


;sprites_mask_l:
;	.byte <kerrek_walk0l_mask,<kerrek_walk1l_mask
;	.byte <kerrek_walk2l_mask,<kerrek_walk3l_mask
;	.byte <kerrek_walk4l_mask,<kerrek_walk5l_mask
;	.byte <kerrek_walk6l_mask,<kerrek_walk7l_mask

;	.byte <kerrek_walk0r_mask,<kerrek_walk1r_mask
;	.byte <kerrek_walk2r_mask,<kerrek_walk3r_mask
;	.byte <kerrek_walk4r_mask,<kerrek_walk5r_mask
;	.byte <kerrek_walk6r_mask,<kerrek_walk7r_mask


	; right first?
;	.byte <kerrek_body0r_mask,<kerrek_body1r_mask
;	.byte <kerrek_body2r_mask,<kerrek_body3r_mask
	; left next
;	.byte <kerrek_body0l_mask,<kerrek_body1l_mask
;	.byte <kerrek_body2l_mask,<kerrek_body3l_mask
	; flies
;	.byte <kerrek_flies0_mask,<kerrek_flies1_mask,<kerrek_flies2_mask

;sprites_mask_h:
;	.byte >kerrek_walk0l_mask,>kerrek_walk1l_mask
;	.byte >kerrek_walk2l_mask,>kerrek_walk3l_mask
;	.byte >kerrek_walk4l_mask,>kerrek_walk5l_mask
;	.byte >kerrek_walk6l_mask,>kerrek_walk7l_mask

;	.byte >kerrek_walk0r_mask,>kerrek_walk1r_mask
;	.byte >kerrek_walk2r_mask,>kerrek_walk3r_mask
;	.byte >kerrek_walk4r_mask,>kerrek_walk5r_mask
;	.byte >kerrek_walk6r_mask,>kerrek_walk7r_mask


	; right first?
;	.byte >kerrek_body0r_mask,>kerrek_body1r_mask
;	.byte >kerrek_body2r_mask,>kerrek_body3r_mask
	; left next
;	.byte >kerrek_body0l_mask,>kerrek_body1l_mask
;	.byte >kerrek_body2l_mask,>kerrek_body3l_mask
	; flies
;	.byte >kerrek_flies0_mask,>kerrek_flies1_mask,>kerrek_flies2_mask

;sprites_data_l:
;	.byte <kerrek_walk0l_sprite,<kerrek_walk1l_sprite
;	.byte <kerrek_walk2l_sprite,<kerrek_walk3l_sprite
;	.byte <kerrek_walk4l_sprite,<kerrek_walk5l_sprite
;	.byte <kerrek_walk6l_sprite,<kerrek_walk7l_sprite

;	.byte <kerrek_walk0r_sprite,<kerrek_walk1r_sprite
;	.byte <kerrek_walk2r_sprite,<kerrek_walk3r_sprite
;	.byte <kerrek_walk4r_sprite,<kerrek_walk5r_sprite
;	.byte <kerrek_walk6r_sprite,<kerrek_walk7r_sprite

	; right first?
;	.byte <kerrek_body0r_sprite,<kerrek_body1r_sprite
;	.byte <kerrek_body2r_sprite,<kerrek_body3r_sprite
	; left next
;	.byte <kerrek_body0l_sprite,<kerrek_body1l_sprite
;	.byte <kerrek_body2l_sprite,<kerrek_body3l_sprite
	; flies
;	.byte <kerrek_flies0_sprite,<kerrek_flies1_sprite,<kerrek_flies2_sprite

;sprites_data_h:
;	.byte >kerrek_walk0l_sprite,>kerrek_walk1l_sprite
;	.byte >kerrek_walk2l_sprite,>kerrek_walk3l_sprite
;	.byte >kerrek_walk4l_sprite,>kerrek_walk5l_sprite
;	.byte >kerrek_walk6l_sprite,>kerrek_walk7l_sprite

;	.byte >kerrek_walk0r_sprite,>kerrek_walk1r_sprite
;	.byte >kerrek_walk2r_sprite,>kerrek_walk3r_sprite
;	.byte >kerrek_walk4r_sprite,>kerrek_walk5r_sprite
;	.byte >kerrek_walk6r_sprite,>kerrek_walk7r_sprite

	; right first?
;	.byte >kerrek_body0r_sprite,>kerrek_body1r_sprite
;	.byte >kerrek_body2r_sprite,>kerrek_body3r_sprite
	; left next
;	.byte >kerrek_body0l_sprite,>kerrek_body1l_sprite
;	.byte >kerrek_body2l_sprite,>kerrek_body3l_sprite
	; flies
;	.byte >kerrek_flies0_sprite,>kerrek_flies1_sprite,>kerrek_flies2_sprite

;sprites_xsize:
;	.byte 3,3,3,3, 3,3,3,3, 3,3,3,3, 3,3,3,3

;	.byte 7,7,7,7, 7,7,7,7, 3,3,3
;sprites_ysize:
;	.byte 48,48,48,48, 48,48,48,48, 48,48,48,48, 48,48,48,48

;	.byte 14,14,14,14, 14,14,14,14, 11,11,10



