
	;============================
	; draw peasant
	;============================
draw_peasant:
	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	; urgh hack
	; for up/down always face right

	lda	PEASANT_DIR
	cmp	#PEASANT_DIR_RIGHT
	beq	peasant_right
	cmp	#PEASANT_DIR_LEFT
	beq	peasant_left
	cmp	#PEASANT_DIR_DOWN
	beq	peasant_right

	;=====================
	; right right right

peasant_right:
	lda	CURSOR_X
	and	#1
	bne	draw_right1

draw_right2:
	lda	#<tiny_r2_sprite
	sta	INL
	lda	#>tiny_r2_sprite
	jmp	done_pick_draw

draw_right1:
	lda	#<tiny_r1_sprite
	sta	INL
	lda	#>tiny_r1_sprite
	jmp	done_pick_draw

	;=====================
	; left left left

peasant_left:
	lda	CURSOR_X
	and	#1
	bne	draw_left1

draw_left2:
	lda	#<tiny_l2_sprite
	sta	INL
	lda	#>tiny_l2_sprite
	jmp	done_pick_draw

draw_left1:
	lda	#<tiny_l1_sprite
	sta	INL
	lda	#>tiny_l1_sprite
	jmp	done_pick_draw




done_pick_draw:
	sta	INH

	jsr	hgr_draw_sprite

	rts



