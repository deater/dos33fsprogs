
	;=========================
	; check keyboard
	;	for target
	;==========================

	; note, this is different from the rest of the game

keyboard_bow:

	lda	KEYPRESS
	bmi	key_was_pressed

	clc
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

	lda	BOW_X
	cmp	#$F7
	beq	bow_dont_dec

	dec	BOW_X
bow_dont_dec:
	jmp	done_keyboard_regular		; bra

check_right:
	cmp	#$15
	beq	right_pressed
	cmp	#'D'
	bne	check_up
right_pressed:

	lda	BOW_X
	cmp	#$10
	beq	bow_dont_inc

	inc	BOW_X

bow_dont_inc:

	jmp	done_keyboard_regular		; bra

check_up:
check_down:
check_enter:
	cmp	#13
	beq	enter_pressed
	cmp	#' '
	bne	done_keyboard_regular
enter_pressed:
	sec
	bcs	done_keyboard_enter		; bra

done_keyboard_enter:
	bit	KEYRESET
	sec					; enter pressed
	rts

done_keyboard_regular:
	bit	KEYRESET
	clc					; not enter pressed
	rts

