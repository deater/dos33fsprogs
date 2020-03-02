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
; 24 bytes each location

LOCATION_NORTH_EXIT=0
LOCATION_SOUTH_EXIT=1
LOCATION_EAST_EXIT=2
LOCATION_WEST_EXIT=3
LOCATION_NORTH_EXIT_DIR=4
LOCATION_SOUTH_EXIT_DIR=5
LOCATION_EAST_EXIT_DIR=6
LOCATION_WEST_EXIT_DIR=7
LOCATION_SPECIAL_EXIT=8
LOCATION_NORTH_BG=9
LOCATION_SOUTH_BG=11
LOCATION_EAST_BG=13
LOCATION_WEST_BG=15
LOCATION_SPECIAL_X1=17
LOCATION_SPECIAL_X2=18
LOCATION_SPECIAL_Y1=19
LOCATION_SPECIAL_Y2=20
LOCATION_SPECIAL_FUNC=21
LOCATION_BGS	= 23
	BG_NORTH = 1
	BG_SOUTH = 2
	BG_EAST = 4
	BG_WEST = 8


locations:
	.word location0,location1,location2,location3
	.word location4,location5,location6,location7
	.word location8,location9,location10,location11
	.word location12,location13


; myst linking book
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
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
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
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
	.byte	3		; north exit
	.byte	1		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	dock_switch_n_rle	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH	; only north


; dock steps
location3:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	2		; east exit
	.byte	4		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	dock_steps_w_rle		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST		; only west

; above dock path
location4:
	.byte	3		; north exit
	.byte	5		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	above_dock_s_rle		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH	; only south

; base of steps
location5:
	.byte	4		; north exit
	.byte	6		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	step_base_s_rle	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH	; only south

; steps 1st landing
location6:
	.byte	5		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	7		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	step_land1_w_rle	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST		; only west

; steps 2nd landing
location7:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	6		; east exit
	.byte	8		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	step_land2_w_rle	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST		; only west

; steps outside dentist chair branch
location8:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	7		; east exit
	.byte	9		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	step_dentist_w_rle	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST		; only west

; steps one more time up
location9:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	8		; east exit
	.byte	10		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	step_land3_w_rle	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST		; only west


; at the top outside temple
location10:
	.byte	11		; north exit
	.byte	$ff		; south exit
	.byte	9		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	step_top_n_rle	; north bg
	.word	step_top_s_rle	; south bg
	.word	step_top_e_rle	; east bg
	.word	step_top_w_rle	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_EAST|BG_WEST|BG_NORTH|BG_SOUTH	; all dirs

; temple doorway
location11:
	.byte	12		; north exit
	.byte	10		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	temple_door_n_rle	; north bg
	.word	temple_door_s_rle	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH|BG_SOUTH	; north and south

; temple inside
location12:
	.byte	$ff		; north exit
	.byte	11		; south exit
	.byte	$ff		; east exit
	.byte	13		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	temple_center_n_rle	; north bg
	.word	temple_center_s_rle	; south bg
	.word	temple_center_e_rle	; east bg
	.word	temple_center_w_rle	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH|BG_WEST|BG_SOUTH|BG_EAST	; all directions

; red book shelf
location13:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	12		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	red_book_shelf_rle	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST		; west











; Looking North, click enter, go to north exit
; Looking South, click enter, go to south exit
; Looking East, click enter, go to east exit

; Looking North, if east_bg then show left arrow



; Catherine,
; I've left for you a message
; of utmost importance in
; our fore-chamber beside
; the dock.  Enter the number
; of Marker Switches on
; this island into the imager
; to retrieve the message.
;             Yours,
;                 Atrus
