; Mist

; a version of Myst?
; (yes there's a subtle German joke here)

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

	; init the clock bridge
	jsr	raise_bridge

	; init the gear
	jsr	open_the_gear

	; make the ship right
	jsr	adjust_ship


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


	; handle marker switch drawing
	jsr	draw_marker_switch

	; handle gear opening

	lda	GEAR_OPEN
	beq	not_gear_related

	jsr	check_gear_delete
not_gear_related:
	; handl pillars
	lda	LOCATION
	cmp	#MIST_PILLAR_EYE
	bcc	check_if_clock

	jsr	draw_pillar

	; handle clock puzzles
check_if_clock:
	lda	LOCATION
	cmp	#MIST_CLOCK_PUZZLE	; clock puzzle
	beq	location_clock
	cmp	#MIST_CLOCK_INSIDE
	beq	location_inside_clock
	bne	nothing_special

location_clock:
	jsr	draw_clock_face
	jmp	nothing_special
location_inside_clock:
	jsr	draw_clock_inside
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


	;=================
	; do this here (which is inefficient) because
	; it lets the switch turn green before the noise

	jsr	check_change_ship


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

;=================
; special exits

go_to_meche:
	lda	#LOAD_MECHE
	sta	WHICH_LOAD

	lda     #MECHE_INSIDE_GEAR
        sta     LOCATION

        lda     #DIRECTION_E
        sta     DIRECTION

	jmp	set_level_over

pad_special:
	lda	#MIST_TOWER2_PATH
	sta	LOCATION
	jsr	change_location

	rts

leave_tower2:
	lda	#MIST_TOWER2_TOP
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION

	jsr	change_location

	rts


goto_dentist_steps:

	lda	#MIST_STEPS_DENTIST
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION

	jmp	change_location


enter_octagon:

	lda	#OCTAGON_TEMPLE_DOORWAY
	sta	LOCATION

	lda	#LOAD_OCTAGON
	sta	WHICH_LOAD

	jmp	set_level_over

goto_dentist:

	lda	#DENTIST_OUTSIDE
	sta	LOCATION

	lda	#LOAD_DENTIST
	sta	WHICH_LOAD

	jmp	set_level_over


enter_viewer:

	lda	#VIEWER_STEPS
	sta	LOCATION

	lda	#LOAD_VIEWER
	sta	WHICH_LOAD

	jmp	set_level_over

enter_channel_main:

	lda	#CABIN_OUTSIDE
	sta	LOCATION

	lda	#LOAD_CABIN
	sta	WHICH_LOAD

	lda	#DIRECTION_E
	sta	DIRECTION

	jmp	set_level_over

enter_channel_clock:

	lda	#CABIN_CLOCK_PATH
	sta	LOCATION

	lda	#LOAD_CABIN
	sta	WHICH_LOAD

	lda	#DIRECTION_N
	sta	DIRECTION

	jmp	set_level_over

enter_stoneyship:
	lda	#STONEY_SHIP_STERN
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#LOAD_STONEY
	sta	WHICH_LOAD

set_level_over:
	lda	#$ff
	sta	LEVEL_OVER

	rts

	;===========================
	; read letter from catherine

read_letter:

	lda	#MIST_CAT_LETTER
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION

	jsr	change_location

	bit	SET_TEXT

	rts

	;===========================
	; marker switch clicks
click_switch_dock:
	lda	#MARKER_DOCK
	jmp	click_marker_switch
click_switch_gear:
	lda	#MARKER_GEARS
	jmp	click_marker_switch
click_switch_spaceship:
	lda	#MARKER_SPACESHIP
	jmp	click_marker_switch
click_switch_clock:
	lda	#MARKER_CLOCK
	jmp	click_marker_switch

	;==========================
	; includes
	;==========================

	; graphics data
	.include	"graphics_mist/mist_graphics.inc"

	; puzzles
	.include	"clock_bridge_puzzle.s"
	.include	"marker_switch.s"
	.include	"mist_puzzles.s"

	; level data
	.include	"leveldata_mist.inc"
