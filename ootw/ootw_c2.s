; Ootw for Apple II Lores -- Checkpoint2

; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"



ootw_c2:

	; Initialize some variables

	lda	#0
	sta	GAME_OVER
	sta	PHYSICIST_STATE

	lda     #22
	sta     PHYSICIST_Y
	lda     #20
	sta     PHYSICIST_X

	lda     #1
	sta     DIRECTION

	;=======================
	; Run the intro
	;=======================

;	jsr	ootw_c2_intro

	;=======================
	; Enter the game
	;=======================

	jsr	ootw_cage

	;=======================
	; Start Level After Cage
	;=======================

	lda     #1
	sta     DIRECTION
	lda     #22
	sta     PHYSICIST_Y
	lda     #24
	sta     PHYSICIST_X
	lda     #0
	sta     PHYSICIST_STATE
	sta     WHICH_JAIL

	;=========================
	; c2_new_room
	;=========================
	; enter new room on level2

c2_new_room:
	lda	#0
	sta	GAME_OVER

	lda	WHICH_JAIL
	cmp	#4
	bcs	elevator_room		; bge
jail_room:
	jsr	ootw_jail
	jmp	c2_check_done

elevator_room:
	cmp	#8
	bcs	multilevel_room		; bge
	jsr	ootw_elevator
	jmp	c2_check_done

multilevel_room:
	; FIXME



c2_check_done:
	lda	GAME_OVER
	cmp	#$ff
	beq	quit_level

	; only exit if done level
	; FIXME: or quit pressed?

	lda	WHICH_JAIL
	cmp	#11
	bne	c2_new_room


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

	jmp	ootw_c2


end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: RAGE",0

.include "ootw_c2_cage.s"
.include "ootw_c2_jail.s"
.include "ootw_c2_elevator.s"
.include "ootw_c2_intro.s"
.include "physicist.s"
.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_putsprite.s"
.include "gr_putsprite_flipped.s"
.include "gr_putsprite_crop.s"
.include "gr_offsets.s"
.include "gr_run_sequence.s"
.include "gr_overlay.s"
.include "random16.s"
.include "keyboard.s"

; room backgrounds
.include "ootw_graphics/cage/ootw_c2_cage.inc"
.include "ootw_graphics/l2jail/ootw_c2_jail.inc"
; sprites
.include "ootw_graphics/sprites/sprites_physicist.inc"
; intro
.include "ootw_graphics/l2intro/ootw_l2intro.inc"


