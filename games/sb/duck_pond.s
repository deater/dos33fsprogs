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

;	how show score?


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
	bit	PAGE0

	lda	#$0
	sta	DRAW_PAGE


	;===================
	; TITLE SCREEN
	;===================

title_screen:

	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1

	lda	#$C			; load at $c00

	jsr	full_decomp

	jsr	gr_copy_to_current

	bit	TEXTGR

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


	lda	#<main_data
	sta	ZX0_src
	lda	#>main_data
	sta	ZX0_src+1

	lda	#$C

	jsr	full_decomp

	jsr	gr_copy_to_current

	bit	FULLGR

	;===================
	; MAIN LOOP
	;===================


main_loop:

	; copy over background

	; draw arm animation

	; draw food

	; draw duck1

	; draw duck2

	; draw anvil/splash

	; draw score

	jsr	draw_score

	; move food

	; move arm

	; move anvil

	; move ducks

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
	bne	done_keyboard

	jsr	score_inc_d1

done_keyboard:

	; flip page


done_loop:

	jmp	main_loop

	.include	"zx02_optim.s"
	.include	"gr_copy.s"
	.include	"gr_offsets.s"

	.include	"gr_putsprite.s"

	.include	"duck_score.s"

title_data:
	.incbin "graphics/a2_duckpond_title.gr.zx02"

main_data:
	.incbin "graphics/a2_duckpond.gr.zx02"

	.include "graphics/num_sprites.inc"
