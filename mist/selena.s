; Selenitic (selena) island

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

selena_start:
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

	; copy in rocket note puzzle state
	lda	ROCKET_NOTE1
	sta	rocket_notes
	lda	ROCKET_NOTE2
	sta	rocket_notes+2
	lda	ROCKET_NOTE3
	sta	rocket_notes+4
	lda	ROCKET_NOTE4
	sta	rocket_notes+6

	; hook up the special functions
	; these might be disabled if we've been here before
	; FIXME: this means we cannot save game inside spaceship on selena

	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_E	; enable controls
	sta	location1,Y	; SELENA_CONTROLS
	lda	#DIRECTION_W	; enable organ
	sta	location2,Y	; SELENA_ELECTRIC_ORGAN
	lda	#DIRECTION_N	; enable mist exit
	sta	location0,Y     ; SELENA_INSIDE_SHIP

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

	cmp	#SELENA_CONTROLS
	beq	controls_animation

	cmp	#SELENA_BOOK_OPEN
	beq	mist_book_animation

	cmp	#SELENA_WATER
	beq	fg_draw_blue_page	; and water note

	cmp	#SELENA_CRYSTAL_CLOSE
	beq	fg_draw_red_page

	cmp	#SELENA_ANTENNA_CLOSE
	beq	fg_draw_antenna_panel

	cmp	#SELENA_CHASM
	beq	fg_draw_chasm_note

	cmp	#SELENA_TUNNEL_MAIN_CLOSE
	beq	fg_draw_tunnel_note


	jmp	nothing_special

mist_book_animation:

	jsr	draw_mist_animation
	jmp	nothing_special

controls_animation:

	ldy	#LOCATION_SPECIAL_EXIT
	lda	location1,Y
	cmp	#$ff
	beq	no_draw_buttons

	; draw the buttons
	jsr	spaceship_draw_buttons

no_draw_buttons:

	; handle animated linking book

	lda	ANIMATE_FRAME
	beq	nothing_special

	asl
	tay
	lda	selena_movie,Y
	sta	INL
	lda	selena_movie+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#4
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$f
	bne	done_animate_book

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME

animate_check_high:
	cmp	#23
	bne	animate_check_low
	lda	#13
	sta	ANIMATE_FRAME
	bne	done_animate_book		; bra

animate_check_low:
	cmp	#13
	bne	done_animate_book
	lda	#9
	sta	ANIMATE_FRAME

done_animate_book:
	jmp	nothing_special

fg_draw_blue_page:
        jsr     draw_blue_page
        jmp     nothing_special

fg_draw_red_page:
        jsr     draw_red_page
        jmp     nothing_special

fg_draw_antenna_panel:
	jsr	draw_antenna_panel
	jmp	nothing_special

fg_draw_water_note:
	jsr	draw_water_background
	jmp	nothing_special

fg_draw_chasm_note:
	jsr	draw_chasm_background
	jmp	nothing_special

fg_draw_tunnel_note:
	jsr	draw_tunnel_background
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

	lda	#MIST_SPACESHIP_FAR		; pathway outside rocket
	sta	LOCATION
	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#LOAD_MIST
	sta	WHICH_LOAD

	jsr	save_rocket_state

	rts

	; save rocket state
save_rocket_state:
	lda	rocket_notes
	sta	ROCKET_NOTE1
	lda	rocket_notes+2
	sta	ROCKET_NOTE2
	lda	rocket_notes+4
	sta	ROCKET_NOTE3
	lda	rocket_notes+6
	sta	ROCKET_NOTE4

	rts


selena_take_red_page:
	lda	#SELENA_PAGE
	jmp	take_red_page

selena_take_blue_page:
	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_W
	bne	actually_take_blue_page

	jmp	water_button_pressed

actually_take_blue_page:

	lda	#SELENA_PAGE
	jmp	take_blue_page


	;=============================
draw_red_page:

	lda	RED_PAGES_TAKEN
	and	#SELENA_PAGE
	bne	no_draw_page

	lda	#20
	sta     XPOS
	lda	#2
	sta	YPOS

	lda	#<red_page_sprite
	sta	INL
	lda	#>red_page_sprite
	sta	INH

	jmp	put_sprite_crop         ; tail call


draw_blue_page:

	lda	DIRECTION
	cmp	#DIRECTION_S
	beq	do_draw_blue_page
	cmp	#DIRECTION_W
	bne	no_draw_page
	jmp	draw_water_background

do_draw_blue_page:

	lda	BLUE_PAGES_TAKEN
	and	#SELENA_PAGE
        bne     no_draw_page

	lda	#20
	sta	XPOS
	lda	#24
	sta	YPOS

	lda	#<blue_page_sprite
	sta	INL
	lda	#>blue_page_sprite
	sta	INH

	jmp	put_sprite_crop         ; tail call

no_draw_page:
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



	;==============================
	; tunnel actions
tunnel_main_down:
	lda	#SELENA_TUNNEL_MAIN_TOP
	bne	update_tunnel_e
tunnel_main_top_down:
	lda	#SELENA_TUNNEL_MAIN_MID
	bne	update_tunnel_e
tunnel_main_mid_down:
	lda	#SELENA_TUNNEL_BASEMENT
;	bne	update_tunnel_e
update_tunnel_e:
	sta	LOCATION
	lda	#DIRECTION_E
	sta	DIRECTION
	jmp	change_location

antenna_down:
	lda	#SELENA_ANTENNA_TOP
	bne	update_tunnel_e
antenna_top_down:
	lda	#SELENA_ANTENNA_MID
	bne	update_tunnel_e
antenna_mid_down:
	lda	#SELENA_ANTENNA_BASEMENT
	bne	update_tunnel_e


	;==============================
	; keypad actions
keypad_press:
	lda	#SELENA_BUNKER_OPEN
	sta	LOCATION
	jmp	change_location

	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics_selena/selena_graphics.inc"

	; puzzles
	.include	"selena_organ_puzzle.s"
	.include	"selena_sound_puzzle.s"

	; linking books
	.include	"link_book_mist.s"

	.include	"handle_pages.s"

	; level data
	.include	"leveldata_selena.inc"

	; sound
	.include	"speaker_beeps.s"
	.include	"simple_sounds.s"




