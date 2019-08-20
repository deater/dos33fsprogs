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
	sta	ON_ELEVATOR
	sta	HAVE_GUN

	;==========================
	; Handle Underwater Arrival
	;==========================

	jsr	ootw_c1_arrival

	lda	GAME_OVER
	bmi	end_c1


	;==========================
	; Exit the Pool
	;==========================

	jsr	exit_pool


	; Initialize some variables

	lda	#0
	sta	GAME_OVER
	sta	EQUAKE_PROGRESS
	sta	EARTH_OFFSET
	sta	PHYSICIST_STATE
	sta	WHICH_CAVE
	sta	BEAST_OUT
	sta	ON_ELEVATOR


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
end_c1:
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

; rooms
.include "ootw_c1_arrival.s"
.include "ootw_c1_rope.s"
.include "ootw_c1_pool.s"
.include "ootw_c1_cavern.s"
.include "ootw_c1_mesa.s"

; movement
.include "physicist.s"
.include "ootw_c1_sluggy.s"
.include "ootw_c1_beast.s"
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
.include "gr_hlin.s"
.include "random16.s"
.include "keyboard.s"
.include "gr_overlay.s"
.include "gr_putsprite_crop.s"

; room backgrounds
.include "ootw_graphics/l1pool/ootw_pool.inc"
.include "ootw_graphics/l1caves/ootw_cavern.inc"
.include "ootw_graphics/l1caves/ootw_cavern2.inc"
.include "ootw_graphics/l1caves/ootw_cavern3.inc"
.include "ootw_graphics/l1rope/ootw_rope.inc"
.include "ootw_graphics/l1rope/ootw_swing.inc"
.include "ootw_graphics/l1underwater/ootw_underwater.inc"
; sprites
.include "ootw_graphics/sprites/l1_background.inc"
.include "ootw_graphics/sprites/physicist.inc"
.include "ootw_graphics/sprites/physicist_l1_swim.inc"
.include "ootw_graphics/sprites/slugs.inc"
.include "ootw_graphics/sprites/beast.inc"
; cutscene data
.include "ootw_graphics/l1end/ootw_l1end.inc"
.include "ootw_graphics/l1end_scenes/ootw_beast_end.inc"
.include "ootw_graphics/l1end_scenes/ootw_slug_end.inc"
.include "ootw_graphics/l1end_scenes/ootw_beast_intro.inc"
