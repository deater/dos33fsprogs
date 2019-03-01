; Ootw for Apple II Lores

; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"



ootw:
	; Initialize some variables

	lda	#0
	sta	GAME_OVER
	sta	EQUAKE_PROGRESS
	sta	EARTH_OFFSET
	sta	KICKING
	sta	CROUCHING
	sta	WHICH_CAVE
	sta	BEAST_OUT

	lda     #22
	sta     PHYSICIST_Y
	lda     #20
	sta     PHYSICIST_X

	lda     #1
	sta     DIRECTION

	lda	#40
	sta	BOULDER_Y

	;=======================
	; Initialize the slugs
	;=======================

	jsr	init_slugs

	;=======================
	; Enter the game
	;=======================

	jsr	ootw_pool

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

	jmp	ootw


end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: IH8S",0

.include "ootw_rope.s"
.include "ootw_pool.s"
.include "ootw_cavern.s"
.include "ootw_mesa.s"
.include "physicist.s"
.include "sluggy.s"
.include "earthquake.s"
.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_make_quake.s"
.include "gr_putsprite.s"
.include "gr_offsets.s"
.include "random16.s"
.include "keyboard.s"
; room backgrounds
.include "ootw_pool.inc"
.include "ootw_cavern.inc"
.include "ootw_cavern2.inc"
.include "ootw_cavern3.inc"
.include "ootw_rope.inc"
.include "ootw_underwater.inc"
; sprites
.include "sprites_ootw.inc"
.include "sprites_physicist.inc"
.include "sprites_slugs.inc"
.include "sprites_beast.inc"
; cutscenes
.include "cutscene_slug.s"
.include "cutscene_beast.s"
