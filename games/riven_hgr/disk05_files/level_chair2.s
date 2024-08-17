; Riven -- chair room part 2

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk05_defines.inc"

chair2_start:

	;===================
	; init screen
	;===================

;	jsr	TEXT
;	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE1
	bit	HIRES
	bit	FULLGR

	;========================
	; set up location
	;========================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H

	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER

	lda	#0
	sta	JOYSTICK_ENABLED
	sta	UPDATE_POINTER

	lda	#1
	sta	CURSOR_VISIBLE

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y




	;===================================
	; init
	;===================================

	; update the temple door switch if open/closed

	jsr	update_temple_door

	jsr	change_location

	jsr     save_bg_14x14           ; save old bg

game_loop:

	;===================================
	; draw pointer
	;===================================

	jsr	draw_pointer

	;===================================
	; handle keypress/joystick
	;===================================

	jsr	handle_keypress

	;===================================
	; increment frame count
	;===================================

	inc	FRAMEL
	bne	frame_no_oflo

	inc	FRAMEH
frame_no_oflo:

	;====================================
	; check level over
	;====================================

	lda	LEVEL_OVER
	bne	really_exit

	jmp	game_loop

really_exit:

	rts


	;==========================
	; temple door switch
	;==========================
temple_door_switch:

	bit	SPEAKER

	; toggle switch

	lda	STATE_DOORS
	eor	#TEMPLE_DOOR
	sta	STATE_DOORS

	jsr	update_temple_door

	lda     #1
	sta     LEVEL_OVER

	rts


	;==========================
	; update temple door
	;==========================

	; update data to point to right image
update_temple_door:
	lda	STATE_DOORS
	and	#TEMPLE_DOOR
	beq	make_door_closed

make_door_open:
	lda	#<porthole_l_open_s_zx02
	sta	location2+LOCATION_SOUTH_BG
	lda	#>porthole_l_open_s_zx02
	jmp	make_door_common

make_door_closed:
	lda	#<porthole_l_closed_s_zx02
	sta	location2+LOCATION_SOUTH_BG
	lda	#>porthole_l_closed_s_zx02
make_door_common:
	sta	location2+LOCATION_SOUTH_BG+1

	rts

	;==========================
	; handle chair3
	;==========================
chair3_handler:

	; first check if lowering button pressed
	; if Y in certain range, check button pressed


	; if Ypos greater than 128 do nothing unless it's the button

	lda	CURSOR_Y
	cmp	#128
	bcc	check_exits

	; check if between 146 and 166
	cmp	#146
	bcc	do_nothing
	cmp	#166
	bcs	do_nothing

	lda	CURSOR_X
	cmp	#32
	bcc	do_nothing
	cmp	#37
	bcs	do_nothing

	; if got here, was switch

	lda	#RIVEN_CHAIR3_DOWN
exit_location_common:
	sta	LOCATION

	lda	#1
	sta	LEVEL_OVER

do_nothing:

	rts

check_exits:

	; if 10 or less, go to left portal
	; if 30 or more, go to right portal
	; else go forward as normal

	lda	CURSOR_X
	cmp	#11
	bcc	go_left

	cmp	#30
	bcs	go_right

go_straight:

	lda	#RIVEN_CHAIR2
	jmp	exit_location_common

go_left:
	lda	#RIVEN_PORTHOLE_L
	jmp	exit_location_common

go_right:
	lda	#RIVEN_PORTHOLE_R
	jmp	exit_location_common


	;==========================
	; chair3 flip switch
	;==========================
	; can only do this when button pressed to lower ribs
	; really just changes the switch direction?
chair3_flip:

	bit	SPEAKER


	lda	#RIVEN_CHAIR3_DOWN_FLIP
	sta	LOCATION

	lda     #1
	sta     LEVEL_OVER

	rts


	;==========================
	; chair3 done button
	;==========================
	; just go back to regular chair3
chair3_done:

	bit	SPEAKER


	lda	#RIVEN_CHAIR3
	sta	LOCATION

	lda     #1
	sta     LEVEL_OVER

	rts


	;==========================
	; includes
	;==========================


.include "graphics_chair2/chair2_graphics.inc"

.include "leveldata_chair2.inc"
