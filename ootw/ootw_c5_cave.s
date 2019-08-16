; Ootw Checkpoint5 -- Running around the Caves


	; call once before entering cave for first time
ootw_cave_init:
	lda	#0
	sta	WHICH_CAVE
	; yes you fall in facing left for some reason
	sta	DIRECTION		; left
	sta	NUM_DOORS

	lda	#1
	sta	HAVE_GUN


	lda	#0
	sta	PHYSICIST_X
	lda	#230
	sta	PHYSICIST_Y

	lda	#P_FALLING_DOWN
	sta	PHYSICIST_STATE

	lda	#14
	sta	fall_down_destination_smc+1

	rts


	;===========================
	; enter new room in cave
	;===========================

ootw_cave:

	;==============================
	; each room init


	;==============================
	; setup per-room variables

	lda	WHICH_CAVE
	bne	cave1

	jsr	init_shields

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

	lda	PHYSICIST_STATE
	cmp	#P_FALLING_DOWN
	beq	falling_in
not_falling_in:
	lda	#14
	sta	PHYSICIST_Y
falling_in:

	; load background
	lda	#>(entrance_rle)
	sta	GBASH
	lda	#<(entrance_rle)

	jmp	cave_setup_done

	; ????
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

	;=====================
	; setup walk collision
	jsr	recalc_walk_collision



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

	;===============
	; check room limits

	jsr	check_screen_limit

	;=================
	; adjust floor

	lda	PHYSICIST_STATE
	cmp	#P_FALLING_DOWN
	beq	check_floor0_done

	lda	WHICH_CAVE
	cmp	#0
	bne	check_floor1

	lda	#14
	sta	PHYSICIST_Y

	lda	PHYSICIST_X
	cmp	#19
	bcc	check_floor0_done

	lda	#12
	sta	PHYSICIST_Y

	lda	PHYSICIST_X
	cmp	#28
	bcc	check_floor0_done

	lda	#10
	sta	PHYSICIST_Y

check_floor0_done:

check_floor1:


	;===============
	; draw physicist

	jsr	draw_physicist


	;===============
	; handle gun

	jsr	handle_gun

	;========================
	; draw foreground action

	lda	WHICH_CAVE
	cmp	#0
	bne	c5_no_fg_action

c5_draw_rocks:
	lda	#1
	sta	XPOS
	lda	#26
	sta	YPOS
	lda	#<small_rock
	sta	INL
	lda	#>small_rock
	sta	INH
	jsr	put_sprite

	lda	#10
	sta	XPOS
	lda	#18
	sta	YPOS
	lda	#<medium_rock
	sta	INL
	lda	#>medium_rock
	sta	INH
	jsr	put_sprite

	lda	#31
	sta	XPOS
	lda	#14
	sta	YPOS
	lda	#<large_rock
	sta	INL
	lda	#>large_rock
	sta	INH
	jsr	put_sprite

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


; at 1,26
small_rock:
	.byte 3,3
	.byte $0A,$02,$20
	.byte $00,$20,$A2
	.byte $AA,$A2,$AA


; at 10,18
medium_rock:
	.byte 5,6
	.byte $AA,$AA,$6A,$AA,$AA
	.byte $AA,$00,$00,$66,$AA
	.byte $AA,$20,$20,$A6,$AA
	.byte $0A,$00,$00,$02,$22
	.byte $A0,$00,$00,$00,$22
	.byte $2A,$00,$00,$02,$2A

; at 31,14
large_rock:
	.byte 7,6
	.byte $AA,$0A,$02,$02,$66,$6A,$AA
	.byte $AA,$00,$00,$00,$20,$22,$AA
	.byte $AA,$AA,$0A,$00,$62,$6A,$AA
	.byte $2A,$22,$00,$00,$06,$66,$6A
	.byte $00,$00,$00,$00,$22,$A2,$A6
	.byte $AA,$A0,$00,$00,$02,$AA,$AA




