; Duke PoC

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

duke_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	TEXTGR

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	DISP_PAGE

	lda	#4
	sta	DRAW_PAGE



	;====================================
	; load duke bg
	;====================================

        lda	#<duke_lzsa
	sta	LZSA_SRC_LO
        lda	#>duke_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	;====================================
	;====================================
	; Main LOGO loop
	;====================================
	;====================================

duke_loop:

	; copy over background

	jsr	gr_copy_to_current

	jsr	normal_text
	lda	#<help_string
	sta	OUTL
	lda	#>help_string
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	jsr	inverse_text
	jsr	move_and_print

	jsr	page_flip



	; early escape if keypressed
	lda	KEYPRESS
	bpl	do_duke_loop

	jmp	done_with_duke


do_duke_loop:

	; delay
	lda	#200
	jsr	WAIT

	jmp	duke_loop


done_with_duke:
	bit	KEYRESET	; clear keypress

	jmp	done_with_duke

	;==========================
	; includes
	;==========================

	; level graphics
	.include	"duke.inc"

	.include	"text_print.s"
	.include	"gr_offsets.s"
;	.include	"gr_fast_clear.s"
	.include	"gr_copy.s"
	.include	"gr_pageflip.s"
	.include	"decompress_fast_v2.s"



help_string:
	.byte 11,20,"PRESS ^H FOR HELP",0

score_string:
	;           012456789012345678901234567890123456789
	.byte 0,22,"SCORE   HEALTH   FIREPOWER    INVENTORY",0
	.byte 0,23,"00010  XXXXXXXX  =-=-                  ",0
	.byte 7,23,"        ",0
