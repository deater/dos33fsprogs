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

	lda	#<location0
	sta	LOCATION_STRUCT_L
	lda	#>location0
	sta	LOCATION_STRUCT_H


setup_room:

	; load background
	lda	#>(link_book_rle)
	sta	GBASH
	lda	#<(link_book_rle)
	sta	GBASL
	lda	#$c			; load to page $c00
	jsr	load_rle_gr


game_loop:

	;====================================
	; copy background to current page
	;====================================

	jsr	gr_copy_to_current

	;====================================
	; draw pointer
	;====================================
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
	lda     #<finger_grab_sprite
	sta	INL
	lda     #>finger_grab_sprite
	jmp	finger_draw

finger_not_special:


finger_point:
	lda     #<finger_point_sprite
	sta	INL
	lda     #>finger_point_sprite
	jmp	finger_draw

finger_left:
	lda     #<finger_left_sprite
	sta	INL
	lda     #>finger_left_sprite
	jmp	finger_draw

finger_right:
	lda     #<finger_right_sprite
	sta	INL
	lda     #>finger_right_sprite
	jmp	finger_draw



finger_draw:
	sta	INH
	jsr	put_sprite_crop

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

	jmp	done_keypress



done_keypress:
no_keypress:
	bit	KEYRESET
	rts


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




locations:
	.word location0,location1

; myst linking book
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$00		; special exit
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	21,31		; special x
	.byte	10,24		; special y
	.word	$0000		; special function

; dock
location1:
	.byte	$ff		; north exit
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

