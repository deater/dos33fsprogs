; Joystick Test

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
;	.include "common_defines.inc"
;	.include "common_routines.inc"

js_test:

	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	LORES
	bit	FULLGR

	lda	#0
	sta	DRAW_PAGE

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	lda	#0
	sta	LEVEL_OVER

	;============================
	; set up initial location

;	lda	#TITLE_BOOK_GROUND
;	sta	LOCATION		; start at first room

;	lda	#DIRECTION_N
;	sta	DIRECTION

;	jsr	change_location

	lda	#1
	sta	CURSOR_VISIBLE		; visible at first
	sta	JOYSTICK_ENABLED

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

;	lda	LEVEL_OVER
;	bne	really_exit
	jmp	game_loop

;really_exit:
;	jmp	really_exit

	.include	"common_sprites.inc"

	.include	"draw_pointer.s"
	.include	"gr_putsprite_crop.s"
	.include	"gr_offsets.s"
	.include	"keyboard.s"
	.include	"gr_copy.s"
	.include	"gr_pageflip.s"
	.include	"joystick.s"
