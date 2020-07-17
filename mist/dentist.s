; The Planetarium / Dentist Office

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

dentist_start:
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

	; handle light switch

	jsr	setup_backgrounds

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

	jsr	draw_marker_switch

	lda	LOCATION
	cmp	#DENTIST_PANEL
	beq	fg_draw_panel

	jmp	nothing_special

fg_draw_panel:
	jsr	draw_date
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


	;===========================
	;===========================
	; back to mist
	;===========================
	;===========================

back_to_mist:
	lda	DIRECTION
	cmp	#DIRECTION_S
	beq	go_back_to_mist
oh_its_the_marker_switch:

	lda	CURSOR_X
	cmp	#10
	bcs	use_door
	lda	CURSOR_Y
	cmp	#28
	bcc	use_door
	cmp	#40
	bcs	use_door

	lda	#MARKER_DENTIST
	jmp	click_marker_switch
use_door:
	lda	LOCATION
	cmp	#DENTIST_OUTSIDE
	bne	go_inside

open_door:
	lda	#DENTIST_OUTSIDE_OPEN
	sta	LOCATION
	jmp	change_location

go_inside:
	lda	#DENTIST_INSIDE_DOOR
	sta	LOCATION
	jmp	change_location

go_back_to_mist:
	lda	#MIST_STEPS_4TH_LANDING
	sta	LOCATION

	lda	CURSOR_X
	cmp	#20
	bcs	go_west_young_man

	lda	#DIRECTION_E
	jmp	steps_direction

go_west_young_man:
	lda	#DIRECTION_W

steps_direction:
	sta	DIRECTION

	lda	#LOAD_MIST
	sta	WHICH_LOAD

set_level_over:
	lda	#$ff
	sta	LEVEL_OVER

done_door:
	rts

	;===========================
	;===========================
	; pull down panel
	;===========================
	;===========================

pull_down_panel:
	lda	#0
	sta	button_smc+1		; turn off blink

	lda	#31
	sta	startup_animate_smc+1	; start startup animation

	lda	#DENTIST_PANEL
	sta	LOCATION

	lda	#DIRECTION_N|DIRECTION_SPLIT
	sta	DIRECTION

	jmp	change_location




light_switch:

	lda	DENTIST_LIGHT
	eor	#$1
	sta	DENTIST_LIGHT

	jsr	setup_backgrounds

	jmp	change_location


	; setup backgrounds based on light switch being on or off
setup_backgrounds:

	lda	DENTIST_LIGHT
	bne	lights_are_off

	; lights are on
lights_are_on:
	ldy	#LOCATION_NORTH_BG
	lda	#<dentist_door_open_n_lzsa
	sta	location1,Y
	lda	#>dentist_door_open_n_lzsa
	sta	location1+1,Y			; DENTIST_OUTSIDE_OPEN

	lda	#<chair_view_n_lzsa
	sta	location2,Y
	lda	#>chair_view_n_lzsa
	sta	location2+1,Y			; DENTIST_INSIDE_DOOR

	lda	#<chair_close_n_lzsa
	sta	location3,Y
	lda	#>chair_close_n_lzsa
	sta	location3+1,Y			; DENTIST_CHAIR_CLOSE

	lda	#<panel_up_lzsa
	sta	location4,Y
	lda	#>panel_up_lzsa
	sta	location4+1,Y			; DENTIST_PANEL_UP


	ldy	#LOCATION_SOUTH_BG
	lda	#<chair_view_s_lzsa
	sta	location2,Y
	lda	#>chair_view_s_lzsa
	sta	location2+1,Y			; DENTIST_INSIDE_DOOR

	lda	#<chair_close_s_lzsa
	sta	location3,Y
	lda	#>chair_close_s_lzsa
	sta	location3+1,Y			; DENTIST_CHAIR_CLOSE

	rts

	; lights are off
lights_are_off:
	ldy	#LOCATION_NORTH_BG
	lda	#<dentist_door_open_dark_n_lzsa
	sta	location1,Y
	lda	#>dentist_door_open_dark_n_lzsa
	sta	location1+1,Y			; DENTIST_OUTSIDE_OPEN

	lda	#<chair_view_dark_n_lzsa
	sta	location2,Y
	lda	#>chair_view_dark_n_lzsa
	sta	location2+1,Y			; DENTIST_INSIDE_DOOR

	lda	#<chair_close_dark_n_lzsa
	sta	location3,Y
	lda	#>chair_close_dark_n_lzsa
	sta	location3+1,Y			; DENTIST_CHAIR_CLOSE

	lda	#<panel_up_dark_lzsa
	sta	location4,Y
	lda	#>panel_up_dark_lzsa
	sta	location4+1,Y			; DENTIST_PANEL_UP


	ldy	#LOCATION_SOUTH_BG
	lda	#<chair_view_dark_s_lzsa
	sta	location2,Y
	lda	#>chair_view_dark_s_lzsa
	sta	location2+1,Y			; DENTIST_INSIDE_DOOR

	lda	#<chair_close_dark_s_lzsa
	sta	location3,Y
	lda	#>chair_close_dark_s_lzsa
	sta	location3+1,Y			; DENTIST_CHAIR_CLOSE


	rts


	;==========================
	; includes
	;==========================

	.include	"gr_putsprite_raw.s"

	; level graphics
	.include	"graphics_dentist/dentist_graphics.inc"

	; puzzles
	.include	"dentist_panel.s"
	.include	"marker_switch.s"

	; level data
	.include	"leveldata_dentist.inc"

	; sound
	.include	"simple_sounds.s"
