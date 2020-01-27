; Ootw for Apple II Lores

; Checkpoint-10 (???)

; by Vince "DEATER" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


	;============================
	; ENTRY POINT FOR LEVEL
	;============================

ootw_c10:
	; Initializing when entering level for first time


	;========================================================
	; RESTART: called when restarting level (after game over)
	;========================================================

ootw_c10_restart:

	;===================================
	; re-initialize level state
	;===================================

	jsr	ootw_c10_level_init

	;===========================
	; c10_new_room
	;===========================
	; enter new room on level 14

c10_new_room:
	lda	#0
	sta	GAME_OVER

	;====================================
	; Initialize room based on WHICH_ROOM
	; and then play until we exit
	;====================================

	jsr	ootw_c10_setup_room_and_play


	;====================================
	; we exited the room
	;====================================
c10_check_done:

	lda	GAME_OVER		; if died or quit, jump to quit level
	cmp	#$ff
	beq	quit_level

	;=====================================================
	; Check to see which room to enter next
	; If it's a special value, means we succesfully beat the level
c10_defeated:
	lda     WHICH_ROOM
	cmp	#$ff
	bne	c10_new_room

	; point to next level
	; and exit to the level loader
	lda	#11
	sta	WHICH_LOAD
	rts


;===========================
; quit_level
;===========================

quit_level:
	jsr	TEXT			; text mode
	jsr	HOME			; clear screen
	lda	KEYRESET		; clear keyboard state

	lda	#0			; set to PAGE0
	sta	DRAW_PAGE

	lda	#<end_message		; print the end message
	sta	OUTL
	lda	#>end_message
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

wait_loop:
	lda	KEYPRESS		; wait for keypress
	bpl	wait_loop

	lda	KEYRESET		; clear strobe

	lda	#0
	sta	GAME_OVER

	jmp	ootw_c10_restart	; restart level


;=========================================
;=========================================
; Ootw Checkpoint 14 -- Tank Arena
;=========================================
;=========================================

	; call once before entering for first time
ootw_c10_level_init:
	lda	#0
	sta	WHICH_ROOM
	sta	NUM_DOORS

	lda	#1
	sta	HAVE_GUN
	sta	DIRECTION		; right

	lda	#0
	sta	PHYSICIST_X
	lda	#10
	sta	PHYSICIST_Y

	lda	#P_STANDING
	sta	PHYSICIST_STATE

	rts


	;===========================
	;===========================
	; enter new room
	;===========================
	;===========================

ootw_c10_setup_room_and_play:

	;==============================
	; each room init


	;==============================
	; setup per-room variables

	lda	WHICH_ROOM
	bne	room1

	jsr	init_shields

	;===============================
	; Room0 -- the arena
	;===============================
room:
	lda	#(2+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #$ff			; exit level if exit this way
	sta     cer_smc+1

	; set left exit
	lda     #0
	sta     cel_smc+1

	lda	#16
	sta	PHYSICIST_Y

	; load background
	lda	#>(pool_rle)
	sta	GBASH
	lda	#<(pool_rle)

	jmp	room_setup_done

	; ????
room1:
;	cmp	#1
;	bne	room2

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

	jmp	room_setup_done

room_setup_done:

	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call

	;=====================
	; setup walk collision
	jsr	recalc_walk_collision



ootw_room_already_set:
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
	; Room Loop
	;============================
	;============================
room_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;==================================
	; draw background action

	lda	WHICH_CAVE

bg_room0:

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
	;===============================

	jsr	handle_keypress

	;===============================
	; move physicist
	;===============================

	jsr	move_physicist

	;===============================
	; check room limits
	;===============================

	jsr	check_screen_limit

	;===============================
	; adjust floor
	;===============================

;	lda	PHYSICIST_STATE
;	cmp	#P_FALLING_DOWN
;	beq	check_floor0_done

;	lda	WHICH_CAVE
;	cmp	#0
;	bne	check_floor1

;	lda	#14
;	sta	PHYSICIST_Y

;	lda	PHYSICIST_X
;	cmp	#19
;	bcc	check_floor0_done

;	lda	#12
;	sta	PHYSICIST_Y

;	lda	PHYSICIST_X
;	cmp	#28
;	bcc	check_floor0_done

;	lda	#10
;	sta	PHYSICIST_Y

check_floor0_done:

check_floor1:


	;=====================================
	; draw physicist
	;=====================================

	jsr	draw_physicist


	;=====================================
	; handle gun
	;=====================================

	jsr	handle_gun

	;=====================================
	; draw foreground action
	;=====================================

;	lda	WHICH_CAVE
;	cmp	#0
;	bne	c5_no_fg_action

c5_draw_rocks:
;	lda	#1
;	sta	XPOS
;	lda	#26
;	sta	YPOS
;	lda	#<small_rock
;	sta	INL
;	lda	#>small_rock
;	sta	INH
;	jsr	put_sprite

;	lda	#10
;	sta	XPOS
;	lda	#18
;	sta	YPOS
;	lda	#<medium_rock
;	sta	INL
;	lda	#>medium_rock
;	sta	INH
;	jsr	put_sprite

;	lda	#31
;	sta	XPOS
;	lda	#14
;	sta	YPOS
;	lda	#<large_rock
;	sta	INL
;	lda	#>large_rock
;	sta	INH
;	jsr	put_sprite

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


	;====================================
	; page flip
	;====================================

	jsr	page_flip

	;====================================
	; inc frame count
	;====================================

	inc	FRAMEL
	bne	room_frame_no_oflo
	inc	FRAMEH
room_frame_no_oflo:

	;==========================
	; check if done this level
	;==========================

	lda	GAME_OVER
	beq	still_in_room

	cmp	#$ff			; if $ff, we died
	beq	done_room

	;===============================
	; check if exited room to right
	cmp	#1
	beq	room_exit_left

	;=================
	; exit to right

room_right_yes_exit:

	lda	#0
	sta	PHYSICIST_X
cer_smc:
	lda	#$0			; smc+1 = exit location
	sta	WHICH_ROOM
	jmp	done_room

	;=====================
	; exit to left

room_exit_left:

	lda	#37
	sta	PHYSICIST_X
cel_smc:
	lda	#0		; smc+1
	sta	WHICH_ROOM
	jmp	done_room

	; loop forever
still_in_room:
	lda	#0
	sta	GAME_OVER

	jmp	room_loop

done_room:
	rts

end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: GRND",0

.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
;.include "gr_fast_clear.s"
.include "gr_copy.s"
;.include "gr_copy_offset.s"
.include "gr_putsprite.s"
;.include "gr_putsprite_flipped.s"
.include "gr_putsprite_crop.s"
.include "gr_offsets.s"
;.include "gr_offsets_hl.s"
.include "gr_hlin.s"
.include "keyboard.s"

.include "physicist.s"
.include "alien.s"
.include "dummy_friend.s"

.include "gun.s"
.include "laser.s"
.include "alien_laser.s"
.include "blast.s"
.include "shield.s"

.include "door.s"
.include "collision.s"

; room backgrounds
.include "ootw_graphics/l9swim/ootw_c9_swim.inc"
; sprites
.include "ootw_graphics/sprites/physicist.inc"
.include "ootw_graphics/sprites/alien.inc"

