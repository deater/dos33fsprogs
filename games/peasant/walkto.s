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

	;=====================
	; setup X (left/right)

	cpx	PEASANT_X
	bcs	walking_right
walking_left:
	lda	#$FF
	sta	walkto_right_left_add_smc+1
	lda	#PEASANT_DIR_LEFT
	jmp	walking_right_left_common
walking_right:
	lda	#1
	sta	walkto_right_left_add_smc+1
	lda	#PEASANT_DIR_RIGHT
walking_right_left_common:
	sta	walkto_right_left_dir_smc+1

	;=====================
	; setup Y (up/down)

	cpy	PEASANT_Y
	bcs	walking_up
walking_down:
	lda	#$FF
	sta	walkto_up_down_add_smc+1
	lda	#PEASANT_DIR_DOWN
	jmp	walking_up_down_common
walking_up:
	lda	#1
	sta	walkto_up_down_add_smc+1
	lda	#PEASANT_DIR_UP
walking_up_down_common:
	sta	walkto_up_down_dir_smc+1

	;============================
	; loop

peasant_walkto_loop:


walkto_check_up_down:
	lda	PEASANT_Y
walkto_up_down_smc:
	cmp	#$ff
	beq	walkto_check_right_left

	clc
	lda	PEASANT_Y
walkto_up_down_add_smc:
	adc	#1
	sta	PEASANT_Y

walkto_up_down_dir_smc:
	lda	#0
	sta	PEASANT_DIR

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

	rts
