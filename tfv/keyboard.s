
	;==============================
	; Get Keypress
	;==============================
	; returns 0 if nothing pressed
get_keypress:

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

        lda     #1			; only register on release
        sta     JS_BUTTON_STATE
        lda     #' '
        jmp     done_keypress

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
	jmp	done_keypress

js_check_right:
        cmp     #$40
        bcc     js_check_up
        lda     #'D'
	jmp	done_keypress

js_check_up:
        lda     value1
        cmp     #$20
        bcs     js_check_down
        lda     #'W'
	jmp	done_keypress

js_check_down:
        cmp     #$40
        bcc     done_joystick
        lda     #'S'
	jmp	done_keypress


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
	bne	check_joystick

	lda	SOUND_STATUS
	eor	#SOUND_DISABLED
	sta	SOUND_STATUS
	jmp	no_keypress

	; can't be ^J as that's the same as down
check_joystick:
	cmp	#'J'			; J
	bne	check_load

	lda	JOYSTICK_ENABLED
	eor	#1
	sta	JOYSTICK_ENABLED
	jmp	no_keypress

check_load:
;	cmp	#$C			; control-L
;	bne	check_save

;	jsr	load_game
;	jmp	done_keypress

check_save:
;	cmp	#$13			; control-S
;	bne	check_left

;	jsr	save_game
;	jmp	done_keypress

check_left:
	cmp	#'A'
	beq	left_pressed
	cmp	#8			; left key
	bne	check_right
left_pressed:
	lda	#'A'
	jmp	done_keypress

check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15			; right key
	bne	check_up
right_pressed:
	lda	#'D'
	jmp	done_keypress

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B			; up key
	bne	check_down
up_pressed:
	lda	#'W'
	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_return
down_pressed:
	lda	#'S'
	jmp	done_keypress

check_return:
	cmp	#' '
	beq	return_pressed
	cmp	#13
	bne	no_keypress
return_pressed:

	lda	#' '
	jmp	done_keypress

no_keypress:
	lda	#0
done_keypress:

	bit	KEYRESET
	rts
