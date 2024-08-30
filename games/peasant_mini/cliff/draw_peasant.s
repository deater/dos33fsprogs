
	;============================
	; draw peasant
	;============================
draw_peasant:

	; skip if room over, as otherwise we'll draw at the
	; wrong edge of screen

	lda	LEVEL_OVER
	bne	done_draw_peasant

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

	lda	PEASANT_Y
	and	#4
	beq	peasant_up1

peasant_up2:
	ldx	#13
	jmp	done_pick_draw

peasant_up1:
	ldx	#12
	jmp	done_pick_draw

	;=====================
	; down down down
peasant_down:

	lda	PEASANT_Y
	and	#4
	beq	peasant_down1

peasant_down2:
	ldx	#19
	jmp	done_pick_draw

peasant_down1:
	ldx	#18
	jmp	done_pick_draw

	;=====================
	; left left left

peasant_left:
	lda	CURSOR_X
	and	#1
	bne	draw_left1

draw_left2:
	ldx	#7
	jmp	done_pick_draw

draw_left1:
	ldx	#6
	jmp	done_pick_draw


peasant_right:
	lda	CURSOR_X
	and	#1
	bne	draw_right1

draw_right2:
	ldx	#1

	jmp	done_pick_draw

draw_right1:
	ldx	#0

done_pick_draw:

	jsr	hgr_draw_sprite_bg_mask

done_draw_peasant:

	rts

