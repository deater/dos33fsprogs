; Ootw for Apple II Lores
; Checkpoint-15 (arrival at the baths)

; by Vince "DEATER" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

; bath:
;  after crash, hop out of sphere.  move quickly as you can get lasered
;   right near the pod, but if you walk by the column you can stand
;   forever and not get shot
; walkway1:
;   does not appear you can re-enter bath?  lasers from behind come in
;   but don't hurt you unless you try to walk back in

	;============================
	; ENTRY POINT FOR LEVEL
	;============================

ootw_c15:
	; Initializing when entering level for first time


	;========================================================
	; RESTART: called when restarting level (after game over)
	;========================================================

ootw_c15_restart:

	;===================================
	; run bath intro
	;===================================

	jsr	bath_intro

	;===================================
	; re-initialize level state
	;===================================

	jsr	ootw_c15_level_init

	;===========================
	; c15_new_room
	;===========================
	; enter new room on level 15

c15_new_room:
	lda	#0
	sta	GAME_OVER

	;====================================
	; Initialize room based on WHICH_ROOM
	; and then play until we exit
	;====================================

	jsr	ootw_c15_setup_room_and_play


	;====================================
	; we exited the room
	;====================================
c15_check_done:

	lda	GAME_OVER		; if died or quit, jump to quit level
	cmp	#$ff
	beq	quit_level

	;=====================================================
	; Check to see which room to enter next
	; If it's a special value, means we succesfully beat the level
c15_defeated:
	lda     WHICH_ROOM
	cmp	#$ff
	bne	c15_new_room

	; point to next level
	; and exit to the level loader
	lda	#16
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

	jmp	ootw_c15_restart	; restart level


;=========================================
;=========================================
; Ootw Checkpoint 15 -- End of the game
;=========================================
;=========================================

	; call once before entering for first time
ootw_c15_level_init:
	lda	#0
	sta	WHICH_ROOM
	sta	NUM_DOORS

	lda	#1
	sta	HAVE_GUN
	sta	DIRECTION		; right

	lda	#22
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

ootw_c15_setup_room_and_play:

	;==============================
	; each room init


	;==============================
	; setup per-room variables

	lda	WHICH_CAVE
	bne	room1

	jsr	init_shields

	;===============================
	; Room0 -- with the bathers
	;===============================
room:
	lda	#(20+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #1
	sta     cer_smc+1

	; set left exit
	lda     #0
	sta     cel_smc+1

	lda	#20
	sta	PHYSICIST_Y

	; load background
	lda	#>(bath_end_rle)
	sta	GBASH
	lda	#<(bath_end_rle)

	jmp	room_setup_done

	;===============================
	; Room1 -- first walkway
	;===============================
room1:
	cmp	#1
	bne	room2

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #2
	sta     cer_smc+1

	; set left exit
	lda     #0
	sta     cel_smc+1

	lda	#8
	sta	PHYSICIST_Y

	; load background
	lda	#>(walkway1_rle)
	sta	GBASH
	lda	#<(walkway1_rle)

	jmp	room_setup_done

	;===============================
	; Room2 -- second walkway
	;===============================
room2:
	cmp	#2
	bne	room3

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #3
	sta     cer_smc+1

	; set left exit
	lda     #1
	sta     cel_smc+1

	lda	#8
	sta	PHYSICIST_Y

	; load background
	lda	#>(walkway2_rle)
	sta	GBASH
	lda	#<(walkway2_rle)

	jmp	room_setup_done

	;===============================
	; Room3 -- third walkway
	;===============================
room3:
	cmp	#3
	bne	room4

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #4
	sta     cer_smc+1

	; set left exit
	lda     #2
	sta     cel_smc+1

	lda	#8
	sta	PHYSICIST_Y

	; load background
	lda	#>(walkway3_rle)
	sta	GBASH
	lda	#<(walkway3_rle)

	jmp	room_setup_done

	;===============================
	; Room4 -- above pit
	;===============================
room4:
	cmp	#4
	bne	room5

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #5
	sta     cer_smc+1

	; set left exit
	lda     #3
	sta     cel_smc+1

	lda	#24
	sta	PHYSICIST_Y

	; load background
	lda	#>(above_pit_rle)
	sta	GBASH
	lda	#<(above_pit_rle)

	jmp	room_setup_done

	;===============================
	; Room5 -- final scene
	;===============================
room5:
;	cmp	#4
;	bne	room5

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #$ff		; exit level when done
	sta     cer_smc+1

	; set left exit
	lda     #4
	sta     cel_smc+1

	lda	#24
	sta	PHYSICIST_Y

	; load background
	lda	#>(final_rle)
	sta	GBASH
	lda	#<(final_rle)

;	jmp	room_setup_done







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

;	lda	WHICH_ROOM

bg_room0:

;	cmp	#0
;	bne	c15_no_bg_action

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

c15_no_bg_action:

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
	; adjust floor if necessary
	;===============================
	; no sloped floors in c15

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

	lda	WHICH_ROOM
	cmp	#0
	bne	c15_no_fg_action

	; Room 0 draw guard
c15_draw_fg_guard:

	; real game it's not quite so regular, double shot eventually

	; every so often, shoots
	; for frames 0 and 1 every 32 ($1F)

	lda	FRAMEL
	and	#$1f
	cmp	#3
	bcs	fg_guard_noshoot	; bgt

fg_guard_shoot:
	lda	#$ff
	bne	fg_guard_draw

fg_guard_noshoot:
	lda	#$00

fg_guard_draw:
	sta	XPOS
	lda	#22
	sta	YPOS
	lda	#<guard_sprite
	sta	INL
	lda	#>guard_sprite
	sta	INH
	jsr	put_sprite_crop


	; draw laser

	lda	FRAMEL
	and	#$1f
	cmp	#3
	bcs	fg_guard_no_laser		; bge

	lda	#9
	sta	XPOS
	lda	#20
	sta	YPOS
	lda	#<guard_laser
	sta	INL
	lda	#>guard_laser
	sta	INH
	jsr	put_sprite

fg_guard_no_laser:

	jmp	c15_no_fg_action

	; Room 5 friend slowly working to left
c15_draw_friend_cliff:

c15_no_fg_action:

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
c15_move_fg_objects:

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
.byte	11,20,"ACCESS CODE: ANKD",0

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
.include "gr_overlay.s"
.include "gr_run_sequence.s"

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
.include "ootw_graphics/l15final/ootw_c15_bath.inc"
.include "ootw_graphics/l15final/ootw_c15_final.inc"
; sprites
.include "ootw_graphics/sprites/physicist.inc"
.include "ootw_graphics/sprites/alien.inc"

;=======================
; Bath intro

bath_intro:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	bit	KEYRESET

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	lda	#<bath_arrival_sequence
	sta	INTRO_LOOPL
	lda	#>bath_arrival_sequence
	sta	INTRO_LOOPH

        jmp	run_sequence

;	rts

;=======================
; Bath Arrival Sequence

bath_arrival_sequence:
	.byte 255
	.word bath_00_rle
	.byte 25
	.word bath_01_rle
	.byte 25
	.word bath_02_rle
	.byte 25
	.word bath_03_rle
	.byte 25
	.word bath_04_rle
	.byte 25
	.word bath_05_rle
	.byte 25
	.word bath_06_rle
	.byte 25
	.word bath_07_rle
	.byte 25
	.word bath_08_rle
	.byte 25
	.word bath_09_rle
	.byte 25
	.word bath_10_rle
	.byte 25
	.word bath_11_rle
	.byte 25
	.word bath_12_rle
	.byte 25
	.word bath_13_rle
	.byte 25
	.word bath_14_rle
	.byte 25
	.word bath_15_rle
	.byte 25
	.word bath_16_rle
	.byte 25
	.word bath_17_rle
	.byte 25
	.word bath_18_rle
	.byte 25
	.word bath_19_rle
	.byte 25
	.word bath_20_rle
	.byte 25
	.word bath_21_rle
	.byte 25
	.word bath_22_rle
	.byte 25
	.word bath_23_rle
	.byte 25
	.word bath_24_rle
	.byte 25
	.word bath_25_rle
	.byte 25
	.word bath_26_rle
	.byte 25
	.word bath_27_rle
	.byte 25
	.word bath_28_rle
	.byte 25
	.word bath_29_rle
	.byte 25
	.word bath_30_rle
	.byte 25
	.word bath_31_rle
	.byte 25
	.word bath_32_rle
	.byte 25
	.word bath_33_rle
	.byte 25
	.word bath_34_rle
	.byte 25
	.word bath_35_rle
	.byte 25
	.word bath_35_rle
	.byte 0


;=======================
; guard sprite
guard_sprite:
	.byte 10,13
	.byte $7A,$7A,$7A,$7A,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $77,$77,$77,$77,$77,$AA,$AA,$AA,$AA,$AA
	.byte $77,$77,$77,$77,$77,$AA,$AA,$AA,$0A,$00
	.byte $00,$00,$00,$77,$A7,$AA,$AA,$7A,$70,$AA
	.byte $00,$00,$00,$00,$AA,$7A,$77,$77,$77,$7A
	.byte $00,$00,$00,$70,$77,$77,$77,$77,$77,$77
	.byte $00,$00,$70,$77,$77,$77,$77,$77,$AA,$AA
	.byte $00,$00,$07,$77,$77,$77,$A7,$AA,$AA,$AA
	.byte $00,$00,$00,$07,$A7,$A7,$AA,$AA,$AA,$AA
	.byte $00,$00,$00,$00,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $00,$00,$00,$00,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $00,$00,$00,$00,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $00,$00,$00,$00,$AA,$AA,$AA,$AA,$AA,$AA

;=======================
; guard laser
guard_laser:
;	.byte 15,4
;	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$1A,$1A,$A1
;	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$1A,$1A,$A1,$A1,$AA,$AA,$AA
;	.byte $AA,$AA,$AA,$AA,$1A,$1A,$11,$A1,$A1,$AA,$AA,$AA,$AA,$AA,$AA
;	.byte $1A,$1A,$11,$A1,$A1,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA

	.byte 15,3
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$1A,$1A,$1A
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$1A,$1A,$1A,$11,$A1,$A1,$A1,$AA,$AA
	.byte $1A,$1A,$1A,$11,$A1,$A1,$A1,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA



