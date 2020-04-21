; The Stone Ship level

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

stoney_start:
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

	; FIXME
	; handle gear visibility

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
	cmp	#STONEY_SHIP_BOOK_OPEN
	beq	animate_stoney_book
	cmp	#STONEY_BOOK_TABLE_OPEN
	beq	animate_mist_book
	cmp	#STONEY_RED_DRESSER_OPEN
	beq	fg_draw_red_page
	cmp	#STONEY_BLUE_ROOM_BED
	beq	fg_draw_blue_page

	jmp	nothing_special

animate_stoney_book:
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
	jmp	nothing_special

animate_mist_book:
	lda     ANIMATE_FRAME
	cmp	#6
	bcc	mist_book_good			; blt

	lda	#0
	sta	ANIMATE_FRAME

mist_book_good:

	asl
	tay
	lda	mist_movie,Y
	sta	INL
	lda	mist_movie+1,Y
	sta	INH

	lda	#24
	sta	XPOS
	lda	#12
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$f
	bne	done_animate_mist_book

	inc	ANIMATE_FRAME

done_animate_mist_book:
	jmp	nothing_special

fg_draw_red_page:
	jsr	draw_red_page
	jmp	nothing_special

fg_draw_blue_page:
	jsr     draw_blue_page
	jmp     nothing_special

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
	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#LOAD_MIST
	sta	WHICH_LOAD

	rts


stoney_take_red_page:
	lda	#STONEY_PAGE
	jmp	take_red_page

stoney_take_blue_page:
	lda	#STONEY_PAGE
	jmp	take_blue_page


	;=============================
draw_red_page:

	lda     RED_PAGES_TAKEN
	and	#STONEY_PAGE
	bne	no_draw_page

	lda	#14
	sta	XPOS
	lda	#36
	sta	YPOS

	lda	#<red_page_sprite
	sta	INL
	lda	#>red_page_sprite
	sta	INH

	jmp	put_sprite_crop		; tail call

draw_blue_page:

	lda	BLUE_PAGES_TAKEN
	and	#STONEY_PAGE
	bne	no_draw_page

	lda	#15
	sta	XPOS
	lda	#34
	sta	YPOS

	lda	#<blue_page_sprite
	sta	INL
	lda	#>blue_page_sprite
	sta	INH

	jmp	put_sprite_crop         ; tail call

no_draw_page:
	rts




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

	.include	"audio.s"

	.include	"graphics_stoney/stoney_graphics.inc"


	; linking books

	.include	"link_book_stoney.s"
	.include	"link_book_mist.s"

	; puzzles

	.include	"handle_pages.s"

	.include	"common_sprites.inc"

	.include	"page_sprites.inc"

	.include	"leveldata_stoney.inc"
