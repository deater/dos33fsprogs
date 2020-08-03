; Bunker/Sub part of Selena Age

; Ein U-Boot holt uns dann hier raus
; Und du bist der Kapitaen

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

sub_start:
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

	;=================
	; init vars

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

	cmp	#SUB_BOOK_OPEN
	beq	mist_book_animation

	jmp	nothing_special

mist_book_animation:

	jsr	draw_mist_animation
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



	;===================================
	; goto selena
	;	go back out bunker door
        ;===================================

goto_selena:
	lda	#$ff
	sta	LEVEL_OVER

	lda     #SELENA_BUNKER		; outside bunker door
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#LOAD_SELENA
	sta	WHICH_LOAD

	rts



	;===============================
	; draw mist book animation
	;===============================

draw_mist_animation:
	; handle animated linking book

	lda	ANIMATE_FRAME
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



sub_selena_open:
	lda	#SUB_CLOSE_OPEN
	sta	LOCATION

	jmp	change_location

sub_selena_close:
	lda	#SUB_CLOSE
	sta	LOCATION

	jmp	change_location

sub_door_selena_open:
	lda	#SUB_INSIDE_BACK_OPEN
	sta	LOCATION

	jmp	change_location

sub_door_close:
	lda	#SUB_INSIDE_BACK
	sta	LOCATION

	jmp	change_location


	;=====================
	; sub controls
	;=====================


	;====================
	; toward_book
sub_controls_move_toward_book:

	; disable exit button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location6,Y				; SUB_INSIDE_BACK

	; change so we use split mode when looking E
	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E|DIRECTION_SPLIT
	sta	location6,Y				; SUB INSIDE_BACK
	; any controls take us to moving
	sta	DIRECTION

	lda	#SUB_INSIDE_FRONT_MOVING
	sta	LOCATION
	jmp	change_location

	;====================
	; toward_selena
sub_controls_move_toward_selena:

	; disable exit button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location6,Y				; SUB_INSIDE_BACK

	; change so we use split mode when looking E
	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E|DIRECTION_SPLIT
	sta	location6,Y				; SUB INSIDE_BACK

	; any controls take us to moving
	sta	DIRECTION

	; change destination of front of sub
	ldy	#LOCATION_EAST_EXIT
	lda	#SUB_INSIDE_FRONT_MOVING
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN
	sta	location6,Y				; SUN_INSIDE_BACK

	lda	#SUB_INSIDE_FRONT_MOVING
	sta	LOCATION
	jmp	change_location


	;===============================
	; moving
sub_controls_moving:

	; re-enable exit button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_S
	sta	location6,Y				; SUB_INSIDE_BACK

	; change so we use normal (not split) mode when looking forward
	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E
	sta	location6,Y				; SUB INSIDE_BACK
	sta	DIRECTION

	lda	CURSOR_Y
	cmp	#32
	bcc	sub_forward	; blt

	; "backward" taks us back to selena
sub_backward:

	; change destination of open door
	ldy	#LOCATION_SOUTH_EXIT
	lda	#SUB_CLOSE_OPEN
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_N
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN

	; change destination of front of sub
	ldy	#LOCATION_EAST_EXIT
	lda	#SUB_INSIDE_FRONT_SELENA
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN
	sta	location6,Y				; SUN_INSIDE_BACK

	; change background of open door
	ldy	#LOCATION_SOUTH_BG
	lda	#<inside_sub_back_selena_s_lzsa
	sta	location7,Y
	lda	#>inside_sub_back_selena_s_lzsa
	sta	location7+1,Y				; SUB_INSIDE_BACK_OPEN

	lda	#SUB_INSIDE_FRONT_SELENA
	sta	LOCATION
	jmp	change_location

	; "forward" takes us to book
sub_forward:

	; change destination of open door
	ldy	#LOCATION_SOUTH_EXIT
	lda	#SUB_OUTSIDE_BOOK
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_S
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN

	; change destination of front of sub
	ldy	#LOCATION_EAST_EXIT
	lda	#SUB_INSIDE_FRONT_BOOK
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN
	sta	location6,Y				; SUN_INSIDE_BACK

	; change background of open door
	ldy	#LOCATION_SOUTH_BG
	lda	#<inside_sub_back_book_s_lzsa
	sta	location7,Y
	lda	#>inside_sub_back_book_s_lzsa
	sta	location7+1,Y				; SUB_INSIDE_BACK_OPEN

	lda	#SUB_INSIDE_FRONT_BOOK
	sta	LOCATION
	jmp	change_location


;         1         2         3
;123456789012345678901234567890123456789
; FOR THE SAKE OF ARGUMENT IMAGINE YOU
; JUST SPENT 45 MINUTES NAVIGATING AN
; OBSCURE MAZE BASED ON A CLUE YOU WERE
; SUPPOSED TO NOTICE IN MECHANICAL AGE

	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics_sub/sub_graphics.inc"

	; puzzles

	; linking books
	.include	"link_book_mist.s"

	; level data
	.include	"leveldata_sub.inc"

	; sound
	.include	"simple_sounds.s"




; sub solution
;	N, W, N, E, E
;	S, S, W, SW, W
;	NW, NE, N, SE
