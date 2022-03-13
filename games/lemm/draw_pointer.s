	;====================================
	; draw pointer
	;====================================


draw_pointer:

	lda	#0
	sta	OVER_LEMMING

;	jsr	save_bg_14x14		; save old bg

	; for now assume the only 14x14 sprites are the pointers

	lda	CURSOR_X
	sta	XPOS
        lda     CURSOR_Y
	sta	YPOS

	; see if over lemming

	; TODO

	; see if CURSOR_X==LEMMING_X
	lda	CURSOR_X
	cmp	lemming_x
	beq	check_pointer_y
	clc
	adc	#1
	cmp	lemming_x
	bne	just_crosshair

check_pointer_y:
	; see if CURSOR_Y+7 > lemming_y && CURSOR_Y+7 < lemming_y+9

	lda	CURSOR_Y
	clc
	adc	#7
	cmp	lemming_y
	bcc	just_crosshair

	lda	CURSOR_Y		; if cursor_y+7 > lemming_y+9
	sec
	sbc	#2
	cmp	lemming_y
	bcs	just_crosshair


just_select:
	lda     #<select_sprite_l
	sta	INL
	lda     #>select_sprite_l
	jmp	common_pointer

just_crosshair:
	lda     #<crosshair_sprite_l
	sta	INL
	lda     #>crosshair_sprite_l

common_pointer:
	sta	INH
	jsr	hgr_draw_sprite_14x14

	rts


	;=====================
	; erase pointer
	;=====================
erase_pointer:
	lda	CURSOR_Y
	sta	SAVED_Y1
	clc
	adc	#16
	sta	SAVED_Y2

	lda     CURSOR_X
	tax
	inx
	jmp	hgr_partial_restore
