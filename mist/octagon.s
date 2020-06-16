; Octagon -- inside the Octagon Temple

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

octagon_start:
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
	cmp	#OCTAGON_TOWER_ROTATION
	beq	animate_tower_rotation

	cmp	#OCTAGON_TEMPLE_CENTER
	bne	check_page_close_red
	jsr	draw_octagon_page_far
	jmp	done_foreground

check_page_close_red:
	cmp	#OCTAGON_RED_BOOKSHELF
	bne	check_page_close_blue
	jsr	draw_octagon_page_close_red
	jmp	done_foreground

check_page_close_blue:
	cmp	#OCTAGON_BLUE_BOOKSHELF
	bne	done_foreground
	jsr	draw_octagon_page_close_blue

done_foreground:
	;====================================
	; handle animations
	;====================================

	; things only happening when animating

	lda	ANIMATE_FRAME
	beq	nothing_special

	lda	LOCATION
	cmp	#OCTAGON_FRAME_SHELF
	beq	animate_frame_shelf
	cmp	#OCTAGON_FRAME_DOOR
	beq	animate_frame_door
	cmp	#OCTAGON_TEMPLE_CENTER
	beq	animate_shelf
	cmp	#OCTAGON_ELEVATOR_IN
	beq	animate_elevator
	cmp	#OCTAGON_RED_BOOK_OPEN
	beq	animate_red_book
	cmp	#OCTAGON_BLUE_BOOK_OPEN
	beq	animate_blue_book
	cmp	#OCTAGON_RED_END
	beq	animate_end
	cmp	#OCTAGON_BLUE_END
	beq	animate_end
	bne	nothing_special

animate_frame_shelf:
	jsr	shelf_swirl
	jmp	nothing_special

animate_frame_door:
	jsr	door_swirl
	jmp	nothing_special

animate_shelf:
	jsr	animate_shelf_open
	jmp	nothing_special

animate_elevator:
	jsr	animate_elevator_ride
	jmp	nothing_special

animate_tower_rotation:
	jsr	handle_tower_rotation
	jmp	nothing_special

animate_red_book:
	jsr	red_book_animation
	jmp	nothing_special

animate_blue_book:
	jsr	blue_book_animation
	jmp	nothing_special

animate_end:
	jsr	end_static_animation
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


leave_octagon:

        lda     #MIST_OUTSIDE_TEMPLE
        sta     LOCATION

        lda     #LOAD_MIST
        sta     WHICH_LOAD

        lda     #$ff
        sta     LEVEL_OVER

        rts

handle_octagon:

	ldx	CURSOR_X

	lda	DIRECTION
	and	#$f

	cmp	#DIRECTION_W
	beq	octagon_w

	cmp	#DIRECTION_E
	beq	octagon_e

	cmp	#DIRECTION_S
	beq	octagon_s

octagon_n:
	cpx	#10
	bcc	goto_shelf_frame
	cpx	#29
	bcs	goto_door_frame
	bcc	goto_bookshelf

octagon_e:
	cpx	#10
	bcc	goto_door_frame
	cpx	#29
	bcs	goto_fireplace
	bcc	goto_blue_book

octagon_w:
	cpx	#10
	bcc	goto_map
	cpx	#29
	bcs	goto_shelf_frame
	bcc	goto_red_book

octagon_s:
	cpx	#10
	bcc	goto_fireplace
	cpx	#29
	bcs	goto_map
	bcc	goto_door

goto_map:
	ldy	#OCTAGON_MAP
	lda	#DIRECTION_W
	jmp	done_goto

goto_red_book:
	ldy	#OCTAGON_RED_BOOKSHELF
	lda	#DIRECTION_W|DIRECTION_ONLY_POINT
	jmp	done_goto

goto_shelf_frame:
	ldy	#OCTAGON_FRAME_SHELF
	lda	#DIRECTION_N
	jmp	done_goto

goto_bookshelf:
	ldy	#OCTAGON_BOOKSHELF
	lda	#DIRECTION_N
	jmp	done_goto

goto_door_frame:
	ldy	#OCTAGON_FRAME_DOOR
	lda	#DIRECTION_N
	jmp	done_goto

goto_blue_book:
	ldy	#OCTAGON_BLUE_BOOKSHELF
	lda	#DIRECTION_E|DIRECTION_ONLY_POINT
	jmp	done_goto

goto_fireplace:
	ldy	#OCTAGON_FIREPLACE
	lda	#DIRECTION_E
	jmp	done_goto

goto_door:
	ldy	#OCTAGON_TEMPLE_DOORWAY
	lda	#DIRECTION_S
	jmp	done_goto

done_goto:
	sty	LOCATION
	sta	DIRECTION
	jmp	change_location


	;======================================
	; draw pages if in octagon center (far)
draw_octagon_page_far:
	lda	DIRECTION
	and	#$f

	cmp	#DIRECTION_W
	beq	draw_octagon_red
	cmp	#DIRECTION_E
	beq	draw_octagon_blue
no_draw_page_far:
	rts

draw_octagon_red:
	lda	RED_PAGES_TAKEN
	and	#OCTAGON_PAGE
	bne	no_draw_page_far

	lda	#<red_page_small_sprite
	sta	INL
	lda	#>red_page_small_sprite
	sta	INH

	jmp	draw_small_page

draw_octagon_blue:
	lda	BLUE_PAGES_TAKEN
	and	#OCTAGON_PAGE
	bne	no_draw_page_far

	lda	#<blue_page_small_sprite
	sta	INL
	lda	#>blue_page_small_sprite
	sta	INH

draw_small_page:
	lda	#21
	sta	XPOS
	lda	#24
	sta	YPOS

	jmp	put_sprite_crop         ; tail call

	;======================================
	; draw pages if in octagon center (close)
draw_octagon_page_close_red:
	lda	DIRECTION
	and	#$f

	cmp	#DIRECTION_W
	beq	draw_octagon_close_red

no_draw_page_close:
	rts

draw_octagon_close_red:
	lda	RED_PAGES_TAKEN
	and	#OCTAGON_PAGE
	bne	no_draw_page_close

	lda	#<red_page_sprite
	sta	INL
	lda	#>red_page_sprite
	sta	INH

	jmp	draw_page_close

draw_octagon_page_close_blue:
	lda	DIRECTION
	and	#$f

	cmp	#DIRECTION_E
	beq	draw_octagon_close_blue
	rts

draw_octagon_close_blue:

	lda	BLUE_PAGES_TAKEN
	and	#OCTAGON_PAGE
	bne	no_draw_page_close

	lda	#<blue_page_sprite
	sta	INL
	lda	#>blue_page_sprite
	sta	INH

draw_page_close:
	lda	#24
	sta	XPOS
	lda	#24
	sta	YPOS

	jmp	put_sprite_crop         ; tail call





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
	.include	"audio.s"
	.include	"end_level.s"
	.include	"common_sprites.inc"
	.include	"page_sprites.inc"
.endif

	; level graphics
	.include	"graphics_octagon/octagon_graphics.inc"

	; puzzles
	.include	"brother_books.s"
	.include	"octagon_bookshelf.s"
	.include	"octagon_rotation.s"

	; linking books
	.include	"handle_pages.s"

	; books
	.include	"books/octagon_books.inc"

	; level data
	.include	"leveldata_octagon.inc"


;.align $100
;audio_red_page:
;.incbin "audio/red_page.btc"
