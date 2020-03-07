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

	lda	LOCATION
	cmp	#25	; clock puzzle
	bne	nothing_special

	jsr	draw_clock_face



nothing_special:
	;====================================
	; draw pointer
	;====================================

	lda	CURSOR_VISIBLE
	bne	draw_pointer
	jmp	no_draw_pointer

draw_pointer:


	lda	CURSOR_X
	sta	XPOS
        lda     CURSOR_Y
	sta	YPOS

	; see if inside special region
	ldy	#LOCATION_SPECIAL_EXIT
	lda	(LOCATION_STRUCT_L),Y
	bmi	finger_not_special

	; see if X1 < X < X2
	lda	CURSOR_X
	ldy	#LOCATION_SPECIAL_X1
	cmp	(LOCATION_STRUCT_L),Y
	bcc	finger_not_special	; blt

	ldy	#LOCATION_SPECIAL_X2
	cmp	(LOCATION_STRUCT_L),Y
	bcs	finger_not_special	; bge

	; see if Y1 < Y < Y2
	lda	CURSOR_Y
	ldy	#LOCATION_SPECIAL_Y1
	cmp	(LOCATION_STRUCT_L),Y
	bcc	finger_not_special	; blt

	ldy	#LOCATION_SPECIAL_Y2
	cmp	(LOCATION_STRUCT_L),Y
	bcs	finger_not_special	; bge

	; we made it this far, we are special

finger_grab:
	lda	#1
	sta	IN_SPECIAL

	lda     #<finger_grab_sprite
	sta	INL
	lda     #>finger_grab_sprite
	jmp	finger_draw

finger_not_special:

	; check for left/right

	lda	CURSOR_X
	cmp	#7
	bcc	check_cursor_left			; blt

	cmp	#33
	bcs	check_cursor_right			; bge

	; otherwise, finger_point

finger_point:
	lda     #<finger_point_sprite
	sta	INL
	lda     #>finger_point_sprite
	jmp	finger_draw

check_cursor_left:
	ldy	#LOCATION_BGS
	lda	(LOCATION_STRUCT_L),Y

check_left_north:
	ldy	DIRECTION
	cpy	#DIRECTION_N
	bne	check_left_south

handle_left_north:
	; check if west exists
	and	#BG_WEST
	beq	finger_point
	bne	finger_left

check_left_south:
	cpy	#DIRECTION_S
	bne	check_left_east

handle_left_south:
	; check if east exists
	and	#BG_EAST
	beq	finger_point
	bne	finger_left

check_left_east:
	cpy	#DIRECTION_E
	bne	check_left_west
handle_left_east:
	; check if north exists
	and	#BG_NORTH
	beq	finger_point
	bne	finger_left

check_left_west:
	; we should be only option left
handle_left_west:
	; check if south exists
	and	#BG_SOUTH
	beq	finger_point
	bne	finger_left


check_cursor_right:

	ldy	#LOCATION_BGS
	lda	(LOCATION_STRUCT_L),Y

check_right_north:
	ldy	DIRECTION
	cpy	#DIRECTION_N
	bne	check_right_south

handle_right_north:
	; check if east exists
	and	#BG_EAST
	beq	finger_point
	bne	finger_right

check_right_south:
	cpy	#DIRECTION_S
	bne	check_right_east

handle_right_south:
	; check if west exists
	and	#BG_WEST
	beq	finger_point
	bne	finger_right

check_right_east:
	cpy	#DIRECTION_E
	bne	check_right_west
handle_right_east:
	; check if south exists
	and	#BG_SOUTH
	beq	finger_point
	bne	finger_right

check_right_west:
	; we should be only option left
handle_right_west:
	; check if north exists
	and	#BG_NORTH
	beq	finger_point
	bne	finger_right



finger_left:
	lda	#1
	sta	IN_LEFT

	lda     #<finger_left_sprite
	sta	INL
	lda     #>finger_left_sprite
	jmp	finger_draw

finger_right:
	lda	#1
	sta	IN_RIGHT
	lda     #<finger_right_sprite
	sta	INL
	lda     #>finger_right_sprite
	jmp	finger_draw



finger_draw:
	sta	INH
	jsr	put_sprite_crop

no_draw_pointer:

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

	jmp	game_loop


	;==============================
	; Handle Keypress
	;==============================
handle_keypress:

	lda	KEYPRESS
	bmi	keypress

	jmp	no_keypress

keypress:
	and	#$7f			; clear high bit

check_left:
	cmp	#'A'
	beq	left_pressed
	cmp	#8			; left key
	bne	check_right
left_pressed:
	dec	CURSOR_X
	jmp	done_keypress

check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15			; right key
	bne	check_up
right_pressed:
	inc	CURSOR_X
	jmp	done_keypress

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B			; up key
	bne	check_down
up_pressed:
	dec	CURSOR_Y
	dec	CURSOR_Y
	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_return
down_pressed:
	inc	CURSOR_Y
	inc	CURSOR_Y
	jmp	done_keypress

check_return:
	cmp	#' '
	beq	return_pressed
	cmp	#13
	bne	done_keypress

return_pressed:

	lda	IN_SPECIAL
	beq	not_special_return

special_return:
	jsr	handle_special

	; special case, don't make cursor visible
	jmp	no_keypress

not_special_return:

	lda	IN_RIGHT
	beq	not_right_return
right_return:

	jsr	turn_right
	jmp	no_keypress

not_right_return:

	lda	IN_LEFT
	beq	not_left_return
left_return:

	jsr	turn_left
	jmp	no_keypress

not_left_return:

	jsr	go_forward
	jmp	no_keypress

done_keypress:
	lda	#1			; make cursor visible
	sta	CURSOR_VISIBLE

no_keypress:
	bit	KEYRESET
	rts

	;============================
	; handle_special
	;===========================

	; set up jump table fakery
handle_special:
	ldy	#LOCATION_SPECIAL_FUNC+1
	lda	(LOCATION_STRUCT_L),Y
	pha
	dey
	lda	(LOCATION_STRUCT_L),Y
	pha
	rts


	;=============================
	; change direction
	;=============================
change_direction:

	; load background
	lda	DIRECTION
	asl
	clc
	adc	#LOCATION_NORTH_BG
	tay

	lda	(LOCATION_STRUCT_L),Y
	sta	LZSA_SRC_LO
	iny
	lda	(LOCATION_STRUCT_L),Y
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	rts


	;=============================
	; change location
	;=============================
change_location:

	; reset pointer to not visible, centered
	lda	#0
	sta	CURSOR_VISIBLE
	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	lda	LOCATION
	asl
	tay

	lda	locations,Y
	sta	LOCATION_STRUCT_L
	lda	locations+1,Y
	sta	LOCATION_STRUCT_H

	jsr	change_direction

	rts

	;==========================
	; go forward
	;===========================
go_forward:

	; update new location

	lda	DIRECTION
	clc
	adc	#LOCATION_NORTH_EXIT
	tay
	lda	(LOCATION_STRUCT_L),Y

	cmp	#$ff
	beq	cant_go_forward

	sta	LOCATION

	; update new direction

	lda	DIRECTION
	clc
	adc	#LOCATION_NORTH_EXIT_DIR
	tay
	lda	(LOCATION_STRUCT_L),Y
	sta	DIRECTION

	jsr	change_location
cant_go_forward:
	rts

	;==========================
	; turn left
	;===========================
turn_left:

	lda	DIRECTION
	cmp	#DIRECTION_N
	beq	go_west
	cmp	#DIRECTION_W
	beq	go_south
	cmp	#DIRECTION_S
	beq	go_east
	bne	go_north

	;==========================
	; turn right
	;===========================
turn_right:
	lda	DIRECTION
	cmp	#DIRECTION_N
	beq	go_east
	cmp	#DIRECTION_E
	beq	go_south
	cmp	#DIRECTION_S
	beq	go_west
	bne	go_north


go_north:
	lda	#DIRECTION_N
	jmp	done_turning
go_east:
	lda	#DIRECTION_E
	jmp	done_turning
go_south:
	lda	#DIRECTION_S
	jmp	done_turning
go_west:
	lda	#DIRECTION_W
	jmp	done_turning


done_turning:
	sta	DIRECTION
	jsr	change_direction

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

	.include	"audio.s"

	.include	"graphics_island/mist_graphics.inc"


	; puzzles

	.include	"clock_bridge_puzzle.s"
	.include	"marker_switch.s"
	.include	"brother_books.s"

	; linking books

	.include	"link_book_mist.s"

	; letters

	.include	"letter_cat.s"


	.include	"common_sprites.inc"

	.include	"leveldata_island.inc"





;.align $100
audio_red_page:
.incbin "audio/red_page.btc"
audio_link_noise:
.incbin "audio/link_noise.btc"

