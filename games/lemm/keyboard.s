
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
        jmp     handle_input

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
        bne     handle_input

js_check_right:
        cmp     #$40
        bcc     js_check_up
        lda     #'D'
        bne     handle_input

js_check_up:
        lda     value1
        cmp     #$20
        bcs     js_check_down
        lda     #'W'

        bne     handle_input

js_check_down:
        cmp     #$40
        bcc     done_joystick
        lda     #'S'
        bne     handle_input


done_joystick:



actually_handle_keypress:
	lda	KEYPRESS
	bmi	keypress

	jmp	no_keypress

keypress:
	and	#$7f			; clear high bit
	cmp	#' '
	beq	handle_input		; make sure not to lose space
	and	#$df			; convert uppercase to lower case


handle_input:

;	pha
;	jsr	restore_bg_14x14	; restore old background
;	pla

check_sound:
	cmp	#$14			; control-T
	bne	check_joystick

	lda	SOUND_STATUS
	eor	#SOUND_DISABLED
	sta	SOUND_STATUS
	jmp	done_keypress

	; can't be ^J as that's the same as down
check_joystick:
;	cmp	#$10			; control-P
	cmp	#'J'
	bne	check_left

	lda	JOYSTICK_ENABLED
	eor	#1
	sta	JOYSTICK_ENABLED
	jmp	done_keypress

check_left:
	cmp	#'A'
	beq	left_pressed
	cmp	#8			; left key
	bne	check_right
left_pressed:
	lda	CURSOR_X		; if 41<x<$FE don't decrement
	cmp	#41
	bcc	do_dec_cursor_x
	cmp	#$FE
	bcc	done_left_pressed
do_dec_cursor_x:
	dec	CURSOR_X
done_left_pressed:
	jmp	done_keypress

check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15			; right key
	bne	check_up
right_pressed:
	lda	CURSOR_X		; if 40<x<$FE don't increment
	cmp	#40
	bcc	do_inc_cursor_x
	cmp	#$FE
	bcc	done_right_pressed
do_inc_cursor_x:
	inc	CURSOR_X
done_right_pressed:
	jmp	done_keypress

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B			; up key
	bne	check_down
up_pressed:
	lda	CURSOR_Y		; if 191<y<$F0 don't decrement
	cmp	#191
	bcc	do_dec_cursor_y
	cmp	#$F0
	bcc	done_up_pressed
do_dec_cursor_y:
	dec	CURSOR_Y
	dec	CURSOR_Y
	dec	CURSOR_Y
	dec	CURSOR_Y

done_up_pressed:
	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_escape
down_pressed:
	lda	CURSOR_Y		; if 191<y<$EE don't decrement
	cmp	#191
	bcc	do_inc_cursor_y
	cmp	#$EE
	bcc	done_down_pressed
do_inc_cursor_y:
	inc	CURSOR_Y
	inc	CURSOR_Y
	inc	CURSOR_Y
	inc	CURSOR_Y
done_down_pressed:
	jmp	done_keypress

check_escape:
	cmp	#27
	bne	check_return
escape_pressed:
	inc	LEVEL_OVER

	jmp	done_keypress

check_return:
	cmp	#' '
	beq	return_pressed
	cmp	#13
	bne	done_keypress

return_pressed:

	jsr	update_menu

	; first check if over lemming

	lda	OVER_LEMMING
	bpl	not_over_lemming

	; for now assume we've got diggingselected
	lda	#LEMMING_DIGGING
	sta	lemming_status

	jmp	done_keypress

not_over_lemming:

	; TODO

	; handle clicking on bottom row



done_keypress:


no_keypress:
	bit	KEYRESET
	rts



