; Ootw for Apple II Lores

; Checkpoint-14 (tanks for the arena memories)

; by Vince "DEATER" Weaver	<vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"


	;============================
	; ENTRY POINT FOR LEVEL
	;============================

ootw_c14:
	; Initializing when entering level for first time

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
	lda	#4
	sta	DISP_PAGE

	;========================================================
	; run tank intro
	;========================================================

	jsr	tank_intro

	;========================================================
	; RESTART: called when restarting level (after game over)
	;========================================================

ootw_c14_restart:

	;===================================
	; re-initialize level state
	;===================================

	jsr	ootw_c14_level_init

	;===========================
	; c14_new_room
	;===========================
	; enter new room on level 14

c14_new_room:
	lda	#0
	sta	GAME_OVER

	;====================================
	; Initialize room based on WHICH_ROOM
	; and then play until we exit
	;====================================

	jsr	ootw_c14_setup_room_and_play


	;====================================
	; we exited the room
	;====================================
c14_check_done:

	lda	GAME_OVER		; if died or quit, jump to quit level
	cmp	#$ff
	beq	quit_level

	;=====================================================
	; Check to see which room to enter next
	; If it's a special value, means we succesfully beat the level
c14_defeated:
	lda     WHICH_ROOM
	cmp	#$ff
	bne	c14_new_room

	; point to next level
	; and exit to the level loader
	lda	#15
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

	jmp	ootw_c14_restart	; restart level


;=========================================
;=========================================
; Ootw Checkpoint 14 -- Tank Arena
;=========================================
;=========================================

	; call once before entering for first time
ootw_c14_level_init:
	lda	#0
	sta	WHICH_ROOM

	rts


	;===========================
	;===========================
	; enter new room
	;===========================
	;===========================

ootw_c14_setup_room_and_play:

	;===============================
	; Room0 -- the arena
	;===============================
room:

	; load background
	lda	#>(arena_main_bg_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(arena_main_bg_lzsa)

room_setup_done:

	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$c				; load to page $c00
	jsr	decompress_lzsa2_fast			; tail call

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
	lda	#4
	sta	DISP_PAGE

	;=================================
	; setup vars

	lda	#0
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


	;===============================
	; check keyboard
	;===============================

	jsr	handle_keypress

	;=====================================
	; draw foreground action
	;=====================================

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


	; loop forever
still_in_room:
	lda	#0
	sta	GAME_OVER

	jmp	room_loop

done_room:
	rts

end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: TANK",0

.include "../text_print.s"
.include "../gr_pageflip.s"
.include "../decompress_fast_v2.s"
.include "../gr_copy.s"
;.include "../gr_putsprite.s"
;.include "../gr_putsprite_crop.s"
.include "../gr_offsets.s"
;.include "../gr_hlin.s"
;.include "../keyboard.s"

;.include "../physicist.s"
;.include "../alien.s"
;.include "../dummy_friend.s"

;.include "../gun.s"
;.include "../laser.s"
;.include "../alien_laser.s"
;.include "../blast.s"
;.include "../shield.s"

;.include "../door.s"
;.include "../collision.s"

.include "../gr_overlay.s"
.include "../gr_run_sequence2.s"

; room backgrounds
.include "graphics/l14_arena/ootw_c14_arena.inc"
; sprites
.include "../sprites/physicist.inc"
;.include "../sprites/alien.inc"



;======================================
; handle keypress
;======================================

; A or <-   : start moving left
; D or ->   : start moving right
; W or up   : jump or elevator/transporter up
; S or down : crouch or pickup or elevator/transporter down
; L         : charge gun
; space     : action
; escape    : quit

handle_keypress:

	lda	KEYPRESS						; 4
	bmi	keypress						; 3
no_keypress:
	bit	KEYRESET			; clear
						; avoid keeping old keys around
	rts	; nothing pressed, return

keypress:
									; -1

	and	#$7f		; clear high bit

	;======================
	; check escape

check_quit:
	cmp	#27		; quit if ESCAPE pressed
	bne	check_left

	;=====================
	; QUIT
	;=====================
quit:
	lda	#$ff		; could just dec
	sta	GAME_OVER
	rts

	;======================
	; check left
check_left:
	cmp	#'A'
	beq	left_pressed
	cmp	#$8		; left arrow
	bne	check_right


	;====================
	;====================
	; Left/A Pressed
	;====================
	;====================
left_pressed:
;	inc	GUN_FIRE		; fire gun if charging

					; left==0
;	lda	DIRECTION		; if facing right, turn to face left
;	bne	left_going_right
	jmp	done_keypress


	;========================
	; check for right pressed

check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15
	bne	check_up

	;===================
	;===================
	; Right/D Pressed
	;===================
	;===================
right_pressed:
	jmp	done_keypress


	;=====================
	; check up

check_up:
	cmp	#'W'
	beq	up
	cmp	#$0B


	bne	check_down

	;==========================
	;==========================
	; UP/W Pressed --
	;==========================
	;==========================
up:

	jmp	done_keypress


	;==========================
check_down:
	cmp	#'S'
	beq	down
	cmp	#$0A
	bne	check_space

	;==========================
	;==========================
	; Down/S Pressed
	;==========================
	;==========================
down:
	jmp	done_keypress


	;==========================


check_space:
	cmp	#' '
	beq	space
;	cmp	#$15		; ascii 21=??
	jmp	unknown

	;======================
	; SPACE -- Keypress, also look for enter?
	;======================
space:

unknown:
done_keypress:
	bit	KEYRESET	; clear the keyboard strobe		; 4

	rts								; 6



;==============================
; tank intro

tank_intro:
	lda	#<tank_intro_sequence
	sta	INTRO_LOOPL
	lda	#>tank_intro_sequence
	sta	INTRO_LOOPH

	jmp	run_sequence

;       rts

tank_intro_sequence:
	.byte	255                                     ; load to bg
	.word	inside_bg_lzsa				; this
	.byte	128+1	;       .word   inside03_lzsa	; (3)
	.byte	128+1	;       .word   inside04_lzsa	; (3)
	.byte	128+1	;       .word   inside05_lzsa	; (3)
	.byte	128+1	;       .word   inside06_lzsa	; (3)
	.byte	128+1	;       .word   inside07_lzsa	; (3)
	.byte	128+1	;       .word   inside08_lzsa	; (3)
	.byte	128+1	;       .word   inside09_lzsa	; (3)
	.byte	128+1	;       .word   inside10_lzsa	; (3)
	.byte	128+1	;       .word   inside11_lzsa	; (3)
	.byte	128+1	;       .word   inside12_lzsa	; (3)
	.byte	128+1	;       .word   inside13_lzsa	; (3)
	.byte	128+1	;       .word   inside14_lzsa	; (3)
	.byte	128+1	;       .word   inside15_lzsa	; (3)
	.byte	128+1	;       .word   inside16_lzsa	; (3)
	.byte	128+1	;       .word   inside17_lzsa	; (3)
	.byte	128+1	;       .word   inside18_lzsa	; (3)
	.byte	128+1	;       .word   inside19_lzsa	; (3)
	.byte	128+1	;       .word   inside20_lzsa	; (3)
	.byte	128+1	;       .word   inside21_lzsa	; (3)
	.byte	128+1	;       .word   inside22_lzsa	; (3)
	.byte	128+1	;       .word   inside23_lzsa	; (3)
	.byte	128+1	;       .word   inside24_lzsa	; (3)
	.byte	128+1	;       .word   inside25_lzsa	; (3)
	.byte	128+1	;       .word   inside26_lzsa	; (3)
	.byte	128+1	;       .word   inside27_lzsa	; (3)
	.byte	128+1	;       .word   inside28_lzsa	; (3)
	.byte	128+1	;       .word   inside29_lzsa	; (3)
	.byte	128+1	;       .word   inside30_lzsa	; (3)
	.byte	128+1	;       .word   inside31_lzsa	; (3)
	.byte	128+1	;       .word   inside32_lzsa	; (3)
	.byte	128+1	;       .word   inside33_lzsa	; (3)
	.byte	128+1	;       .word   inside34_lzsa	; (3)
	.byte	128+1	;       .word   inside35_lzsa	; (3)
	.byte	128+1	;       .word   inside36_lzsa	; (3)
	.byte	128+1	;       .word   inside37_lzsa	; (3)
	.byte	128+1	;       .word   inside38_lzsa	; (3)
	.byte	128+1	;       .word   inside39_lzsa	; (3)
	.byte	128+1	;       .word   inside40_lzsa	; (3)
	.byte	128+1	;       .word   inside41_lzsa	; (3)
	.byte	128+1	;       .word   inside42_lzsa	; (3)
	.byte	128+1	;       .word   inside43_lzsa	; (3)
	.byte	128+1	;       .word   inside44_lzsa	; (3)
	.byte	128+1	;       .word   inside45_lzsa	; (3)
	.byte	255                                     ; load to bg
	.word	lidclose_bg_lzsa			; this
	.byte	128+2	;       .word   lidclose01_lzsa	; (3)
	.byte	128+2	;       .word   lidclose02_lzsa	; (3)
	.byte	128+2	;       .word   lidclose03_lzsa	; (3)
	.byte	128+2	;       .word   lidclose04_lzsa	; (3)
	.byte	128+2	;       .word   lidclose05_lzsa	; (3)
	.byte	128+2	;       .word   lidclose06_lzsa	; (3)
	.byte	128+2	;       .word   lidclose07_lzsa	; (3)
	.byte	128+2	;       .word   lidclose08_lzsa	; (3)
	.byte	128+2	;       .word   lidclose09_lzsa	; (3)
	.byte	128+2	;       .word   lidclose10_lzsa	; (3)
	.byte	128+2	;       .word   lidclose11_lzsa	; (3)
	.byte	128+2	;       .word   lidclose12_lzsa	; (3)
	.byte	128+2	;       .word   lidclose13_lzsa	; (3)
	.byte	128+2	;       .word   lidclose14_lzsa	; (3)
	.byte	128+2	;       .word   lidclose15_lzsa	; (3)
	.byte	128+2	;       .word   lidclose16_lzsa	; (3)
	.byte	128+10	;       .word   lidclose17_lzsa	; (3)
	.byte	255                                     ; load to bg
	.word	door_open_bg_lzsa			; this
	.byte	128+3	;       .word  	door_open01_lzsa	; (3)
	.byte	128+3	;       .word  	door_open02_lzsa	; (3)
	.byte	128+3	;       .word  	door_open03_lzsa	; (3)
	.byte	128+3	;       .word  	door_open04_lzsa	; (3)
	.byte	128+3	;       .word  	door_open05_lzsa	; (3)
	.byte	128+3	;       .word  	door_open06_lzsa	; (3)
	.byte	128+3	;       .word  	door_open07_lzsa	; (3)
	.byte	128+3	;       .word  	door_open08_lzsa	; (3)
	.byte	128+3	;       .word  	door_open09_lzsa	; (3)
	.byte	128+3	;       .word  	door_open10_lzsa	; (3)
	.byte	128+3	;       .word  	door_open11_lzsa	; (3)
	.byte	128+3	;       .word  	door_open12_lzsa	; (3)
	.byte	128+3	;       .word  	door_open13_lzsa	; (3)
	.byte	255                                     ; load to bg
	.word	entrance_bg_lzsa			; this
	.byte	128+2	;       .word  	entering01_lzsa	; (2)
	.byte	128+2	;       .word  	entering02_lzsa	; (2)
	.byte	128+2	;       .word  	entering03_lzsa	; (2)
	.byte	128+2	;       .word  	entering04_lzsa	; (2)
	.byte	128+2	;       .word  	entering05_lzsa	; (2)
	.byte	128+2	;       .word  	entering06_lzsa	; (2)
	.byte	128+2	;       .word  	entering07_lzsa	; (2)
	.byte	128+2	;       .word  	entering08_lzsa	; (2)
	.byte	128+2	;       .word  	entering09_lzsa	; (2)
	.byte	128+2	;       .word  	entering10_lzsa	; (2)
	.byte	128+2	;       .word  	entering11_lzsa	; (2)
	.byte	128+2	;       .word  	entering12_lzsa	; (2)
	.byte	128+32	;       .word  	entering13_lzsa	; (16) pause a bit
	.byte	255                                     ; load to bg
	.word	arena_next_bg_lzsa			; this
	.byte	128+28	;       .word  	arena_next01_lzsa	; (14)
	.byte	128+14	;       .word  	arena_next02_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next03_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next04_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next05_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next06_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next07_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next08_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next09_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next10_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next11_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next12_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next13_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next14_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next15_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next16_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next17_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next18_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next19_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next20_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next21_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next22_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next23_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next24_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next25_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next26_lzsa	; (7)
	.byte	128+14	;       .word  	arena_next27_lzsa	; (7)

	.byte	0	; ending
