; Ootw for Apple II Lores -- Checkpoint2

; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"



ootw_c2:

	; Initialize some variables

	lda	#0
	sta	GAME_OVER
	sta	KICKING
	sta	CROUCHING

	lda     #22
	sta     PHYSICIST_Y
	lda     #20
	sta     PHYSICIST_X

	lda     #1
	sta     DIRECTION

	lda	#40
	sta	BOULDER_Y

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
.include "physicist.s"
.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_putsprite.s"
.include "gr_putsprite_flipped.s"
.include "gr_offsets.s"
.include "random16.s"
.include "keyboard.s"

; room backgrounds
.include "ootw_c2_cage.inc"
; sprites
.include "sprites_physicist.inc"
; cutscenes

