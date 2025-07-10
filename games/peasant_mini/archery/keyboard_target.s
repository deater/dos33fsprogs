
	;=========================
	; check keyboard
	;	for target
	;==========================

	; note, this is different from the rest of the game

keyboard_bow:

	lda	KEYPRESS
	bmi	key_was_pressed
	rts

key_was_pressed:
	inc	SEEDL		; ????

	and	#$7f			; strip off high
	cmp	#$96
	bcc	no_upper_convert	; blt

	and	#$5f		; strip off high bit and make uppercase

no_upper_convert:

				; what if punctuation like / which is $2F
				; 0101 1111 & 0010 1111 -> 0xF

	;==========================
	; Left
	;==========================
check_left:
	cmp	#$8
	beq	left_pressed
	cmp	#'A'
	bne	check_right
left_pressed:

	dec	BOW_X
	jmp	done_keyboard_reset		; bra

check_right:
	cmp	#$15
	beq	right_pressed
	cmp	#'D'
	bne	check_up
right_pressed:

	inc	BOW_X

	jmp	done_keyboard_reset		; bra

check_up:
check_down:
check_enter:
	cmp	#13
	beq	enter_pressed
	cmp	#' '
	bne	done_check_keyboard
enter_pressed:


done_keyboard_reset:

	bit	KEYRESET

done_check_keyboard:

	rts

