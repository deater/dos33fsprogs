; Ootw Checkpoint2 -- Running around the Jail

ootw_jail:

	;==============================
	; init

	lda	#0
	sta	ON_ELEVATOR

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

	jmp	jail_setup_done

jail1:
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

	jmp	jail_setup_done

jail2:
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

	jmp	jail_setup_done

jail3:
	cmp	#3
	bne	jail4

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #7
	sta     jer_smc+1

	; set left exit
	lda     #2
	sta     jel_smc+1

	lda	#30
	sta	PHYSICIST_Y

	; load background
	lda	#>(jail4_rle)
	sta	GBASH
	lda	#<(jail4_rle)

	jmp	jail_setup_done

jail4:
	cmp	#4
	bne	jail5

	lda	#(10+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #8
	sta     jer_smc+1

	; set left exit
	lda     #5
	sta     jel_smc+1

	; FIXME: different if in from left?
	lda	#8
	sta	PHYSICIST_Y

	; load background
	lda	#>(room_b4_rle)
	sta	GBASH
	lda	#<(room_b4_rle)

	jmp	jail_setup_done

jail5:
	cmp	#5
	bne	jail6

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #4
	sta     jer_smc+1

	lda	#30
	sta	PHYSICIST_Y

	; load background
	lda	#>(room_b3_rle)
	sta	GBASH
	lda	#<(room_b3_rle)

	jmp	jail_setup_done

jail6:

	lda	#(17+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #9
	sta     jer_smc+1

	lda	#20
	sta	PHYSICIST_Y

	; load background
	lda	#>(room_b2_rle)
	sta	GBASH
	lda	#<(room_b2_rle)

	jmp	jail_setup_done


jail_setup_done:

	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call


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

	lda	WHICH_JAIL
	cmp	#6
	bne	c2_no_bg_action

	; draw power
	lda	JAIL_POWER_ON
	beq	c2_no_bg_action		; skip if power off already

	lda	#20
	sta	XPOS
	lda	#0
	sta	YPOS

	lda	FRAMEL
	lsr
	lsr
	lsr
	and	#$6
	tay

	lda     power_line_sprites,Y
        sta     INL
        lda     power_line_sprites+1,Y
        sta     INH

        jsr     put_sprite_crop


c2_no_bg_action:

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
	;==========================

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



power_line_sprites:
	.word	power_line_sprite0
	.word	power_line_sprite1
	.word	power_line_sprite2
	.word	power_line_sprite3

power_line_sprite0:
	.byte	1,8
	; XXXoXXXoXXXoXXXo
	.byte	$77,$67,$77,$67,$77,$67,$77,$07

power_line_sprite1:
	.byte	1,8
	; XXoXXXoXXXoXXXoX
	.byte	$77,$76,$77,$76,$77,$76,$77,$06

power_line_sprite2:
	.byte	1,8
	; XoXXXoXXXoXXXoXX
	.byte	$67,$77,$67,$77,$67,$77,$67,$07

power_line_sprite3:
	.byte	1,8
	; oXXXoXXXoXXXoXXX
	.byte	$76,$77,$76,$77,$76,$77,$76,$07
