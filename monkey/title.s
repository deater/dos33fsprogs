; Monkey Title

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

title_start:
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

title_loop:

	;====================================
	; load LF logo
	;====================================

	jsr	gr_copy_to_current

logo_loop:

;	lda	GUYBRUSH_X
;	sta	XPOS
;	lda	GUYBRUSH_Y
;	sta	YPOS

;	lda	#<guybrush_back_sprite
;	sta	INL
;	lda	#>guybrush_back_sprite
;	sta	INH

;	jsr	put_sprite_crop


;	jsr	page_flip



	;====================================
	; inc frame count
	;====================================

	inc	FRAMEL
	bne	room_frame_no_oflo
	inc	FRAMEH
room_frame_no_oflo:


	jsr	wait_until_keypressed


	;==========================
	; load main program
	;==========================

	lda	#LOAD_MONKEY
	sta	WHICH_LOAD

	rts

	;==========================
	; includes
	;==========================

	; level graphics
;	.include	"graphics/graphics.inc"

	; level data
;	.include	"leveldata_monkey.inc"


;	.include	"end_level.s"
;	.include	"text_print.s"
	.include	"gr_offsets.s"
;	.include	"gr_fast_clear.s"
;	.include	"keyboard.s"
	.include	"gr_copy.s"
;	.include	"gr_putsprite_crop.s"
;	.include	"joystick.s"
;	.include	"gr_pageflip.s"
;	.include	"decompress_fast_v2.s"
;	.include	"draw_pointer.s"
;	.include	"common_sprites.inc"
;	.include	"guy.brush"

;	.include	"monkey_actions.s"
;	.include	"update_bottom.s"

wait_until_keypressed:
	lda	KEYPRESS
	bmi	wait_until_keypressed

	bit	KEYRESET

	rts
