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


	.include	"common_sprites.inc"

	.include	"leveldata_island.inc"



;.align $100
audio_red_page:
.incbin "audio/red_page.btc"
audio_link_noise:
.incbin "audio/link_noise.btc"

