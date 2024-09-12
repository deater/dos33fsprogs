
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

	lda	PEASANT_FALLING			; only for climbing minigame
	bne	draw_peasant_falling

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

	;================================


draw_peasant_falling:

	; PEASANT_FALLING already in A here
	; 1 = falling
	; 2 = crashing
	; 3 = crashed

	cmp	#2
	bcc	yep_really_falling	; blt

	lda	#(32-1)			; base splat sprite
	clc				; -1 as we are 1/2 here
	adc	PEASANT_FALLING
	bne	yep_falling_common	; bra


yep_really_falling:

	; get offset for graphics

	lda	FRAME		; always spinning, spinning
	and	#$3
	clc
	adc	#28		; peasant fall offset

yep_falling_common:
	tax

	ldy	#4	; reserved for peasant

	jsr	hgr_draw_sprite_bg_mask


	;=============================
	; draw flame if applicable

	lda	PEASANT_X
	sta	CURSOR_X

	lda	PEASANT_FALLING	; if falling, adjust from table
	cmp	#1
	beq	flame_adjust_falling

	; otherwise, always adjust as if it's 1
	ldx	#1
	bne	flame_adjust_mid	; bra

flame_adjust_falling:
	lda	FRAME
	and	#3
	tax
flame_adjust_mid:
	lda	peasant_flame_fall_yadjust,X
	clc
	adc	PEASANT_Y
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

	rts


; UP RIGHT LEFT DOWN = 0, 1, 2, 3
peasant_climb_offsets:
	.byte 8, 0, 4, 12

; note, when climbing, flame is on right for both up and down
;	left seems to be same as up

peasant_flame_offsets:
;	.byte 22,16,19,25
	.byte 25,16,19,25

; head at different heights so move flame with it
peasant_flame_fall_yadjust:
	.byte	11,16,16,0

; note: animation actually 5 frames
;	essentially counts down 3,2,1,0 then 0 again

peasant_extra_offset:
	.byte 0,0,1,2,3
