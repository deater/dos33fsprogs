; Riven -- Atrus' Journal

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk06_defines.inc"

atrus_journal:

	;===================
	; init screen
	;===================

	bit	KEYRESET

	bit	SET_TEXT
	bit	PAGE1
	bit	LORES
	bit	FULLGR

	;========================
	; set up location
	;========================

	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER

	lda	#0
	sta	JOYSTICK_ENABLED
	sta	UPDATE_POINTER

	lda	#1
	sta	CURSOR_VISIBLE

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y




	;===================================
	; init
	;===================================

	; clear screen to inverse

	lda	#' '
	sta	clear_value_smc+1
        ldx     #0
	jsr	clear_bottom_loop_outer

	jsr	set_inverse

	; print the title screen text
	lda	#<page3
	sta	OUTL
	lda	#>page3
	sta	OUTH
	jsr	move_and_print_list


game_loop:



	jmp	game_loop

really_exit:

	rts


	;==========================
	; includes
	;==========================

page3:
.byte 0,0,"87.6.20",0
.byte 0,1," ",0
.byte 0,2,"I think I have the solution.",0
.byte 0,3,"Why it did not occur to me sooner,",0
.byte 0,4,"I do not know, unless the idea of",0
.byte 0,5,"it had been pushed out with the",0
.byte 0,6,"thought of my sons.",0
.byte 0,7," ",0
.byte 0,8,"A Prison Book!",0
.byte 0,9," ",0
.byte 0,10,"Surely this is well thought out and",0
.byte 0,11,"could not conceivably lead to any",0
.byte 0,12,"continuity issues in the future.",0,$FF
