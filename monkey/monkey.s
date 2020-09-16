; Monkey Monkey

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

monkey_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	TEXTGR

	;=================
	; set up location
	;=================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H

	lda	#29
	sta	GUYBRUSH_X
	lda	#18
	sta	GUYBRUSH_Y


	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	; set up initial location

	lda	#MONKEY_LOOKOUT
	sta	LOCATION

	jsr	change_location

	lda	#1
	sta	CURSOR_VISIBLE		; visible at first

	lda	#0
	sta	ANIMATE_FRAME

	lda	#VERB_WALK
	sta	CURRENT_VERB

game_loop:
	;=================
	; reset things
	;=================

	lda	#0
	sta	IN_SPECIAL
	sta	IN_RIGHT
	sta	IN_LEFT

	;====================================
	; copy background to current page
	;====================================

	jsr	gr_copy_to_current

	;====================================
	; draw background sprites
	;====================================

	lda	LOCATION
;	cmp	#NIBEL_BLUE_PATH_2P5
;	beq	animate_gate_n

	jmp	nothing_special



animate_gate_n:
;	jsr	update_gate_n
	jmp	nothing_special


nothing_special:

	;====================================
	; draw guybrush
	;====================================

	lda	GUYBRUSH_X
	sta	XPOS
	lda	GUYBRUSH_Y
	sta	YPOS

	lda	#<guybrush_back_sprite
	sta	INL
	lda	#>guybrush_back_sprite
	sta	INH

	jsr	put_sprite_crop


	;====================================
	; draw foreground sprites
	;====================================


	;====================================
	; what are we pointing too
	;====================================

	jsr	where_do_we_point

	;====================================
	; update bottom bar
	;====================================

	jsr	update_bottom

	;====================================
	; draw pointer
	;====================================

	jsr	draw_pointer

	;====================================
	; page flip
	;====================================

	jsr	page_flip

	;====================================
	; handle keypress/joystick
	;====================================

	jsr	handle_keypress

	;====================================
	; inc frame count
	;====================================

	inc	FRAMEL
	bne	room_frame_no_oflo
	inc	FRAMEH
room_frame_no_oflo:

	;====================================
	; check level over
	;====================================

	lda	LEVEL_OVER
	bne	really_exit
	jmp	game_loop

really_exit:
	jmp	end_level



	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics/graphics.inc"

	; level data
	.include	"leveldata_monkey.inc"


	.include	"end_level.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
	.include	"keyboard.s"
	.include	"gr_copy.s"
	.include	"gr_putsprite_crop.s"
	.include	"joystick.s"
	.include	"gr_pageflip.s"
	.include	"decompress_fast_v2.s"
	.include	"draw_pointer.s"
	.include	"common_sprites.inc"
	.include	"guy.brush"

	.include	"monkey_actions.s"
	.include	"update_bottom.s"
