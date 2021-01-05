; The Ship on Mist Island

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

ship_start:
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

	; FIXME: fix gear being open/closed as viewed from ship

	lda	LOCATION
	cmp	#SHIP_BOOK_OPEN
	beq	animate_stoney_book

	jmp	nothing_special

animate_stoney_book:

	jsr	do_animate_stoney_book
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


do_animate_stoney_book:

	; handle animated linking book

	lda	ANIMATE_FRAME
	asl
	tay
	lda	stoney_movie,Y
	sta	INL
	lda	stoney_movie+1,Y
	sta	INH

	lda	#22
	sta	XPOS
	lda	#12
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$f
	bne	done_animate_book

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#16
	bne	done_animate_book
	lda	#0
	sta	ANIMATE_FRAME
done_animate_book:
	rts


back_to_mist:

	lda	#$ff
	sta	LEVEL_OVER

	lda	#MIST_ARRIVAL_DOCK		; the dock
	sta	LOCATION
	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#LOAD_MIST
	sta	WHICH_LOAD

	rts



	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics_ship/ship_graphics.inc"

	; linking books
	.include	"link_book_stoney.s"

	; puzzles
;	.include	"handle_pages.s"

	; level data
	.include	"leveldata_ship.inc"
