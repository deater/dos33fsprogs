; XMAS 2023

.include "hardware.inc"
.include "zp.inc"
.include "qload.inc"
.include "music.inc"


xmas_main:

	;======================================
	; init
	;======================================

	lda	#$00
	sta	DRAW_PAGE
	sta	clear_all_color+1

	lda	#$04
	sta	DRAW_PAGE
	jsr	clear_all

	;======================================
	; draw opening scene
	;======================================


	;======================================
	; plasma tree
	;======================================

	jsr	plasma_tree


finished:
	jmp	finished


.include "wait_keypress.s"
.include "irq_wait.s"

.include "plasma_tree.s"
