; Ootw for Apple II Lores -- Checkpoint2

; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"



ootw_c2:

	; Initialize some variables

	;=======================
	; Run the intro
	;=======================

	jsr	ootw_c2_intro

	;=======================
	; Enter the game
	;=======================
ootw_c2_restart:

	jsr	ootw_cage
	lda	GAME_OVER
	cmp	#$ff
	beq	quit_level

	;=======================
	; Start Level After Cage
	;=======================

	jsr	ootw_jail_init

	;=========================
	; c2_new_room
	;=========================
	; enter new room on level2

c2_new_room:
	lda	#0
	sta	GAME_OVER

	lda	WHICH_JAIL
	cmp	#7
	bcs	elevator_room		; bge
jail_room:
	jsr	ootw_jail
	jmp	c2_check_done

elevator_room:
	jsr	ootw_elevator

c2_check_done:
	lda	GAME_OVER
	cmp	#$ff
	beq	quit_level

	cmp	#77
	bne	c2_new_room

;=========================
; end of level
;=========================
	lda	#3
	sta	WHICH_LOAD
	rts

;===========================
; quit_level
;===========================

quit_level:
	jsr	TEXT
	jsr	HOME
	lda	KEYRESET		; clear strobe

	lda	#0
	sta	DRAW_PAGE

	lda	#<end_message
	sta	OUTL
	lda	#>end_message
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

wait_loop:
	lda	KEYPRESS
	bpl	wait_loop

	lda	KEYRESET		; clear strobe

	lda	#0
	sta	GAME_OVER

	jmp	ootw_c2_restart


end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: RAGE",0

.include "ootw_c2_cage.s"
.include "ootw_c2_jail.s"
.include "ootw_c2_elevator.s"
.include "ootw_c2_intro.s"
.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_copy_offset.s"
.include "gr_putsprite.s"
.include "gr_putsprite_flipped.s"
.include "gr_putsprite_crop.s"
.include "gr_offsets.s"
.include "gr_offsets_hl.s"
.include "gr_run_sequence.s"
.include "gr_overlay.s"
.include "gr_vlin.s"
.include "gr_hlin.s"
;.include "random16.s"
.include "keyboard.s"

.include "physicist.s"
.include "alien.s"
.include "friend.s"

.include "gun.s"
.include "blast.s"
.include "laser.s"
.include "alien_laser.s"
.include "shield.s"
.include "door.s"
.include "collision.s"

; background miners
.include "ootw_c2_miners.s"

; room backgrounds
.include "ootw_graphics/l2cage/ootw_c2_cage.inc"
.include "ootw_graphics/l2jail/ootw_c2_jail.inc"
; sprites
.include "ootw_graphics/sprites/physicist.inc"
.include "ootw_graphics/sprites/alien.inc"
.include "ootw_graphics/sprites/friend.inc"
; intro
.include "ootw_graphics/l2intro/ootw_l2intro.inc"
; city movie
.include "ootw_graphics/l2city/city_movie.inc"
; laser movie
.include "ootw_graphics/l2laser/ootw_c2_laser.inc"

.include "audio.s"

