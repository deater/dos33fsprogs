
	;==========================
	; check keyboard
	;	for climbig part
	;==========================

	; note, this is different from the rest of the game

	; pushing l/r/u/d only does one 5-frame animation of movement
	;
	; pressing another key while movement underway does not
	;	cancel/override
	;
	; holding down key just restarts from scratch

check_keyboard:

	lda	PEASANT_FALLING
	beq	keyboard_not_falling

	; if on ground then exit if keypressed

	cmp	#2		; on ground
	beq	keyboard_on_ground

	; still falling, clear strobe and exit

on_ground_exit:
	bit	KEYRESET
	rts

keyboard_on_ground:
	lda	KEYPRESS
	bpl	on_ground_exit	; if no press, exit

	lda	#$80		; done
	sta	LEVEL_OVER

	rts


keyboard_not_falling:

	lda	KEYPRESS
	bmi	key_was_pressed
	rts

key_was_pressed:
	inc	SEEDL		; ????

	and	#$5f		; strip off high bit and make uppercase

	;===========================
	; check moving
	;===========================
	; only start moving if currently not
check_moving:
	ldx	CLIMB_COUNT
	beq	check_left

done_check_moving:
	jmp	done_check_keyboard


	;==========================
	; Left
	;==========================
check_left:
	cmp	#$8
	beq	left_pressed
	cmp	#'A'
	bne	check_right
left_pressed:

	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR
	lda	#$FF
	sta	PEASANT_XADD
	bne	done_keyboard_reset		; bra

check_right:
	cmp	#$15
	beq	right_pressed
	cmp	#'D'
	bne	check_up
right_pressed:

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR
	lda	#$1
	sta	PEASANT_XADD

	bne	done_keyboard_reset		; bra

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B
	bne	check_down

up_pressed:

	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR
	lda	#$FE				; -2
	sta	PEASANT_YADD

	bne	done_keyboard_reset		; bra

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_enter

down_pressed:

	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR
	lda	#$2				; 2
	sta	PEASANT_YADD

	bne	done_keyboard_reset		; bra

check_enter:
	cmp	#13
	beq	enter_pressed
	cmp	#' '
	bne	done_check_keyboard
enter_pressed:


done_keyboard_reset:
	lda	#5			; decremented once before use

	sta	CLIMB_COUNT		; start climbing

	bit	KEYRESET

done_check_keyboard:

;	bit	KEYRESET		; should we?

	rts

