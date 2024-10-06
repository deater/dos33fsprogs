
	;==========================
	; check keyboard
	;	for main game
	;==========================

	; Movement
	;	Note in the game, pressing a key starts walking
	;	To stop you have to press the same direction again
	;	This is convenient as this is how actual Apple II works

	; Text
	;	We originally tries having WASD but it's a bit of a pain
	;		so instead on Apple II+ use :,/ for up/down
	;		and have text input like original game

	;	Can walk while typing text, but
	;		Once enter is pressed, stop walking

check_keyboard:

	lda	KEYPRESS
	bmi	key_was_pressed
	rts

key_was_pressed:
	bit	KEYRESET

	inc	SEEDL		; does this help?

	and	#$7f			; strip off high bit

	; don't convert to uppercase, we can handle lowercase

	;==========================
	; Left
	;==========================
check_left:
	cmp	#$8
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
	cmp	#';'
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
	cmp	#'/'
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

all_other_keys:

	jsr	hgr_input

	; could tail-call here

	jmp	done_check_keyboard

enter_pressed:

	jsr	stop_peasant

	jsr	done_hgr_input

	jsr	parse_input

	jsr	reset_prompt

done_check_keyboard:

	rts

stop_peasant:
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	rts

	;==================================
	; reset prompt on bottom of screen
	;==================================
reset_prompt:



	lda	#0		; reset buffer
	sta	input_buffer
	sta	INPUT_X		; reset INPUT_X

setup_prompt:

	jsr	clear_bottom

	ldx	#0
	ldy	#184
	lda	#'>'
	jsr	hgr_put_char

	rts
