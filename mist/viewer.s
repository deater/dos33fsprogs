; Viewer in the room by the dock

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

viewer_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

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
	cmp	#VIEWER_CONTROL_PANEL
	beq	control_panel

	jmp	nothing_special

control_panel:
	jsr	display_panel_code

	jmp	nothing_special

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



back_to_mist:

	lda	#$ff
	sta	LEVEL_OVER

	lda     #MIST_ARRIVAL_DOCK		; the dock
	sta	LOCATION
	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#LOAD_MIST
	sta	WHICH_LOAD

	rts


atrus_message:
;      0123456789012345678901234567890123456789
.byte "CATHERINE, SOMETHING IS UP WITH OUR SONS",0
.byte "THEY'VE BEEN MESSING WITH MY BOOKS",0
.byte "I'VE HIDDEN THE REMAINING LINKING BOOKS",0
.byte "HINT: REMEMBER THE TOWER ROTATION",0

wall_text:
;       0AAA035449E73 DD 49D5E39FE1C 9D1752 0AAA
;       AAAAADCDDCCCD AA CCCCCDCCCCC CCCCCD AAAA
;.byte " *** SETTINGS -- DIMENSIONAL IMAGER ***",0
;       4F0F72108931C 5842539FE 4534 DD 40
;       DCDCCDCDCCCCC CDDDDDCCC DCDD AA BB
;.byte "TOPOGRAPHICAL EXTRUSION TEST -- 40",0
;       71452 45225C5E4 0FFC         DD 67
;       DCDCD DDDCDCCCD DCCC         AA BB
;.byte "WATER TURBULENT POOL         -- 67",0
;       D12B52 379438 491721D        DD 47
;       CCDCCD DDCDCC CCCCDCC        AA BB
;.byte "MARKER SWITCH DIAGRAM        -- 47",0



	;==========================
	; includes
	;==========================

	.include	"gr_copy.s"
	.include	"gr_offsets.s"
	.include	"gr_pageflip.s"
	.include	"gr_putsprite_crop.s"
	.include	"text_print.s"
	.include	"gr_fast_clear.s"
	.include	"decompress_fast_v2.s"
	.include	"keyboard.s"
	.include	"draw_pointer.s"
	.include	"end_level.s"

	.include	"graphics_viewer/viewer_graphics.inc"


	; puzzles

	.include	"common_sprites.inc"

	.include	"page_sprites.inc"

	.include	"leveldata_viewer.inc"

	.include	"viewer_controls.s"
