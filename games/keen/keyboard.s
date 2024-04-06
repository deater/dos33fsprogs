JUMP_HEIGHT	=	6

SIDE_JUMP_DISTANCE	= 14

	;==============================
	; Handle Keypress
	;==============================
handle_keypress:

	; first handle joystick
	lda	JOYSTICK_ENABLED
	beq	actually_handle_keypress

	; only check joystick every-other frame
	lda	FRAMEL
	and	#$1
	beq	actually_handle_keypress

check_button:
        lda     PADDLE_BUTTON0
        bpl     button_clear

        lda     JS_BUTTON_STATE
        bne     js_check

        lda     #1
        sta     JS_BUTTON_STATE
        lda     #' '
        jmp     check_sound

button_clear:
        lda     #0
        sta     JS_BUTTON_STATE

js_check:
        jsr     handle_joystick

js_check_left:
        lda     value0
        cmp     #$20
        bcs     js_check_right  ; if less than 32, left
        lda     #'A'
        bne     check_sound

js_check_right:
        cmp     #$40
        bcc     js_check_up
        lda     #'D'
        bne     check_sound

js_check_up:
        lda     value1
        cmp     #$20
        bcs     js_check_down
        lda     #'W'

        bne     check_sound

js_check_down:
        cmp     #$40
        bcc     done_joystick
        lda     #'S'
        bne     check_sound


done_joystick:



actually_handle_keypress:
	lda	KEYPRESS
	bmi	keypress

	jmp	no_keypress

keypress:
	and	#$7f			; clear high bit
	cmp	#' '
	beq	check_sound		; make sure not to lose space
	and	#$df			; convert uppercase to lower case

check_sound:
	cmp	#$14			; control-T
	bne	check_help

	lda	SOUND_STATUS
	eor	#SOUND_DISABLED
	sta	SOUND_STATUS
	jmp	done_keypress

check_help:
	cmp	#'H'			; H (^H is same as left)
	bne	check_joystick

	jsr	print_help
	jmp	done_keypress

	; can't be ^J as that's the same as down
check_joystick:
	cmp	#'J'			; J
	bne	check_left

	lda	JOYSTICK_ENABLED
	eor	#1
	sta	JOYSTICK_ENABLED
	jmp	done_keypress

check_left:
	cmp	#'A'
	beq	left_pressed
	cmp	#8			; left key
	bne	check_left_slight
left_pressed:

	;===============================
	; left pressed
	;	if facing left, walk left
	;	if facing right and walking, stop
	;	if facing right and not walking, face left

	lda	KEEN_DIRECTION
	cmp	#$ff			; check if facing left
	bne	left_facing_right

	lda	KEEN_WALKING
	cmp	#4
	bcs	done_left_pressed	; don't shorten it

	lda	#4
	sta	KEEN_WALKING

	jmp	done_left_pressed

left_facing_right:
	lda	KEEN_WALKING
	beq	left_not_walking

	lda	#0
	sta	KEEN_WALKING
	beq	done_left_pressed	; bra

left_not_walking:

	lda	#$ff
	sta	KEEN_DIRECTION

done_left_pressed:
	lda	#0
	sta	KEEN_SHOOTING

	jmp	done_keypress

check_left_slight:
	cmp	#'Z'
	bne	check_right

	lda	#LEFT
	sta	KEEN_DIRECTION

	lda	#1
	sta	KEEN_WALKING
	jmp	done_right_pressed	; don't shorten it


check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15			; right key
	bne	check_right_slight


	;===============================
	; right pressed
	;	if facing right, walk right
	;	if facing left and walking, stop
	;	if facing left and not walking, face right

right_pressed:
	lda	KEEN_DIRECTION
	cmp	#$1			; check if facing right
	bne	right_facing_left

	lda	KEEN_WALKING
	cmp	#4
	bcs	done_right_pressed	; don't shorten it

;	clc
;	lda	KEEN_WALKING
;	adc	#4
;	sta	KEEN_WALKING

	lda	#4
	sta	KEEN_WALKING
	jmp	done_right_pressed

right_facing_left:
	lda	KEEN_WALKING
	beq	right_not_walking

	lda	#0
	sta	KEEN_WALKING
	beq	done_right_pressed	; bra

right_not_walking:
	lda	#$1
	sta	KEEN_DIRECTION


done_right_pressed:
	lda	#0
	sta	KEEN_SHOOTING

	jmp	done_keypress

check_right_slight:
	cmp	#'C'
	bne	check_jump_right

	lda	#RIGHT
	sta	KEEN_DIRECTION

	lda	#1
	sta	KEEN_WALKING
	jmp	done_right_pressed	; don't shorten it

check_jump_right:
	cmp	#'E'
	bne	check_jump_left

jump_right:

	; jump
	lda	KEEN_JUMPING
	bne	done_right_pressed	; don't jump if already jumping

	lda	KEEN_FALLING
	bne	done_right_pressed	; don't jump if falling

	lda	#JUMP_HEIGHT
	sta	KEEN_JUMPING

	ldy	#SFX_KEENJUMPSND
	jsr	play_sfx

	lda	#1
	sta	KEEN_DIRECTION
	lda	#SIDE_JUMP_DISTANCE
	sta	KEEN_WALKING

	jmp	done_keypress


check_jump_left:
	cmp	#'Q'
	bne	check_up

jump_left:

	; jump
	lda	KEEN_JUMPING
	bne	done_right_pressed	; don't jump if already jumping

	lda	KEEN_FALLING
	bne	done_right_pressed	; don't jump if falling

	lda	#JUMP_HEIGHT
	sta	KEEN_JUMPING

	ldy	#SFX_KEENJUMPSND
	jsr	play_sfx

	lda	#$FF
	sta	KEEN_DIRECTION
	lda	#SIDE_JUMP_DISTANCE
	sta	KEEN_WALKING

	jmp	done_keypress


check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B			; up key
	bne	check_down
up_pressed:

;	jsr	up_action

done_up_pressed:
	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_space
down_pressed:

done_down_pressed:
	jmp	done_keypress

check_space:
	cmp	#' '
	bne	check_comma
space_pressed:

	; jump
	lda	KEEN_JUMPING
	bne	done_keypress	; don't jump if already jumping

	lda	KEEN_FALLING
	bne	done_keypress	; don't jump if falling

	lda	#JUMP_HEIGHT
	sta	KEEN_JUMPING


	ldy	#SFX_KEENJUMPSND
	jsr	play_sfx

	jmp	done_keypress

check_comma:
	cmp	#'M'
	bne	check_return

comma_pressed:
	; check if we have any shots left

	lda	#2		; draw us shooting even if out of ammo
	sta	KEEN_SHOOTING

	lda	RAYGUNS
	beq	done_comma

	; use up a shot
	dec	RAYGUNS

	; shoot
	lda	LASER_OUT
	bne	done_comma

	ldy	#SFX_GUNCLICK
	jsr	play_sfx

	lda	KEEN_DIRECTION
	sta	LASER_DIRECTION

	cmp	#1
	beq	laser_right
laser_left:
	lda	KEEN_TILEX
	sec
	sbc	#1
	jmp	laser_assign

laser_right:
	lda	KEEN_TILEX
	clc
	adc	#2

laser_assign:
	sta	LASER_TILEX

	lda	KEEN_TILEY
	clc
	adc	#1
	sta	LASER_TILEY

	inc	LASER_OUT

done_comma:
	jmp	no_keypress


check_return:
	cmp	#13
	bne	check_escape

return_pressed:

	jsr	draw_status_bar

done_return:
	jmp	no_keypress

check_escape:
	cmp	#27
	bne	done_keypress

	jsr	print_quit

	jmp	done_keypress



done_keypress:
no_keypress:
	bit	KEYRESET
	rts
