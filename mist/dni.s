; D'NI -- deep beneath New Mexico

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

dni_start:
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
	sta	ANIMATE_FRAME

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y


	; set up initial location

	jsr	change_location

	lda	#1
	sta	CURSOR_VISIBLE		; visible at first



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

	; things always happening
	lda	LOCATION

done_foreground:
	;====================================
	; handle animations
	;====================================

	; things only happening when animating

	lda	ANIMATE_FRAME
	beq	nothing_special

	lda	LOCATION

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
	.include	"graphics_dni/dni_graphics.inc"

	; puzzles

	; linking books

	; books

	; level data
	.include	"leveldata_dni.inc"



