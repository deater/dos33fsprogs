WALKSPEED_X = 1
WALKSPEED_Y = 4

	;=====================================
	; walk to a position
	;=====================================
	; move peasant to X,Y

	; should use xspeed/yspeed
	; should set direction facing automatically
	; should saturate if go past


peasant_walkto:

	;=====================
	; setup limits

	stx	walkto_right_left_smc+1
	stx	walkto_done_x_smc+1
	sty	walkto_up_down_smc+1
	sty	walkto_done_y_smc+1
	sty	wud_pos_y_smc+1

	;=====================
	; setup X (left/right)

	cpx	PEASANT_X
	bcs	walking_right
walking_left:
	lda	#<(-WALKSPEED_X)
	sta	walkto_right_left_add_smc+1
	lda	#PEASANT_DIR_LEFT
	jmp	walking_right_left_common
walking_right:
	lda	#WALKSPEED_X
	sta	walkto_right_left_add_smc+1
	lda	#PEASANT_DIR_RIGHT
walking_right_left_common:
	sta	walkto_right_left_dir_smc+1

	;=====================
	; setup Y (up/down)

	cpy	PEASANT_Y
	bcs	walking_down
walking_up:
	lda	#<(-WALKSPEED_Y)
	sta	walkto_up_down_add_smc+1
	lda	#PEASANT_DIR_UP
	jmp	walking_up_down_common
walking_down:
	lda	#WALKSPEED_Y
	sta	walkto_up_down_add_smc+1
	lda	#PEASANT_DIR_DOWN
walking_up_down_common:
	sta	walkto_up_down_dir_smc+1

	;============================
	; loop
	;============================

peasant_walkto_loop:

	; increment step count, wrapping at 6

	inc	PEASANT_STEPS
	lda	PEASANT_STEPS
	cmp	#6
	bne	no_peasant_steps_wrap
	lda	#0
	sta	PEASANT_STEPS
no_peasant_steps_wrap:


	; we walk more than 1 step at a time
	; so need to see if we're about to overshoot


	;==========================
	; check up and down (Ypos)

walkto_check_up_down:
	sec
	lda	PEASANT_Y
walkto_up_down_smc:
	sbc	#$ff

	bpl	wud_pos

	eor	#$ff		; absolute value
	clc
	adc	#1		; two's complement

wud_pos:
	cmp	#WALKSPEED_Y
	bcs	wud_move_y

	; if we get here we're close
	; just bump us to result

wud_pos_y_smc:
	lda	#$00
	sta	PEASANT_Y

	jmp	walkto_check_right_left

wud_move_y:
	clc
	lda	PEASANT_Y
walkto_up_down_add_smc:
	adc	#1
	sta	PEASANT_Y

walkto_up_down_dir_smc:
	lda	#0
	sta	PEASANT_DIR

	;=============================
	; check right and left (Xpos)
	; FIXME: right now assume always xadd is 1

walkto_check_right_left:
	lda	PEASANT_X
walkto_right_left_smc:
	cmp	#$ff
	beq	walkto_draw

	clc
	lda	PEASANT_X
walkto_right_left_add_smc:
	adc	#1
	sta	PEASANT_X

walkto_right_left_dir_smc:
	lda	#0
	sta	PEASANT_DIR

walkto_draw:

	inc	FRAME		; so rain keeps happening

	jsr	update_screen

	jsr	hgr_page_flip

	lda	PEASANT_X
walkto_done_x_smc:
	cmp	#$ff
	bne	walkto_not_done
	lda	PEASANT_Y
walkto_done_y_smc:
	cmp	#$FF
	beq	walkto_done

walkto_not_done:
	jmp	peasant_walkto_loop


walkto_done:

	; clear keyboard in case pressed while walking

	bit	KEYRESET

	rts
