; Ootw Checkpoint5 -- Running around the Caves


	; call once before entering cave for first time
ootw_cave_init:
	lda	#0
	sta	PHYSICIST_STATE
	sta	WHICH_CAVE

	lda	#1
	sta	HAVE_GUN
	sta	DIRECTION		; right

	lda	#0
	sta	PHYSICIST_X
	lda	#20
	sta	PHYSICIST_Y

	rts


	;===========================
	; enter new room in cave
	;===========================

ootw_cave:

	;==============================
	; each room init

;	lda	#0
;	sta	ON_ELEVATOR
;	sta	TELEPORTING

	;==============================
	; setup per-room variables

	lda	WHICH_CAVE
	bne	cave1

	; Room0 entrance
cave0:
	lda	#(0+128)
	sta	LEFT_LIMIT
	lda	#(38+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #1
	sta     cer_smc+1

	; set left exit
	lda     #0
	sta     cel_smc+1

	lda	#14
	sta	PHYSICIST_Y

	; load background
	lda	#>(entrance_rle)
	sta	GBASH
	lda	#<(entrance_rle)

	jmp	cave_setup_done

	; hallway with weird ceiling
cave1:
;	cmp	#1
;	bne	cave2

;	lda	#(-4+128)
;	sta	LEFT_LIMIT
;	lda	#(39+128)
;	sta	RIGHT_LIMIT

	; set right exit
;	lda     #2
;	sta     cer_smc+1

	; set left exit
;	lda     #0
;	sta     cel_smc+1

;	lda	#8
;	sta	PHYSICIST_Y

	; load background
;	lda	#>(hallway_rle)
;	sta	GBASH
;	lda	#<(hallway_rle)

	jmp	cave_setup_done

cave_setup_done:

	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call


ootw_cave_already_set:
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
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	;============================
	; Cave Loop
	;============================
	;============================
cave_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;==================================
	; draw background action

	lda	WHICH_CAVE

bg_cave0:

;	cmp	#0
;	bne	c4_no_bg_action

;	lda	FRAMEL
;	and	#$c
;	lsr
;	tay


;	lda	#11
;	sta	XPOS
;	lda	#24
;	sta	YPOS

;	lda	recharge_bg_progression,Y
;	sta	INL
;	lda	recharge_bg_progression+1,Y
;	sta	INH

;	jsr	put_sprite

c5_no_bg_action:

	;===============================
	; check keyboard

	jsr	handle_keypress

	;===============================
	; move physicist
	;===============================

	jsr	move_physicist

	;===============================
	; move friend
	;===============================

;	jsr	move_friend


	;===============
	; check room limits

	jsr	check_screen_limit


	;===============
	; draw physicist

	jsr	draw_physicist

	;===============
	; draw friend

;	jsr	draw_friend

c5_done_draw_friend:


	;========================
	; draw foreground action

;	lda	WHICH_CAVE
;	cmp	#2
;	bne	c4_no_fg_action

;c2_draw_cart:
;
;	lda	CART_X
;	sta	XPOS
;	lda	#36
;	sta	YPOS
;	lda	#<cart_sprite
;	sta	INL
;	lda	#>cart_sprite
;	sta	INH
;	jsr     put_sprite_crop
;	jmp	c2_no_fg_action

c5_no_fg_action:

	;====================
	; activate fg objects
	;====================
;c2_fg_check_jail1:
;	lda	WHICH_JAIL
;	cmp	#1
;	bne	c2_fg_check_jail2
;
;	lda	CART_OUT
;	bne	c2_fg_check_jail2
;
;	inc	CART_OUT


	;================
	; move fg objects
	;================
c4_move_fg_objects:

;	lda	CART_OUT
;	cmp	#1
;	bne	cart_not_out

	; move cart

;	lda	FRAMEL
;	and	#$3
;	bne	cart_not_out
;
;	inc	CART_X
;	lda	CART_X
;	cmp	#39
;	bne	cart_not_out
;	inc	CART_OUT


	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	cave_frame_no_oflo
	inc	FRAMEH
cave_frame_no_oflo:

	;==========================
	; check if done this level
	;==========================

	lda	GAME_OVER
	beq	still_in_cave

	cmp	#$ff			; if $ff, we died
	beq	done_cave

	;===============================
	; check if exited room to right
	cmp	#1
	beq	cave_exit_left

	;=================
	; exit to right

cave_right_yes_exit:

	lda	#0
	sta	PHYSICIST_X
cer_smc:
	lda	#$0			; smc+1 = exit location
	sta	WHICH_CAVE
	jmp	done_cave

	;=====================
	; exit to left

cave_exit_left:

	lda	#37
	sta	PHYSICIST_X
cel_smc:
	lda	#0		; smc+1
	sta	WHICH_CAVE
	jmp	done_cave

	; loop forever
still_in_cave:
	lda	#0
	sta	GAME_OVER

	jmp	cave_loop

done_cave:
	rts



