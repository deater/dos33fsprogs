; Ootw Checkpoint2 -- Running around the Jail

ootw_jail:
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

	jsr	jail_load_background


	;==============================
	; setup per-room variables

	lda	WHICH_JAIL
	bne	jail1

jail0:
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

jail1:
	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

jail_setup_done:


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


	;=======================
	; draw miners mining

	;===============================
	; check keyboard

	jsr	handle_keypress

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
	bne	jail_frame_no_oflo
	inc	FRAMEH

jail_frame_no_oflo:

	; check if done this level

	lda	GAME_OVER
	beq	still_in_jail

	cmp	#$ff			; if $ff, we died
	beq	done_jail

	;===============================
	; check if exited room to right
	cmp	#1
	beq	jail_exit_left

	; exit to right
jail_exit_right:
	lda	#0
	sta	PHYSICIST_X
jer_smc:
	lda	#$0
	sta	WHICH_CAVE
	jmp	ootw_jail

jail_exit_left:
	lda	#37
	sta	PHYSICIST_X
jel_smc:
	lda	#0
	sta	WHICH_CAVE
	jmp	ootw_jail


	; loop forever
still_in_jail:
	jmp	jail_loop

done_jail:
	rts




	;===============================
	; load proper background to $c00
	;===============================

jail_load_background:

	lda	WHICH_JAIL
	bne	jail_bg1

jail_bg0:
	; load background
	lda	#>(cage_fell_rle)
	sta	GBASH
	lda	#<(cage_fell_rle)
	sta	GBASL
	jmp	jail_bg_done

jail_bg1:
	; load background
	lda	#>(jail2_rle)
	sta	GBASH
	lda	#<(jail2_rle)
	sta	GBASL
jail_bg_done:
	lda	#$c				; load to page $c00
	jmp	load_rle_gr			; tail call

