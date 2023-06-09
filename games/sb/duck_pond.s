; gr duck pond
;
; by deater (Vince Weaver) <vince@deater.net>


; todo
;	videlectrix/ f to feed message
;	F feeds
;	A anvil (what happens when land on duck)
;	Y drain pond
;	ESC exit
;	S spawn new duck
;	N night (twilight?)
;	J jump in pond

; D/G throw short vs long?

;	replace "bread" with "food"


;123456789012345678901234567890123456789
;         *** VIDELECTRIX ***
;
;      PRESS "F"  TO THROW BREAD
;       PRESS SPACEBAR TO START

.include "zp.inc"
.include "hardware.inc"


duck_pond:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	LORES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#$4
	sta	DRAW_PAGE

	lda	#$0
	sta	FRAME
	sta	FRAMEH
	sta	DISP_PAGE

	;===================
	; TITLE SCREEN
	;===================

title_screen:

	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1

	lda	#$c			; load at $C00

	jsr	full_decomp

	jsr	gr_copy_to_current

	bit	TEXTGR

	jsr	page_flip

wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer


	;===================
	; INIT GAME
	;===================
init_game:

	lda	#0
	sta	D1_SCORE
	sta	D1_SCORE_H
	sta	D2_SCORE
	sta	D2_SCORE_H

	lda	#1
	sta	D1_STATE
	sta	D2_STATE

	lda	#10
	sta	D1_XPOS
	sta	D1_YPOS

	lda	#14
	sta	D2_XPOS
	sta	D2_YPOS

	lda	#$FF
	sta	D1_XSPEED
	sta	D1_YSPEED
	sta	D2_XSPEED
	sta	D2_YSPEED

	; load background

	lda	#<main_data
	sta	ZX0_src
	lda	#>main_data
	sta	ZX0_src+1

	lda	#$c

	jsr	full_decomp

	jsr	gr_copy_to_current

	bit	FULLGR

	;===================
	; MAIN LOOP
	;===================


main_loop:
	jsr	gr_copy_to_current

	; copy over background

	; draw arm animation

	; draw food

	; draw ducks

	jsr	draw_duck1
	jsr	draw_duck2

	; draw anvil/splash

	; draw score

	jsr	draw_score


	; flip page

	jsr	page_flip

	; move food

	; move arm

	; move anvil

	; move ducks

	jsr	move_ducks

	; drain water

	; check keyboard

wait_until_keypress2:
	lda	KEYPRESS				; 4
	bpl	done_loop

	bit	KEYRESET	; clear the keyboard buffer

	and	#$7f		; clear high bit
	cmp	#' '		; don't lose space
	beq	was_space
	and	#$df		; convert lowercase to uppercase
was_space:

check_bracket:
	cmp	#'S'
	bne	check_escape

	jsr	score_inc_d1

	lda	#$ff
	sta	D1_XSPEED
	jmp	done_keyboard

check_escape:
	cmp	#27
	bne	done_keyboard

	lda	#0
	sta	WHICH_LOAD
	rts

done_keyboard:

	; increment frame

	inc	FRAME
	bne	frame_noflo
	inc	FRAMEH
frame_noflo:


done_loop:

	jmp	main_loop

	.include	"zx02_optim.s"
	.include	"gr_copy.s"
	.include	"gr_offsets.s"

	.include	"gr_putsprite_mask.s"
	.include	"gr_pageflip.s"

	.include	"duck_score.s"
	.include	"draw_ducks.s"
	.include	"move_ducks.s"

title_data:
	.incbin "duck_graphics/a2_duckpond_title.gr.zx02"

main_data:
	.incbin "duck_graphics/a2_duckpond.gr.zx02"

	.include "duck_graphics/num_sprites.inc"
	.include "duck_graphics/duck_sprites.inc"
