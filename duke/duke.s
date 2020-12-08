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

	;=====================
	; init vars
	;=====================

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	DISP_PAGE
	sta	JOYSTICK_ENABLED
	sta	DUKE_WALKING
	sta	DUKE_JUMPING
	sta	LEVEL_OVER
	sta	LASER_OUT

	lda	#4
	sta	DRAW_PAGE

	lda	#18
	sta	DUKE_X
	lda	#20
	sta	DUKE_Y
	lda	#1
	sta	DUKE_DIRECTION


	;====================================
	; load duke bg
	;====================================

        lda	#<duke1_bg_lzsa
	sta	LZSA_SRC_LO
        lda	#>duke1_bg_lzsa
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

	; draw laser

	jsr	draw_laser

	; draw duke

	jsr	draw_duke

	; draw a status bar

	jsr	draw_status_bar

	jsr	page_flip

	jsr	handle_keypress

	jsr	move_duke

	jsr	move_laser

	;===========================
	; check end of level
	;===========================

	lda	LEVEL_OVER
	bpl	do_duke_loop

	jmp	done_with_duke


do_duke_loop:

	; delay
;	lda	#200
;	jsr	WAIT

	jmp	duke_loop


done_with_duke:
	bit	KEYRESET	; clear keypress

	jmp	done_with_duke

	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics/duke_graphics.inc"

	.include	"text_print.s"
	.include	"gr_offsets.s"
;	.include	"gr_fast_clear.s"
	.include	"gr_copy.s"
	.include	"gr_pageflip.s"
	.include	"gr_putsprite_crop.s"
	.include	"decompress_fast_v2.s"

	.include	"status_bar.s"
	.include	"keyboard.s"
	.include	"joystick.s"

	.include	"draw_duke.s"
	.include	"handle_laser.s"


