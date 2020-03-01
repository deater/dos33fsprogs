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
;	bit	HIRES
	bit	FULLGR

	lda	#0
	sta	DRAW_PAGE

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	; init location

	lda	#0
	sta	LOCATION
	lda	#0
	sta	DIRECTION

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
	; myst_link_book
	;=============================
myst_link_book:

	; play sound effect?

	lda	#1
	sta	LOCATION
	jsr	change_location
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
	sta	GBASL
	iny
	lda	(LOCATION_STRUCT_L),Y
	sta	GBASH
	lda	#$c			; load to page $c00
	jsr	load_rle_gr

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
	.include	"gr_unrle.s"
	.include	"gr_offsets.s"
	.include	"gr_pageflip.s"
	.include	"gr_putsprite_crop.s"

	.include	"mist_graphics.inc"


finger_point_sprite:
	.byte 5,5
	.byte $AA,$BB,$AA,$AA,$AA
	.byte $AA,$BB,$AA,$AA,$AA
	.byte $BA,$BB,$BB,$BB,$BB
	.byte $AB,$BB,$BB,$BB,$BB
	.byte $AA,$BB,$BB,$BB,$AA

finger_grab_sprite:
	.byte 5,5
	.byte $AA,$AA,$BB,$AA,$AA
	.byte $BB,$AA,$BB,$AA,$BB
	.byte $BB,$BA,$BB,$BA,$BB
	.byte $AB,$BB,$BB,$BB,$BB
	.byte $AA,$BB,$BB,$BB,$AA

finger_left_sprite:
	.byte 6,4
	.byte $AA,$AA,$AA,$AB,$BA,$AA
	.byte $BB,$BB,$BB,$BB,$BB,$BB
	.byte $AA,$AA,$BB,$BB,$BB,$BB
	.byte $AA,$AA,$AB,$BB,$BB,$AB

finger_right_sprite:
	.byte 6,4
	.byte $AA,$BA,$AB,$AA,$AA,$AA
	.byte $BB,$BB,$BB,$BB,$BB,$BB
	.byte $BA,$BB,$BB,$BB,$AA,$AA
	.byte $AB,$BB,$BB,$AB,$AA,$AA




;===============================================
; location data
;===============================================
; 19 bytes

LOCATION_NORTH_EXIT=0
LOCATION_SOUTH_EXIT=1
LOCATION_EAST_EXIT=2
LOCATION_WEST_EXIT=3
LOCATION_SPECIAL_EXIT=4
LOCATION_NORTH_BG=5
LOCATION_SOUTH_BG=7
LOCATION_EAST_BG=9
LOCATION_WEST_BG=11
LOCATION_SPECIAL_X1=13
LOCATION_SPECIAL_X2=14
LOCATION_SPECIAL_Y1=15
LOCATION_SPECIAL_Y2=16
LOCATION_SPECIAL_FUNC=17
LOCATION_BGS	= 19
	BG_NORTH = 1
	BG_SOUTH = 2
	BG_EAST = 4
	BG_WEST = 8


locations:
	.word location0,location1,location2

; myst linking book
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$00		; special exit
	.word	link_book_rle	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	21,31		; special x
	.byte	10,24		; special y
	.word	myst_link_book-1		; special function
	.byte	$1		; only north bg

; dock
location1:
	.byte	$2		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; special exit
	.word	dock_n_rle	; north bg
	.word	dock_s_rle	; south bg
	.word	dock_e_rle	; east bg
	.word	dock_w_rle	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	$f		; all bgs

; by dock switch
location2:
	.byte	$ff		; north exit
	.byte	$1		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; special exit
	.word	dock_switch_n_rle	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	$1		; only north

; Looking North, click enter, go to north exit
; Looking South, click enter, go to south exit
; Looking East, click enter, go to east exit

; Looking North, if east_bg then show left arrow


