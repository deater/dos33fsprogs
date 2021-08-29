
	;============================
	; draw peasant
	;============================
draw_peasant:
	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	lda	PEASANT_DIR
	cmp	#PEASANT_DIR_RIGHT
	beq	peasant_right
	cmp	#PEASANT_DIR_LEFT
	beq	peasant_left
	cmp	#PEASANT_DIR_DOWN
	beq	peasant_down

	; else we are up

	;=====================
	; up up up up
peasant_up:

	lda	FRAME
	and	#1
	beq	peasant_up1


peasant_up2:
	lda	#<peasant_up2_sprite
	sta	INL
	lda	#>peasant_up2_sprite
	jmp	done_pick_draw

peasant_up1:
	lda	#<peasant_up1_sprite
	sta	INL
	lda	#>peasant_up1_sprite
	jmp	done_pick_draw

	;=====================
	; down down down
peasant_down:

	lda	FRAME
	and	#1
	beq	peasant_down1


peasant_down2:
	lda	#<peasant_down2_sprite
	sta	INL
	lda	#>peasant_down2_sprite
	jmp	done_pick_draw

peasant_down1:
	lda	#<peasant_down1_sprite
	sta	INL
	lda	#>peasant_down1_sprite
	jmp	done_pick_draw

	;=====================
	; left left left

peasant_left:
	lda	CURSOR_X
	and	#1
	bne	draw_left1

draw_left2:
	lda	#<peasant_left2_sprite
	sta	INL
	lda	#>peasant_left2_sprite
	jmp	done_pick_draw

draw_left1:
	lda	#<peasant_left1_sprite
	sta	INL
	lda	#>peasant_left1_sprite
	jmp	done_pick_draw


peasant_right:
	lda	CURSOR_X
	and	#1
	bne	draw_right1

draw_right2:
	lda	#<peasant_right2_sprite
	sta	INL
	lda	#>peasant_right2_sprite
	jmp	done_pick_draw

draw_right1:
	lda	#<peasant_right1_sprite
	sta	INL
	lda	#>peasant_right1_sprite

done_pick_draw:
	sta	INH

	jsr	hgr_draw_sprite_7x28

	rts


.include "sprites/peasant_sprite.inc"