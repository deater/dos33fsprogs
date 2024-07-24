
	;==============================
	; Handle Keypress
	;==============================
handle_keypress:


.if 0
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
;        jsr     handle_joystick

js_check_left:
;        lda     value0
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
;        lda     value1
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
.endif


actually_handle_keypress:

	; check for keypress

	lda	KEYPRESS
	bmi	keypress

	jmp	no_keypress

keypress:

	; adjust weird Apple II stuff

	and	#$7f			; clear high bit
	cmp	#' '
	beq	handle_input		; make sure not to lose space
	and	#$df			; convert uppercase to lower case


handle_input:

	;==============================
	; assume pointer will be moved
	; so restore background

	pha				; save keypress info

	jsr	restore_bg_14x14	; restore old background

	inc	UPDATE_POINTER		; keypress so assume need move pointer

	pla				; restore keypress info

check_sound:
	cmp	#$13			; control-S
	bne	check_left

	; toggle sound

	lda	SOUND_STATUS
	eor	#SOUND_DISABLED
	sta	SOUND_STATUS
	jmp	done_keypress

	; can't be ^J as that's the same as down
;check_joystick:
;	cmp	#'J'
;	bne	check_left

;	lda	JOYSTICK_ENABLED
;	eor	#1
;	sta	JOYSTICK_ENABLED
;	jmp	done_keypress


check_left:
	cmp	#'A'
	beq	left_pressed
	cmp	#8			; left key
	bne	check_right
left_pressed:
	lda	CURSOR_X		; check Xpos
	beq	done_left_pressed	; if Xpos==0 don't move left

do_dec_cursor_x:
	dec	CURSOR_X		; move left one 3.5 pixel column
done_left_pressed:
	jmp	done_keypress		; done checking input



check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15			; right key
	bne	check_up
right_pressed:
	lda	CURSOR_X		; load Xpos
	cmp	#38			; if Xpos > 38 don't increment
;	bcc	do_inc_cursor_x		; blt
	bcs	done_right_pressed	; bge
do_inc_cursor_x:
	inc	CURSOR_X		; move right one 3.5 pixel column
done_right_pressed:
	jmp	done_keypress		; done checking input

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B			; up key
	bne	check_down
up_pressed:
	lda	CURSOR_Y		; load YPos
	cmp	#4			; is YPos>4 then we can decrement
	bcc	done_up_pressed		; blt
do_dec_cursor_y:
	dec	CURSOR_Y		; subtract 4
	dec	CURSOR_Y		; 1 byte shorter to sec/lda/sbc/sta?
	dec	CURSOR_Y
	dec	CURSOR_Y

done_up_pressed:
	jmp	done_keypress		; done checking input

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_return
down_pressed:
	lda	CURSOR_Y		; load Ypos
	cmp	#177			; if Ypos<177 move down (pointer 14 high)
	bcs	done_down_pressed	; bge
do_inc_cursor_y:
	inc	CURSOR_Y		; add 4
	inc	CURSOR_Y
	inc	CURSOR_Y
	inc	CURSOR_Y
done_down_pressed:
	jmp	done_keypress		; done checking input

;check_escape:
;	cmp	#27
;	bne	check_return
;escape_pressed:
;	inc	ESCAPE_PRESSED

;	jmp	done_keypress

check_return:
	cmp	#' '
	beq	return_pressed
	cmp	#13
	bne	done_keypress


	;======================================
	; extra action if space/return pressed
	;======================================

return_pressed:

	lda	IN_SPECIAL
	beq	not_special_return

special_return:
	jsr	handle_special

	; special case, don't make cursor visible
	jmp	no_keypress

not_special_return:

	lda	IN_RIGHT
	beq	not_right_return

	cmp	#1
	beq	right_return

right_uturn:
	jsr	uturn
	jmp	no_keypress

right_return:
	jsr	turn_right
	jmp	no_keypress

not_right_return:

	lda	IN_LEFT
	beq	not_left_return

	cmp	#1
	beq	left_return
left_uturn:
	jsr	uturn
	jmp	no_keypress

left_return:
	jsr	turn_left
	jmp	no_keypress

not_left_return:

	jsr	go_forward
	jmp	no_keypress

done_keypress:
	lda	#1			; make cursor visible
	sta	CURSOR_VISIBLE

no_keypress:
	bit	KEYRESET
	rts

	;============================
	; handle_special
	;===========================

	; set up jump table fakery
handle_special:
	ldy	#LOCATION_SPECIAL_FUNC+1
	lda	(LOCATION_STRUCT_L),Y
	pha
	dey
	lda	(LOCATION_STRUCT_L),Y
	pha
	rts


	;=============================
	; change direction
	;=============================
change_direction:

	; load background
	lda	DIRECTION
	bpl	no_split

	; split text/graphics
	bit	TEXTGR

	; also change sprite cutoff
	; not needed for HGR

;	ldx	#40
;	stx	psc_smc1+1
;;	stx	psc_smc2+1

	jmp	done_split
no_split:
	bit	FULLGR

	; also change sprite cutoff
;	ldx	#48
;	stx	psc_smc1+1
;;	stx	psc_smc2+1

done_split:
	and	#$f			; mask off special flags
	tay
	lda	log2_table,Y
	asl
	clc
	adc	#LOCATION_NORTH_BG
	tay

	lda	(LOCATION_STRUCT_L),Y
        sta     ZX0_src
	iny
	lda	(LOCATION_STRUCT_L),Y
	sta	ZX0_src+1

	lda	#$20			; decompress to hgr page1

	jsr	full_decomp


	rts


	;=============================
	; change location
	;=============================
	;
change_location:
	; reset graphics
	bit	SET_GR

	; clear IN_SPECIAL
	lda	#0
	sta	IN_SPECIAL
	sta	IN_RIGHT
	sta	IN_LEFT

	; reset pointer to not visible, centered

	sta	ANIMATE_FRAME
	sta	CURSOR_VISIBLE
	lda	#20
	sta	CURSOR_X
	lda	#89
	sta	CURSOR_Y

	lda	LOCATION
	asl
	tay

	lda	(LOCATIONS_L),Y
	sta	LOCATION_STRUCT_L
	iny
	lda	(LOCATIONS_L),Y
	sta	LOCATION_STRUCT_H

	jsr	change_direction

	rts

	;==========================
	; go forward
	;===========================
go_forward:

	; update new location

	lda	DIRECTION
	and	#$f
	tay
	lda	log2_table,Y
	clc
	adc	#LOCATION_NORTH_EXIT
	tay
	lda	(LOCATION_STRUCT_L),Y

	; A has new destination

	; FF = can't go forward
	; otherwise if top 4 bits set, new level
	; otherwise, in current

	cmp	#$ff
	beq	cant_go_forward

	cmp	#$10
	bcs	new_level

same_level:
	sta	LOCATION

	; update new direction

	lda	DIRECTION
	and	#$f
	tay
	lda	log2_table,Y
	clc
	adc	#LOCATION_NORTH_EXIT_DIR
	tay
	lda	(LOCATION_STRUCT_L),Y
	sta	DIRECTION

	jsr	change_location
cant_go_forward:
	rts


	;=========================================
	; need to load new "level"/area from disk
	;=========================================
	; level from disk = top 4 bits
	; location = bottom 4 bits
	;	12 possible levels per disk. 1..13
	;		$0 special, means same level
	;		$E special, means "new disk"
	;			bottom 4 bits = exit info
	;		$F special, means "can't go here" when clicked

new_level:
	pha
	lsr
	lsr
	lsr
	lsr

	cmp	#$E
	beq	new_disk

	sta	WHICH_LOAD		; which level to load from disk

	pla
	and	#$0f

	sta	LOCATION

	; update new direction

	lda	DIRECTION
	and	#$f
	tay
	lda	log2_table,Y
	clc
	adc	#LOCATION_NORTH_EXIT_DIR
	tay
	lda	(LOCATION_STRUCT_L),Y
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER

	rts

new_disk:
	pla
	and	#$f
	ora	#$80
	sta	LEVEL_OVER

	rts

	;==========================
	; turn left
	;===========================
turn_left:

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	beq	go_west
	cmp	#DIRECTION_W
	beq	go_south
	cmp	#DIRECTION_S
	beq	go_east
	bne	go_north

	;==========================
	; turn right
	;===========================
turn_right:
	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	beq	go_east
	cmp	#DIRECTION_E
	beq	go_south
	cmp	#DIRECTION_S
	beq	go_west
	bne	go_north

	;==========================
	; uturn
	;===========================
uturn:

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	beq	go_south
	cmp	#DIRECTION_W
	beq	go_east
	cmp	#DIRECTION_S
	beq	go_north
	bne	go_west

go_north:
	lda	#DIRECTION_N
	jmp	done_turning
go_east:
	lda	#DIRECTION_E
	jmp	done_turning
go_south:
	lda	#DIRECTION_S
	jmp	done_turning
go_west:
	lda	#DIRECTION_W
	jmp	done_turning


done_turning:
	sta	DIRECTION
	jsr	change_direction

	rts
