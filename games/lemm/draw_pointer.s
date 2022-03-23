	;====================================
	; draw pointer
	;====================================


draw_pointer:

	lda	#$FF
	sta	OVER_LEMMING		; first assume not over lemming

	; for now assume the only 14x14 sprites are the pointers

	lda	CURSOR_X
	sta	XPOS
        lda     CURSOR_Y
	sta	YPOS

	; see if over lemming

	ldy	#0
see_if_over_loop:

	lda	lemming_out,Y
	beq	no_lemming_try_again

	; see if CURSOR_X==LEMMING_X
	lda	CURSOR_X
	cmp	lemming_x,Y
	beq	check_pointer_y
	clc
	adc	#1
	cmp	lemming_x,Y
	bne	no_lemming_try_again

check_pointer_y:
	; see if CURSOR_Y+7 > lemming_y && CURSOR_Y+7 < lemming_y+9

	lda	CURSOR_Y
	clc
	adc	#7
	cmp	lemming_y,Y
	bcc	no_lemming_try_again

	lda	CURSOR_Y		; if cursor_y+7 > lemming_y+9
	sec
	sbc	#2
	cmp	lemming_y,Y
	bcs	no_lemming_try_again

yes_over_lemming:
	sty	OVER_LEMMING
	jmp	yes_yes_lemming

no_lemming_try_again:
	iny
	cpy	#MAX_LEMMINGS
	bne	see_if_over_loop


yes_yes_lemming:
	lda	OVER_LEMMING
	bmi	just_crosshair

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
