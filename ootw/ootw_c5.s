; Ootw for Apple II Lores
; Checkpoint5 (accidentally in a coal mine it was found)

; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


ootw_c5:

	; Initialize some variables

ootw_c5_restart:

	jsr	ootw_cave_init

	;=========================
	; c5_new_cave
	;=========================
	; enter new cave on level5

c5_new_cave:
	lda	#0
	sta	GAME_OVER

	jsr	ootw_cave

c5_check_done:
	lda	GAME_OVER
	cmp	#$ff
	beq	quit_level

	; only exit if done level
	; FIXME: or quit pressed?

	lda	WHICH_JAIL
	cmp	#11
	bne	c5_new_cave


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

	jmp	ootw_c5_restart


end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: CAVE",0

.include "ootw_c5_cave.s"
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
.include "gr_hlin.s"
;.include "random16.s"
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
.include "ootw_graphics/l5cave/ootw_c5_cave.inc"
; sprites
.include "ootw_graphics/sprites/physicist.inc"
.include "ootw_graphics/sprites/alien.inc"



; "NOW GO BACK TO ANOTHER EARTH"
