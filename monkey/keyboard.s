; G = Give   P=Pick up  U=use    M=walk
; O = Open   L=Look at  H=push
; C = Close  T=Talk to  N=pull

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
	bne	check_joystick

	lda	SOUND_STATUS
	eor	#SOUND_DISABLED
	sta	SOUND_STATUS
	jmp	done_keypress

	; can't be ^J as that's the same as down
check_joystick:
	cmp	#'J'			; J
	bne	check_give

	lda	JOYSTICK_ENABLED
	eor	#1
	sta	JOYSTICK_ENABLED
	jmp	done_keypress

check_give:
	cmp	#'G'
	bne	check_open
	lda	#VERB_GIVE
	sta	CURRENT_VERB
	jmp	done_keypress

check_open:
	cmp	#'O'
	bne	check_close
	lda	#VERB_OPEN
	sta	CURRENT_VERB
	jmp	done_keypress

check_close:
	cmp	#'C'
	bne	check_pick_up
	lda	#VERB_CLOSE
	sta	CURRENT_VERB
	jmp	done_keypress

check_pick_up:
	cmp	#'P'
	bne	check_look_at
	lda	#VERB_PICK_UP
	sta	CURRENT_VERB
	jmp	done_keypress

check_look_at:
	cmp	#'L'
	bne	check_talk_to
	lda	#VERB_LOOK_AT
	sta	CURRENT_VERB
	jmp	done_keypress

check_talk_to:
	cmp	#'T'
	bne	check_use
	lda	#VERB_TALK_TO
	sta	CURRENT_VERB
	jmp	done_keypress

check_use:
	cmp	#'U'
	bne	check_push
	lda	#VERB_USE
	sta	CURRENT_VERB
	jmp	done_keypress

check_push:
	cmp	#'H'
	bne	check_pull
	lda	#VERB_PUSH
	sta	CURRENT_VERB
	jmp	done_keypress

check_pull:
	cmp	#'N'
	bne	check_walk
	lda	#VERB_PULL
	sta	CURRENT_VERB
	jmp	done_keypress

check_walk:
	cmp	#'M'
	bne	check_left
	lda	#VERB_WALK
	sta	CURRENT_VERB
	jmp	done_keypress



;check_load:
;	cmp	#$C			; control-L
;	bne	check_save

;	jsr	load_game
;	jmp	done_keypress

;check_save:
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
	lda	CURSOR_X		; if 41<x<$FB don't decrement
	cmp	#41
	bcc	do_dec_cursor_x
	cmp	#$FB
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
	lda	CURSOR_X		; if 40<x<$FA don't increment
	cmp	#40
	bcc	do_inc_cursor_x
	cmp	#$FA
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
	lda	CURSOR_Y		; if 49<y<$F0 don't decrement
	cmp	#49
	bcc	do_dec_cursor_y
	cmp	#$F0
	bcc	done_up_pressed
do_dec_cursor_y:
	dec	CURSOR_Y
	dec	CURSOR_Y
done_up_pressed:
	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_return
down_pressed:
	lda	CURSOR_Y		; if 48<y<$EE don't decrement
	cmp	#48
	bcc	do_inc_cursor_y
	cmp	#$EE
	bcc	done_down_pressed
do_inc_cursor_y:
	inc	CURSOR_Y
	inc	CURSOR_Y
done_down_pressed:
	jmp	done_keypress

check_return:
	cmp	#' '
	beq	return_pressed
	cmp	#13
	bne	done_keypress

return_pressed:

special_return:
	jsr	handle_return

	; special case, don't make cursor visible
	jmp	no_keypress

done_keypress:
	lda	#1			; make cursor visible
	sta	CURSOR_VISIBLE

no_keypress:
	bit	KEYRESET
	rts


	;============================
	; handle_return
	;============================
handle_return:

	; check if walking verb

	jsr	set_destination


	rts

	;==============================
	; set destination
	;==============================
set_destination:
	lda	CURSOR_X
	sta	DESTINATION_X
	lda	CURSOR_Y
	and	#$FE			; has to be even
	sta	DESTINATION_Y

	; FIXME: adjust for bounds

	rts


	;============================
	; handle_special
	;===========================

	; set up jump table fakery
handle_special:
;	ldy	#LOCATION_SPECIAL_FUNC+1
;	lda	(LOCATION_STRUCT_L),Y
;	pha
;	dey
;	lda	(LOCATION_STRUCT_L),Y
;	pha
	rts





	;=============================
	; change location
	;=============================
change_location:
	; reset graphics
	bit	SET_GR

	; reset pointer to not visible, centered
	lda	#0
	sta	ANIMATE_FRAME
	sta	CURSOR_VISIBLE
	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	lda	LOCATION
	asl
	tay

	;==========================
	; update location pointer

	lda	(LOCATIONS_L),Y
	sta	LOCATION_STRUCT_L
	iny
	lda	(LOCATIONS_L),Y
	sta	LOCATION_STRUCT_H


	;==========================
	; load new background

	ldy	#0

	lda	(LOCATION_STRUCT_L),Y
	sta	LZSA_SRC_LO
	iny
	lda	(LOCATION_STRUCT_L),Y
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	rts
