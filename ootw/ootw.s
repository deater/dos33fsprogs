; Ootw Level 1 for Apple II Lores

; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"



ootw:
	; Initialize some variables

	lda	#0
	sta	GAME_OVER
	sta	EQUAKE_PROGRESS
	sta	EARTH_OFFSET
	sta	PHYSICIST_STATE
	sta	WHICH_CAVE
	sta	BEAST_OUT

	lda	#1
	sta	BEFORE_SWING

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
	lda	GAME_OVER		; see why we quit
	cmp	#$ff
	beq	l1_quit_or_died

	;====================
	; go to next level
l1_defeated:
	lda	#2			; go to next level
	sta	WHICH_LOAD
	rts

	;========================
	; print death message
	; then restart
l1_quit_or_died:
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
.include "gr_putsprite_flipped.s"
.include "gr_offsets.s"
.include "random16.s"
.include "keyboard.s"
.include "gr_overlay.s"


; room backgrounds
.include "ootw_graphics/pool/ootw_pool.inc"
.include "ootw_graphics/caves/ootw_cavern.inc"
.include "ootw_graphics/caves/ootw_cavern2.inc"
.include "ootw_graphics/caves/ootw_cavern3.inc"
.include "ootw_graphics/rope/ootw_rope.inc"
.include "ootw_graphics/rope/ootw_swing.inc"
.include "ootw_graphics/underwater/ootw_underwater.inc"
; sprites
.include "sprites_ootw.inc"
.include "ootw_graphics/sprites/sprites_physicist.inc"
.include "sprites_slugs.inc"
.include "sprites_beast.inc"
; cutscenes
.include "cutscene_slug.s"
.include "cutscene_beast.s"
.include "ootw_graphics/endl1/ootw_l1end.inc"
