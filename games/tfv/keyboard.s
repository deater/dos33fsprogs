
	;==============================
	; Get Keypress
	;==============================
	; returns 0 if nothing pressed

	; maps joystick to wasd and ' ' and return
	; maps arrow keys to wasd
	; handles sound enable and joystick enable


JS_BUTTON0	=	1
JS_BUTTON1	=	2

get_keypress:

	; first handle joystick
	lda	JOYSTICK_ENABLED
	beq	actually_handle_keypress

	; only check joystick every-other frame
	lda	FRAMEL
	and	#$1
	beq	actually_handle_keypress

check_button0:
        lda	PADDLE_BUTTON0
        bpl	button0_clear

        lda	JS_BUTTON_STATE
	and	#JS_BUTTON0
        bne	check_button1

        lda	#JS_BUTTON0		; only register on release
	ora	JS_BUTTON_STATE
	sta	JS_BUTTON_STATE
	lda	#' '
	jmp	done_keypress

button0_clear:
	lda     JS_BUTTON_STATE
	and	#<(~JS_BUTTON0)	; hack
	sta	JS_BUTTON_STATE
	jmp	js_check

check_button1:
        lda	PADDLE_BUTTON1
        bpl	button1_clear

        lda	JS_BUTTON_STATE
	and	#JS_BUTTON1
        bne	js_check

        lda	#JS_BUTTON1		; only register on release
	ora	JS_BUTTON_STATE
	sta	JS_BUTTON_STATE
	lda	#13
	jmp	done_keypress

button1_clear:
	lda     JS_BUTTON_STATE
	and	#<(~JS_BUTTON1)
	sta	JS_BUTTON_STATE
;	jmp	js_check



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
	cmp	#'A'
	bcc	check_sound		; make sure not to lose space/ctrl
	and	#$df			; convert lowercase to uppercase

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
	cmp	#8			; left key
	bne	check_right
left_pressed:
	lda	#'A'
	bne	done_keypress

check_right:
	cmp	#$15			; right key
	bne	check_up
right_pressed:
	lda	#'D'
	bne	done_keypress

check_up:
	cmp	#$0B			; up key
	bne	check_down
up_pressed:
	lda	#'W'
	bne	done_keypress

check_down:
	cmp	#$0A			; down key
	bne	check_return
down_pressed:
	lda	#'S'
	bne	done_keypress

check_return:
	jmp	done_keypress

no_keypress:
	lda	#0
done_keypress:

	bit	KEYRESET
	rts
