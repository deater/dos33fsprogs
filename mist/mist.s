; Mist

; a version of Myst?
; (yes there's a subtle German joke here)

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

mist_start:
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

	; init the clock bridge
	jsr	raise_bridge

	; init the gear
	jsr	open_the_gear


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

	; handle gear opening

	lda	GEAR_OPEN
	beq	not_gear_related

	jsr	check_gear_delete
not_gear_related:

	; handle clock puzzles

	lda	LOCATION
	cmp	#MIST_CLOCK_PUZZLE	; clock puzzle
	beq	location_clock
	cmp	#MIST_CLOCK_INSIDE
	beq	location_inside_clock
	bne	location_generator

location_clock:
	jsr	draw_clock_face
	jmp	nothing_special
location_inside_clock:
	jsr	draw_clock_inside
	jmp	nothing_special

	; handle generator puzzle
location_generator:
	cmp	#MIST_GENERATOR_ROOM
	bne	nothing_special
	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	bne	nothing_special

	jsr	generator_update_volts
	jsr	generator_draw_buttons
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

leave_tower1:
	lda	#MIST_TOWER1_TOP
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	jsr	change_location

	rts


green_house:

	; FIXME: handle switch separately

	lda	#MIST_GREEN_SHACK
	sta	LOCATION

	jsr	change_location

	rts


enter_octagon:

	lda	#OCTAGON_TEMPLE_DOORWAY
	sta	LOCATION

	lda	#LOAD_OCTAGON
	sta	WHICH_LOAD

	jmp	set_level_over

enter_viewer:

	lda	#VIEWER_STEPS
	sta	LOCATION

	lda	#LOAD_VIEWER
	sta	WHICH_LOAD

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

	.include	"graphics_mist/mist_graphics.inc"

	.include	"end_level.s"

	; puzzles

	.include	"clock_bridge_puzzle.s"
	.include	"marker_switch.s"
	.include	"generator_puzzle.s"

	; linking books

	; letters

	.include	"letter_cat.s"


	.include	"common_sprites.inc"

	.include	"leveldata_mist.inc"





;.align $100
;audio_red_page:
;.incbin "audio/red_page.btc"



