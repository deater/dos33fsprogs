; Mist

; a version of Myst?
; (yes there's a subtle German joke here)

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


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

	;=================
	; init vars
	;	FIXME: we could be re-called from other books
	;	so don't set location here

	lda	#0
	sta	LOCATION
	lda	#0
	sta	DIRECTION


	lda	LOCATION
	bne	not_first_time

	; first time init
	lda	#0
	sta	CLOCK_MINUTE
	sta	CLOCK_HOUR
	jsr	clock_inside_reset

	lda	#0
	sta	GEAR_OPEN

	sta	BREAKER_TRIPPED
	sta	GENERATOR_VOLTS
	sta	ROCKET_VOLTS
	sta	SWITCH_TOP_ROW
	sta	SWITCH_BOTTOM_ROW

; debug
;	lda	#1
;	sta	GEAR_OPEN
;	jsr	open_the_gear

not_first_time:


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

	; handle gear opening

	lda	GEAR_OPEN
	beq	not_gear_related

	jsr	check_gear_delete
not_gear_related:

	; handle clock puzzles

	lda	LOCATION
	cmp	#25     ; clock puzzle
	beq	location_clock
	cmp	#27
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
	cmp	#36
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



exit_level:
	lda	#2
	sta	WHICH_LOAD

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

	.include	"graphics_island/mist_graphics.inc"

	.include	"end_level.s"

	; puzzles

	.include	"clock_bridge_puzzle.s"
	.include	"marker_switch.s"
	.include	"brother_books.s"
	.include	"generator_puzzle.s"

	; linking books

	.include	"link_book_mist.s"

	; letters

	.include	"letter_cat.s"


	.include	"common_sprites.inc"

	.include	"leveldata_island.inc"





;.align $100
;audio_red_page:
;.incbin "audio/red_page.btc"
;audio_link_noise:
;.incbin "audio/link_noise.btc"


