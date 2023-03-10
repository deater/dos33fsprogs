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
	; Load graphics
	;===================
load_loop:

	;=============================


	;==========================
	; Load Image
	;===========================

load_image:

	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1

	lda	#$C			; load at $c00

	jsr	full_decomp

	jsr	gr_copy_to_current


wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

which_ok:

	lda	#<main_data
	sta	ZX0_src
	lda	#>main_data
	sta	ZX0_src+1

	lda	#$C

	jsr	full_decomp

	jsr	gr_copy_to_current

wait_until_keypress2:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress2			; 3
	bit	KEYRESET	; clear the keyboard buffer

	jmp	load_loop




	.include	"zx02_optim.s"
	.include	"gr_copy.s"
	.include	"gr_offsets.s"

title_data:
	.incbin "graphics/a2_duckpond_title.gr.zx02"

main_data:
	.incbin "graphics/a2_duckpond.gr.zx02"
