; Mist Title

; loads a HGR version of the title
; also handles the initial link to mist

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

mist_start:
	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	HIRES
	bit	FULLGR

	;===================
	; setup location
	;===================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H

	;===================
	; Load graphics
	;===================
reload_everything:

	lda     #<file
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>file
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast


	;====================================
	; load linking audio (12k) to $9000

	lda	#<linking_filename
	sta	OUTL
	lda	#>linking_filename
	sta	OUTH

	jsr	opendir_filename


	;====================================
	; wait for keypress or a few seconds

	bit	KEYRESET
	lda	#0
	sta	FRAMEL

keyloop:
	lda	#64			; delay a bit
	jsr	WAIT
	inc	FRAMEL
	lda	FRAMEL			; time out eventually
	beq	done_keyloop

	lda	KEYPRESS
	bpl	keyloop

done_keyloop:


	bit	KEYRESET



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

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	lda	#0
	sta	LEVEL_OVER

	;============================
	; init vars

	jsr	init_state

	;============================
	; set up initial location

	lda	#TITLE_MIST_LINKING_DOCK
	sta	LOCATION		; start at first room

	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#LOAD_MIST		; load mist
	sta	WHICH_LOAD


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

	; handle animated linking book

	; note: the linking book to the dock doesn't have much action

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
.if 0
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
	.include	"audio.s"
.endif

	.include	"init_state.s"

	.include	"graphics_title/title_graphics.inc"


	; puzzles

	; linking books

	.include	"link_book_mist_dock.s"

	.include	"common_sprites.inc"

	.include	"leveldata_title.inc"

linking_filename:
	.byte "LINK_NOISE.BTC",0


file:
.incbin "graphics_title/mist_title.lzsa"
