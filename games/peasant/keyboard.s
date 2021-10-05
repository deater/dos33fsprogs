
	;==========================
	; check keyboard
	;	for main game
	;==========================

	; Movement
	;	Note in the game, pressing a key starts walking
	;	To stop you have to press the same direction again

	; Text
	;	We require ENTER/RETURN pressed before entering text
	;		this is mildly annoying, but lets us use
	;		WASD to walk.  The Apple II+ doesn't have
	;		up or down buttons

check_keyboard:

	lda	KEYPRESS
	bmi	key_was_pressed
	rts

key_was_pressed:

	and	#$5f		 ; strip off high bit and make uppercase

	;==========================
	; Left
	;==========================
check_left:
	cmp	#$8
	beq	left_pressed
	cmp	#'A'
	bne	check_right
left_pressed:				; if peasant_moving_left, stop
					; otherwise clear all movement, move left

	ldx	PEASANT_XADD

	jsr	stop_peasant

	cpx	#$FF		; if not left, start moving left
	beq	continue_left

	lda	#$FF		; move left
	sta	PEASANT_XADD

continue_left:
	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR

	jmp	done_check_keyboard

check_right:
	cmp	#$15
	beq	right_pressed
	cmp	#'D'
	bne	check_up
right_pressed:

	ldx	PEASANT_XADD

	jsr	stop_peasant

	cpx	#$1		; if already right, stop
	beq	continue_right

	lda	#$1
	sta	PEASANT_XADD

continue_right:
	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	jmp	done_check_keyboard

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B
	bne	check_down

up_pressed:

	ldx	PEASANT_YADD

	jsr	stop_peasant

	cpx	#$FC		; if already up, stop
	beq	continue_up

	lda	#$FC
	sta	PEASANT_YADD

continue_up:

	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR


	jmp	done_check_keyboard

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_enter

down_pressed:

	ldx	PEASANT_YADD

	jsr	stop_peasant

	cpx	#$04		; if already down, stop
	beq	continue_down

	lda	#$4
	sta	PEASANT_YADD

continue_down:
	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR

	jmp	done_check_keyboard

check_enter:
	cmp	#13
	beq	enter_pressed
	cmp	#' '
	bne	done_check_keyboard
enter_pressed:
	jsr	clear_bottom
	jsr	hgr_input

	jsr	parse_input

	jsr	clear_bottom

done_check_keyboard:

	bit	KEYRESET

	rts

stop_peasant:
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	rts

