; Ootw for Apple II Lores -- Checkpoint4 (the City)

; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"



ootw_c4:

	; Initialize some variables

	;=======================
	; Run the "intro"
	;=======================
	; just us falling?

ootw_c4_restart:

	jsr	ootw_city_init

	;=========================
	; c4_new_room
	;=========================
	; enter new room on level4

c4_new_room:
	lda	#0
	sta	GAME_OVER

	jsr	ootw_city

c4_check_done:
	lda	GAME_OVER
	cmp	#$ff
	beq	quit_level

	;====================
	; go to next level
l4_defeated:
	lda	WHICH_ROOM
	cmp	#5
	bne	c4_new_room

	lda	#5
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

	jmp	ootw_c4_restart


end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: RCHG",0

.include "ootw_c4_city.s"
.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_hlin.s"
.include "gr_twoscreen_scroll.s"
.include "gr_putsprite.s"
.include "gr_putsprite_flipped.s"
.include "gr_putsprite_crop.s"
.include "gr_offsets.s"
;.include "random16.s"
.include "keyboard.s"

.include "physicist.s"
.include "alien.s"

.include "door.s"
.include "charger.s"
.include "gun.s"
.include "laser.s"
.include "shield.s"
.include "blast.s"
.include "collision.s"
.include "dummy_friend.s"
.include "alien_laser.s"

.include "ootw_c4_action.s"

; room backgrounds
.include "ootw_graphics/l4city/ootw_c4_city.inc"
; sprites
.include "ootw_graphics/sprites/physicist.inc"
.include "ootw_graphics/sprites/alien.inc"


