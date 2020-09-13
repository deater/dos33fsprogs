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
;	cmp	#NIBEL_BLUE_ROOM
;	beq	fg_draw_blue_page
;	cmp	#NIBEL_RED_TABLE_OPEN
;	beq	fg_draw_red_page
;	cmp	#NIBEL_BLUE_HOUSE_VIEWER
;	beq	animate_viewer
;	cmp	#NIBEL_SHACK_ENTRANCE
;	beq	animate_projector
;	cmp	#NIBEL_SHACK_CENTER
;	beq	animate_trap
;	cmp	#NIBEL_BLUE_PATH_2P25
;	beq	animate_gate_s
;	cmp	#NIBEL_BLUE_PATH_2P5
;	beq	animate_gate_n

	jmp	nothing_special

fg_draw_blue_page:
;	jsr	draw_blue_page
	jmp	nothing_special

fg_draw_red_page:
;	jsr	draw_red_page
	jmp	nothing_special

animate_projector:
;	jsr	draw_projection
	jmp	nothing_special

animate_trap:
;	jsr	draw_trap
	jmp	nothing_special

animate_gate_s:
;	jsr	update_gate_s
	jmp	nothing_special

animate_gate_n:
;	jsr	update_gate_n
	jmp	nothing_special

animate_viewer:
	lda	ANIMATE_FRAME
	beq	nothing_special
	cmp	#6
	beq	viewer_done

	sec
	sbc	#1
	asl
	tay

;	lda	current_button_animation
;	sta	OUTL
;	lda	current_button_animation+1
;	sta	OUTH
	lda	(OUTL),Y
	sta	INL
	iny
	lda	(OUTL),Y
	sta	INH

	lda	#14
	sta	XPOS

	lda	#10
	sta	YPOS
	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$f
	bne	nothing_special

	lda	ANIMATE_FRAME
	cmp	#5
	bne	short_frame

long_frame:
	inc	LONG_FRAME
	lda	LONG_FRAME
	cmp	#30
	bne	nothing_special

short_frame:
	inc	ANIMATE_FRAME

	lda	#0
	sta	LONG_FRAME
	jmp	nothing_special


viewer_done:
	lda	#0
	sta	ANIMATE_FRAME

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






	;====================================
	;====================================
	; update bottom of screen
	;====================================
	;====================================
update_bottom:

	ldx	#0

bottom_loop:
	lda	bottom_strings,X
	sta	OUTL
	lda	bottom_strings+1,X
	sta	OUTH

	jsr	move_and_print

	inx
	inx

	cpx	#18
	bne	bottom_loop

	rts

;0123456789012345678901234567890123456789
;
;GIVE  PICK UP  USE
;OPEN  LOOK AT  PUSH
;CLOSE TALK TO  PULL

bottom_strings:
.word	bottom_give
.word	bottom_open
.word	bottom_close
.word	bottom_pick_up
.word	bottom_look_at
.word	bottom_talk_to
.word	bottom_use
.word	bottom_push
.word	bottom_pull

bottom_give:	.byte 0,21,"GIVE ",0
bottom_open:	.byte 0,22,"OPEN ",0
bottom_close:	.byte 0,23,"CLOSE",0
bottom_pick_up:	.byte 6,21,"PICK UP",0
bottom_look_at:	.byte 6,22,"LOOK AT",0
bottom_talk_to:	.byte 6,23,"TALK TO",0
bottom_use:	.byte 15,21,"USE ",0
bottom_push:	.byte 15,22,"PUSH",0
bottom_pull:	.byte 15,23,"PULL",0








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
