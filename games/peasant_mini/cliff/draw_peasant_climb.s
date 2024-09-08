
	;===================================
	; draw peasant -- climbing version
	;===================================
draw_peasant_climb:

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
	lda	peasant_climb_offsets,X
	clc
	ldx	CLIMB_COUNT
	adc	peasant_extra_offset,X
	tax

	ldy	#4	; reserved for peasant

	jsr	hgr_draw_sprite_bg_mask


	;=============================
	; draw flame if applicable

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
peasant_climb_offsets:
	.byte 8, 0, 4, 12

peasant_flame_offsets:
	.byte 22,16,19,25


; note: animation actually 5 frames
;	essentially counts down 3,2,1,0 then 0 again

peasant_extra_offset:
	.byte 0,0,1,2,3
