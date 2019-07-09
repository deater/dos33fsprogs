; Ootw Checkpoint2 -- Running around the Jail

ootw_jail:

	;==============================
	; setup per-room variables

	lda	WHICH_JAIL
	bne	jail1

jail0:
	lda	#(18+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #1
	sta     jer_smc+1

	; set left exit
	lda     #0
	sta     jel_smc+1

	lda	#22
	sta	PHYSICIST_Y

	; load background
	lda	#>(cage_fell_rle)
	sta	GBASH
	lda	#<(cage_fell_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call


	jmp	jail_setup_done

jail1:
	lda	WHICH_JAIL
	cmp	#1
	bne	jail2

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #2
	sta     jer_smc+1

	; set left exit
	lda     #0
	sta     jel_smc+1

	lda	#30
	sta	PHYSICIST_Y

	; load background
	lda	#>(jail2_rle)
	sta	GBASH
	lda	#<(jail2_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call

	jmp	jail_setup_done

jail2:
	lda	WHICH_JAIL
	cmp	#2
	bne	jail3

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #3
	sta     jer_smc+1

	; set left exit
	lda     #1
	sta     jel_smc+1

	; load background
	lda	#>(jail3_rle)
	sta	GBASH
	lda	#<(jail3_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call

	jmp	jail_setup_done

jail3:

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #4
	sta     jer_smc+1

	; set left exit
	lda     #2
	sta     jel_smc+1

	; load background
	lda	#>(jail4_rle)
	sta	GBASH
	lda	#<(jail4_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call


jail_setup_done:

ootw_jail_already_set:
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
	; Cage Loop
	;============================
jail_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;==================================
	; draw background action
	; FIXME

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


	;========================
	; draw foreground action
	; FIXME

	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	jail_frame_no_oflo
	inc	FRAMEH
jail_frame_no_oflo:

	;==========================
	; check if done this level

	lda	GAME_OVER
	beq	still_in_jail

	cmp	#$ff			; if $ff, we died
	beq	done_jail

	;===============================
	; check if exited room to right
	cmp	#1
	beq	jail_exit_left

	;=================
	; exit to right
jail_exit_right:
	lda	PHYSICIST_X
	cmp	#35
	bcs	jail_right_yes_exit	; bge

jail_right_stop_not_exit:
	lda	#0
	sta	PHYSICIST_STATE
	jmp	still_in_jail

jail_right_yes_exit:

	lda	#0
	sta	PHYSICIST_X
jer_smc:
	lda	#$0			; smc+1 = exit location
	sta	WHICH_CAVE
	jmp	done_jail

	;=====================
	; exit to left

jail_exit_left:
	lda	PHYSICIST_X
	bmi	jail_left_yes_exit	; off screen so negative

jail_left_stop_not_exit:
	lda	#0
	sta	PHYSICIST_STATE
	lda	LEFT_LIMIT
	sec
	sbc	#$7f
	sta	PHYSICIST_X
	jmp	still_in_jail

jail_left_yes_exit:
	lda	#37
	sta	PHYSICIST_X
jel_smc:
	lda	#0		; smc+1
	sta	WHICH_CAVE
	jmp	done_jail

	; loop forever
still_in_jail:
	lda	#0
	sta	GAME_OVER

	jmp	jail_loop

done_jail:
	rts





