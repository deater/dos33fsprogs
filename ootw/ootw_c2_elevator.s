; Ootw Checkpoint2 -- Using the elevator

ootw_elevator:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	;=============================
	; load background image

	jsr	elevator_load_background


	;==============================
	; setup per-room variables

	lda	WHICH_JAIL
	cmp	#4
	bne	elevator5

elevator4:
	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(30+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #3
	sta     eel_smc+1

	jmp	elevator_setup_done

elevator5:
	cmp	#5
	bne	elevator6

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(30+128)
	sta	RIGHT_LIMIT

elevator6:

elevator_setup_done:


	;=================================
	; copy to screen

	jsr	gr_copy_to_current
	jsr	page_flip

	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	; Elevator Loop
	;============================
elevator_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;===============================
	; check keyboard

	jsr	handle_keypress

	;===============================
	; move physicist

	jsr	move_physicist

	;===============
	; check room limits

	jsr	check_screen_limit


	;===============
	; draw physicist

	jsr	draw_physicist


	;================
	; draw foreground

	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	elevator_frame_no_oflo
	inc	FRAMEH

elevator_frame_no_oflo:

	; check if done this level

	lda	GAME_OVER
	beq	still_in_elevator

	cmp	#$ff			; if $ff, we died
	beq	done_elevator

	;===============================
	; check if exited room to right
	cmp	#1
	beq	elevator_exit_left

	; exit to right
elevator_exit_right:
	lda	#0
	sta	PHYSICIST_X
eer_smc:
	lda	#$0
	sta	WHICH_CAVE
	jmp	done_elevator

elevator_exit_left:
	lda	#37
	sta	PHYSICIST_X
eel_smc:
	lda	#0
	sta	WHICH_CAVE
	jmp	done_elevator


	; loop forever
still_in_elevator:
	jmp	elevator_loop

done_elevator:
	rts




	;===============================
	; load proper background to $c00
	;===============================

elevator_load_background:

	ldy	#0
elevator_background_loop:

	lda	gr_offsets,Y
	sta	line0_left_loop+1
	sta	line0_center_loop+1

	lda	gr_offsets+1,Y
	clc
	adc	#$8
	sta	line0_left_loop+2
	sta	line0_center_loop+2

	lda	elevator_fb,Y
	ldx	#0
line0_left_loop:
	sta	$c00,X
	inx
	cpx	#16
	bne	line0_left_loop

	lda	elevator_fb+1,Y
line0_center_loop:
	sta	$c00,X
	inx
	cpx	#25
	bne	line0_center_loop

	lda	#$88
line0_right_loop:
	sta	$c00,X
	inx
	cpx	#39
	bne	line0_right_loop

	iny
	iny
	cpy	#48
	bne	elevator_background_loop

	rts


elevator_fb:
	.byte	$88,$88,$88,$88,$88,$88,$88,$88,$88
	.byte	$00,$00,$00,$00,$00,$00,$00
	.byte	$88,$88,$88,$88,$88,$88,$88,$88

	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
