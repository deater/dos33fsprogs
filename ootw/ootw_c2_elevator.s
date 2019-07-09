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
	bne	elevator1

elevator0:
	lda	#(20+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #1
	sta     jer_smc+1
	lda     #<ootw_jail
	sta     jer_smc+5
	lda     #>ootw_jail
	sta     jer_smc+6

	; set left exit
	lda     #0
	sta     jel_smc+1
	lda     #<ootw_jail
	sta     jel_smc+5
	lda     #>ootw_jail
	sta     jel_smc+6


	jmp	jail_setup_done

elevator1:
	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

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
	jmp	ootw_elevator

elevator_exit_left:
	lda	#37
	sta	PHYSICIST_X
eel_smc:
	lda	#0
	sta	WHICH_CAVE
	jmp	ootw_elevator


	; loop forever
still_in_elevator:
	jmp	elevator_loop

done_elevator:
	rts




	;===============================
	; load proper background to $c00
	;===============================

elevator_load_background:

; Line 0
	lda	#$88
	ldx	#0
line0_left_loop:
	sta	$c00,X
	inx
	cpx	#16
	bne	line0_left_loop

	lda	#$00
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





