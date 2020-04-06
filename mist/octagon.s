; Octagon -- inside the Octagon Temple

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

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
	lda	#DIRECTION_W
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
	lda	#DIRECTION_E
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

	.include	"audio.s"

	.include	"graphics_octagon/octagon_graphics.inc"

	.include	"end_level.s"

	; puzzles

	.include	"brother_books.s"

	.include	"octagon_bookshelf.s"

	; linking books

	; letters

	.include	"common_sprites.inc"

	.include	"leveldata_octagon.inc"





;.align $100
audio_red_page:
.incbin "audio/red_page.btc"
