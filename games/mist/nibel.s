; The third level of Channely Wood

; Nibelheim, home in the clouds

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

nibel_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

	;=================
	; set up location
	;=================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H


	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	; set up initial location

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
	; handle special-case forground logic
	;====================================

	lda	LOCATION
	cmp	#NIBEL_BLUE_ROOM
	beq	fg_draw_blue_page
	cmp	#NIBEL_RED_TABLE_OPEN
	beq	fg_draw_red_page
	cmp	#NIBEL_BLUE_HOUSE_VIEWER
	beq	animate_viewer
	cmp	#NIBEL_SHACK_ENTRANCE
	beq	animate_projector
	cmp	#NIBEL_SHACK_CENTER
	beq	animate_trap
	cmp	#NIBEL_BLUE_PATH_2P25
	beq	animate_gate_s
	cmp	#NIBEL_BLUE_PATH_2P5
	beq	animate_gate_n

	jmp	nothing_special

fg_draw_blue_page:
	jsr	draw_blue_page
	jmp	nothing_special

fg_draw_red_page:
	jsr	draw_red_page
	jmp	nothing_special

animate_projector:
	jsr	draw_projection
	jmp	nothing_special

animate_trap:
	jsr	draw_trap
	jmp	nothing_special

animate_gate_s:
	jsr	update_gate_s
	jmp	nothing_special

animate_gate_n:
	jsr	update_gate_n
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

	lda	current_button_animation
	sta	OUTL
	lda	current_button_animation+1
	sta	OUTH
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
	.include	"graphics_nibel/nibel_graphics.inc"

	; puzzles
	.include	"nibel_switches.s"

	; level data
	.include	"leveldata_nibel.inc"

	; book pages
	.include	"handle_pages.s"

