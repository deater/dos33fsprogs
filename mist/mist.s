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

	lda	#<audio_link_noise
	sta	BTC_L
	lda	#>audio_link_noise
	sta	BTC_H
	ldx	#43		; 45 pages long???
	jsr	play_audio





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

letter:
;        01234567890123456789
.byte  9,1,"  CATHERINE,          ",0
.byte  9,3,"  I THINK SOME WEIRD  ",0
.byte  9,5,"  GUY IS OUT ROAMING  ",0
.byte  9,7,"  AROUND OUR ISLAND!  ",0
.byte  9,9,"  MAYBE HE CAN SOLVE  ",0
.byte 9,11,"  ALL OF OUR DEEP     ",0
.byte 9,13,"  FAMILY PROBLEMS     ",0
.byte 9,15,"  WHILE I MESS        ",0
.byte 9,17,"  WITH MY BOOKS.      ",0
.byte 9,19,"         YOURS,       ",0
.byte 9,21,"             ATRUS    ",0

clear_line:
.byte 9,0, "                      ",0

	;================
	; read the letter

read_letter:
;	jsr	TEXT
;	jsr	HOME
	bit	KEYRESET

	bit	SET_TEXT

	jsr	clear_all

	; clear

	ldx	#0
clear_line_loop:
	lda	#<clear_line
	sta	OUTL
	lda	#>clear_line
	sta	OUTH


	stx	clear_line+1
	jsr	move_and_print
	inx
	cpx	#24
	bne	clear_line_loop


	lda	#<letter
	sta	OUTL
	lda	#>letter
	sta	OUTH

	ldx	#0
letter_loop:
	jsr	move_and_print

	inx
	cpx	#12
	bne	letter_loop

	jsr	page_flip

wait_done_letter:
	lda	KEYPRESS
	bpl	wait_done_letter
	bit	KEYRESET

	; turn graphics back on

	bit	SET_GR
;	bit	PAGE0
;	bit	FULLGR

	rts


click_switch:

	; click

	bit	$C030
	bit	$C030

	rts


	;===========================
	; open the red book
	;===========================
red_book:

	bit	KEYRESET
	lda	#0
	sta	FRAMEL

red_book_loop:

	lda	#<red_book_static_lzsa
	sta	LZSA_SRC_LO
	lda	#>red_book_static_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

	jsr	page_flip

	lda	#120
	jsr	WAIT

	lda	#<red_book_static2_lzsa
	sta	LZSA_SRC_LO
	lda	#>red_book_static2_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

	jsr	page_flip

	lda	#120
	jsr	WAIT


	inc	FRAMEL
	lda	FRAMEL
	cmp	#5
	bne	done_sir

	;; annoying brother


	lda	#<red_book_open_lzsa
	sta	LZSA_SRC_LO
	lda	#>red_book_open_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

	jsr	page_flip

	lda	#<audio_red_page
	sta	BTC_L
	lda	#>audio_red_page
	sta	BTC_H
	ldx	#21		; 21 pages long???
	jsr	play_audio


;	lda	#100
;	jsr	WAIT


done_sir:

	lda	KEYPRESS
	bpl	red_book_loop

red_book_done:

	bit	KEYRESET

	; restore bg

	lda	#<red_book_shelf_lzsa
	sta	LZSA_SRC_LO
	lda	#>red_book_shelf_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast


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
	.word location0, location1, location2, location3
	.word location4, location5, location6, location7
	.word location8, location9, location10,location11
	.word location12,location13,location14,location15
	.word location16,location17,location18,location19
	.word location20,location21,location22,location23

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
	.word	m_link_book_lzsa	; north bg
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
	.word	dock_n_lzsa	; north bg
	.word	dock_s_lzsa	; south bg
	.word	dock_e_lzsa	; east bg
	.word	dock_w_lzsa	; west bg
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
	.byte	$00		; special exit
	.word	dock_switch_n_lzsa	; north bg
	.word	dock_switch_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	23,30		; special x
	.byte	25,32		; special y
	.word	click_switch-1	; special function
	.byte	BG_NORTH|BG_SOUTH


; dock steps
location3:
	.byte	19		; north exit
	.byte	$ff		; south exit
	.byte	2		; east exit
	.byte	4		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.byte	$ff		; special exit
	.word	gear_base_n_lzsa		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	dock_steps_w_lzsa		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST|BG_NORTH

; above dock path
location4:
	.byte	20		; north exit
	.byte	5		; south exit
	.byte	2		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	above_dock_n_lzsa	; north bg
	.word	above_dock_s_lzsa	; south bg
	.word	above_dock_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH|BG_NORTH|BG_EAST

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
	.word	step_base_n_lzsa	; north bg
	.word	step_base_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH|BG_NORTH

; steps 1st landing
location6:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	5		; east exit
	.byte	7		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	step_land1_e_lzsa	; east bg
	.word	step_land1_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST	| BG_EAST

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
	.byte	$00		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	step_land2_e_lzsa	; east bg
	.word	step_land2_w_lzsa	; west bg
	.byte	29,32		; special x
	.byte	38,45		; special y
	.word	read_letter-1
	.byte	BG_WEST	| BG_EAST

; steps outside dentist chair branch
location8:
	.byte	21		; north exit
	.byte	$ff		; south exit
	.byte	7		; east exit
	.byte	9		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.byte	$ff		; special exit
	.word	step_dentist_n_lzsa	; north bg
	.word	$0000			; south bg
	.word	step_dentist_e_lzsa	; east bg
	.word	step_dentist_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_EAST|BG_WEST|BG_NORTH

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
	.word	step_land3_e_lzsa	; east bg
	.word	step_land3_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_WEST	| BG_EAST	; west and eastl


; at the top outside temple
location10:
	.byte	11		; north exit
	.byte	14		; south exit
	.byte	9		; east exit
	.byte	16		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.byte	$ff		; special exit
	.word	step_top_n_lzsa	; north bg
	.word	step_top_s_lzsa	; south bg
	.word	step_top_e_lzsa	; east bg
	.word	step_top_w_lzsa	; west bg
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
	.word	temple_door_n_lzsa	; north bg
	.word	temple_door_s_lzsa	; south bg
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
	.word	temple_center_n_lzsa	; north bg
	.word	temple_center_s_lzsa	; south bg
	.word	temple_center_e_lzsa	; east bg
	.word	temple_center_w_lzsa	; west bg
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
	.byte	$00		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	red_book_shelf_lzsa	; west bg
	.byte	16,25		; special x
	.byte	16,32		; special y
	.word	red_book-1	; special function
	.byte	BG_WEST		; west

; pool
location14:
	.byte	$ff		; north exit
	.byte	23		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	pool_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH

; clock
location15:
	.byte	$ff		; north exit
	.byte	18		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	$0000		; north bg
	.word	clock_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_SOUTH


; spaceship far
location16:
	.byte	22		; north exit
	.byte	$ff		; south exit
	.byte	10		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	spaceship_far_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	spaceship_far_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH|BG_EAST


; tree corridor #2
location17:
	.byte	10		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$00		; special exit
	.word	tree2_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	25,31		; special x
	.byte	19,23		; special y
	.word	click_switch-1	; special function
	.byte	BG_NORTH


; tree corridor #5
location18:
	.byte	23		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	tree5_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	tree5_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH | BG_EAST

; gear
location19:
	.byte	$ff		; north exit
	.byte	4		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$00		; special exit
	.word	gear_n_lzsa	; north bg
	.word	gear_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	gear_w_lzsa	; west bg
	.byte	5,10		; special x
	.byte	29,35		; special y
	.word	click_switch-1	; special function
	.byte	BG_NORTH | BG_SOUTH | BG_WEST

; gear base
location20:
	.byte	19		; north exit
	.byte	$ff		; south exit
	.byte	3		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	gear_base_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	above_dock_e_lzsa	; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH | BG_EAST

; dentist door
location21:
	.byte	21		; north exit
	.byte	9		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	dentist_door_n_lzsa	; north bg
	.word	dentist_door_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH | BG_SOUTH

; spaceship switch
location22:
	.byte	16		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	spaceship_switch_n_lzsa	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH


; tree corridor4 (with generator switch)
location23:
	.byte	17		; north exit
	.byte	15		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.byte	$ff		; special exit
	.word	tree4_n_lzsa	; north bg
	.word	tree4_s_lzsa	; south bg
	.word	$0000		; east bg
	.word	tree4_w_lzsa	; west bg
	.byte	$ff,$ff		; special x
	.byte	$ff,$ff		; special y
	.word	$0000		; special function
	.byte	BG_NORTH|BG_SOUTH|BG_WEST
















; Looking North, click enter, go to north exit
; Looking South, click enter, go to south exit
; Looking East, click enter, go to east exit

; Looking North, if east_bg then show left arrow






;.align $100
audio_red_page:
.incbin "audio/red_page.btc"
audio_link_noise:
.incbin "audio/link_noise.btc"

