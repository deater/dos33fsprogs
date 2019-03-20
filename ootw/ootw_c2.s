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

	jsr	ootw_c2_intro

	;=======================
	; Enter the game
	;=======================

	jsr	ootw_cage

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
.include "ootw_c2_intro.s"
.include "physicist.s"
.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_putsprite.s"
.include "gr_putsprite_flipped.s"
.include "gr_offsets.s"
.include "gr_run_sequence.s"
.include "gr_overlay.s"
.include "random16.s"
.include "keyboard.s"

; room backgrounds
.include "ootw_graphics/cage/ootw_c2_cage.inc"
; sprites
.include "ootw_graphics/sprites/sprites_physicist.inc"
; intro
.include "ootw_graphics/l2intro/ootw_l2intro.inc"


