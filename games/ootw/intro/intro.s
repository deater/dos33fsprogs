;==========================
; OOTW -- The Famous Intro
;==========================

.include "../zp.inc"
.include "../hardware.inc"

intro:
	lda	#0
	sta	INTRO_REPEAT		; by default, don't repeat
	bit	KEYRESET		; clear keyboard buffer

repeat_intro:
	;===========================
	; Enable graphics

	bit	LORES			; 40x40 lo-res
	bit	SET_GR
	bit	FULLGR			; full screen

	;===========================
	; Setup pages

	lda	#4			; page to draw
	sta	DRAW_PAGE
	lda	#0			; page to display
	sta	DISP_PAGE

;	jmp	tunnel1			; debug, skip ahead

	;===============================
	; Opening scene with car

	jsr	intro_01_building

	;===============================
	; Walking to door

	jsr	intro_02_outer_door

	;===============================
	; Elevator

	jsr	intro_03_elevator

	;===============================
	; Keypad

	jsr	intro_04_keypad

	;===============================
	; Scanner

	jsr	intro_05_scanner

	;===============================
	; Nuclear Physics, part 1

	jsr	intro_06_console_part1

	;===============================
	; Drinking some Soda

	jsr	intro_07_soda

	;===============================
	; Nuclear Physics, part 2

	jsr	intro_06_console_part2

	;===============================
	; Lightning outside

	jsr	intro_08_lightning

	;===============================
	; Down in the tunnels

	jsr	intro_09_tunnel

	;===============================
	; Zapped

	jsr	intro_10_gone


	; see if R pressed, if so, repeat
	; otherwise, return and indicate we want to start the game

	lda	KEYPRESS
	bpl	check_repeat	; if no keypress, jump ahead

	and	#$7f		; clear high bit

	cmp	#'R'
	bne	check_repeat

	lda	INTRO_REPEAT
	eor	#$1
	sta	INTRO_REPEAT


check_repeat:
	bit	KEYRESET	; reset keyboard strobe
	lda	INTRO_REPEAT
	beq	done_intro

	jmp	repeat_intro

done_intro:
	lda	#1		; start game
	sta	WHICH_LOAD

	rts


.include "../gr_pageflip.s"
;.include "../gr_unrle.s"
;.include "../lz4_decode.s"
.include "../decompress_fast_v2.s"
.include "../gr_copy.s"
.include "../gr_offsets.s"
.include "../gr_overlay.s"
.include "../gr_vlin.s"
.include "../gr_plot.s"
.include "../gr_fast_clear.s"
.include "../gr_putsprite.s"
.include "../text_print.s"
.include "gr_run_sequence.s"


	;========================
	; load all the sub-parts
	;========================

	.include "intro_01_building.s"
	.include "intro_02_outer_door.s"
	.include "intro_03_elevator.s"
	.include "intro_04_keypad.s"
	.include "intro_05_scanner.s"
	.include "intro_06_console.s"
	.include "intro_07_soda.s"
	.include "intro_08_lightning.s"
	.include "intro_09_tunnel.s"
	.include "intro_10_gone.s"
