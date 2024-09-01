
	;============================
	; draw peasant
	;============================
draw_peasant:

	; skip if room over, as otherwise we'll draw at the
	; wrong edge of screen

	lda	LEVEL_OVER
	bne	done_draw_peasant

	lda	PEASANT_X		; needed?  should we hard-code?
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
	;=====================
	; 12 ... 17 depending on PEASANT_STEPS

peasant_up:
	lda	#12
	bne	done_pick_draw		; bra

	;=====================
	; down down down
	;=====================
	; 18 ... 23 depending on PEASANT_STEPS
peasant_down:
	lda	#18
	bne	done_pick_draw		; bra

	;=====================
	; left left left
	;=====================
	; 6 ... 11 depending on PEASANT_STEPS
peasant_left:
	lda	#6
	bne	done_pick_draw		; bra

	;=====================
	; right right right
	;=====================
	; 0 ... 5 depending on PEASANT_STEPS

peasant_right:
	lda	#0

	; fallthrough

done_pick_draw:
	clc
	adc	PEASANT_STEPS

	tax

	jsr	hgr_draw_sprite_bg_mask

done_draw_peasant:

	rts

