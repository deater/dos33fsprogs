; Riven -- Dome Island, Projector Room, Middle

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk38_defines.inc"

riven_projector_mid:

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
        ; handle wahrks
        ;==========================
handle_wahrks:
	; if 11 or less, go left wahrk
        ; if 29 or more, go right wahrk
        ; otherwise, go close

        lda     CURSOR_X
        cmp     #29
        bcs     go_right_wahrk

        cmp     #12
        bcc     go_left_wahrk

	lda	#RIVEN_CLOSE

	jmp	done_dir

go_left_wahrk:
        lda     #RIVEN_WAHRK_L
	jmp	done_dir

go_right_wahrk:
        lda     #RIVEN_WAHRK_R

done_dir:

	sta	LOCATION

	lda	#LOAD_CLOSE
	sta	WHICH_LOAD

	lda	#DIRECTION_S
	sta	DIRECTION
	lda	#1
	sta	LEVEL_OVER

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

	lda	#<mid_n_open_zx02
	sta	location0+LOCATION_NORTH_BG
	lda	#>mid_n_open_zx02
	jmp	make_door_common

make_door_closed:

	lda	#<mid_n_zx02
	sta	location0+LOCATION_NORTH_BG
	lda	#>mid_n_zx02
make_door_common:
	sta	location0+LOCATION_NORTH_BG+1

	rts



	;==========================
	; includes
	;==========================

.include "graphics_mid/mid_graphics.inc"

.include "leveldata_mid.inc"
