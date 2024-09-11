
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

	; get offset for graphics

	ldx	PEASANT_DIR
	lda	peasant_walk_offsets,X
	clc
	adc	PEASANT_STEPS
	tax

	ldy	#4	; reserved for peasant

	jsr	hgr_draw_sprite_bg_mask

	;=============================
	; draw flame if applicable

	lda	GAME_STATE_2
	and	#ON_FIRE
	beq	done_draw_peasant

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sec
	sbc	#4
	sta	CURSOR_Y

	; get offset for graphics

	ldx	PEASANT_DIR
	lda	peasant_flame_offsets,X
	clc
	adc	FLAME_COUNT
	tax

	ldy	#5	; reserved for flame

	jsr	hgr_draw_sprite_bg_mask

done_draw_peasant:

	rts

; UP RIGHT LEFT DOWN = 0, 1, 2, 3
peasant_walk_offsets:
	.byte 12, 0, 6, 18

peasant_flame_offsets:
	.byte 30,24,27,33


	;===========================
	; erase peasant
	;===========================

	; restore bg behind peasant
erase_peasant:

	lda	GAME_STATE_2
	and	#ON_FIRE
	beq	skip_erase_fire

	; erase flame if applicable
	ldy	#5
	jsr	hgr_partial_restore_by_num

skip_erase_fire:

	; erase peasant

	ldy	#4

	jmp	hgr_partial_restore_by_num      ; tail call

	rts
