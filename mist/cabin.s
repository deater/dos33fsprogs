; That Cabin in the woods

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

cabin_start:
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

	jsr	cabin_update_state

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
	; handle matches
	;====================================

check_match_lit_outside:
	lda	LOCATION
	cmp	#CABIN_OUTSIDE
	bne	check_match_on_pilot

	; FIXME: actual game match sputters a bit before going out
	lda	HOLDING_ITEM
	cmp	#HOLDING_MATCH
	beq	put_out_match
	cmp	#HOLDING_LIT_MATCH
	bne	check_match_on_pilot
put_out_match:
	lda	#0
	sta	HOLDING_ITEM

check_match_on_pilot:
	lda	LOCATION
	cmp	#CABIN_INSIDE
	bne	done_match_handler

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_E
	bne	done_match_handler

	lda	HOLDING_ITEM
	cmp	#HOLDING_LIT_MATCH
	bne	done_match_handler

	lda	CURSOR_Y
	cmp	#34
	bcc	done_match_handler

	lda	CURSOR_X
	cmp	#13
	bcc	done_match_handler
	cmp	#17
	bcs	done_match_handler

	lda	#$80		; light pilot
	sta	BOILER_LEVEL

	lda	#$0		; drop match
	sta	HOLDING_ITEM

done_match_handler:

	;====================================
	; handle special-case forground logic
	;====================================

	jsr	update_boiler_state

	jsr	draw_marker_switch

	lda	LOCATION
	cmp	#CABIN_TREE_BOOK_OPEN
	beq	animate_channel_book

	cmp	#CABIN_SAFE
	bne	check_boiler
	jsr	draw_safe_combination
	jmp	nothing_special

check_boiler:
	cmp	#CABIN_INSIDE
	bne	check_basement

	jsr	draw_valve_cabin

	jmp	nothing_special

check_basement:
	cmp	#CABIN_TREE_BASEMENT
	bne	nothing_special

	jsr	draw_valve_basement

	jmp	nothing_special

animate_channel_book:

	lda	ANIMATE_FRAME
	cmp	#11
	bcc	channel_book_good
	lda	#0
	sta	ANIMATE_FRAME

channel_book_good:
	; handle animated linking book

	lda	ANIMATE_FRAME
	asl
	tay
	lda	channel_movie,Y
	sta	INL
	lda	channel_movie+1,Y
	sta	INH

	lda	#22
        sta     XPOS

        lda     #12
        sta     YPOS

        jsr     put_sprite_crop

        lda     FRAMEL
        and     #$f
	bne     done_animate_book

        inc     ANIMATE_FRAME

done_animate_book:
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


	; exit back to mist by the clock path

enter_clock:

	lda	#DIRECTION_S
	sta	DIRECTION

	lda     #MIST_CLOCK

	jmp	exit_to_mist



handle_clearing:

	lda	DIRECTION
	cmp	#DIRECTION_W
	beq	enter_path

	; else going east

	lda	CURSOR_X
	cmp	#22
	bcc	enter_cabin

	cmp	#27
	bcc	marker_switch

enter_tree_path:
	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#CABIN_TREE_PATH
	sta	LOCATION

	jmp	change_location

marker_switch:
	lda	#MARKER_TREE
	jmp	click_marker_switch

enter_cabin:
	lda	#DIRECTION_E
	sta	DIRECTION

	lda	LOCATION
	cmp	#CABIN_OPEN
	bne	open_the_door

	lda	#CABIN_ENTRANCE
	bne	done_enter_cabin	; bra

open_the_door:
	lda	#CABIN_OPEN

done_enter_cabin:
	sta	LOCATION
	jmp	change_location


enter_path:

	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#MIST_TREE_CORRIDOR_5

	jmp	exit_to_mist


exit_to_mist:

	sta	LOCATION
	lda	#$ff
	sta	LEVEL_OVER

	lda	#LOAD_MIST
	sta	WHICH_LOAD

	rts

	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics_cabin/cabin_graphics.inc"
	.include	"number_sprites.inc"

	; puzzles
	.include	"marker_switch.s"
	.include	"cabin_boiler_puzzle.s"

	; level data
	.include	"leveldata_cabin.inc"

	; linking books
	.include	"link_book_channel.s"

	.include	"simple_sounds.s"
