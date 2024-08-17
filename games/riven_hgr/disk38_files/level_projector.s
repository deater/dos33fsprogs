; Riven -- Dome Island, Projector Room area

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk38_defines.inc"

riven_projector:

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

	; open/shut door

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
        ; update temple door
        ;==========================

	; update data to point to right image
update_temple_door:
	lda	STATE_DOORS
	and	#TEMPLE_DOOR
	beq	make_door_closed

make_door_open:
	lda	#$E0
	sta	location0+LOCATION_NORTH_EXIT

	lda	#<projector_n_open_zx02
	sta	location0+LOCATION_NORTH_BG
	lda	#>projector_n_open_zx02
	jmp	make_door_common

make_door_closed:
	lda	#$FF
	sta	location0+LOCATION_NORTH_EXIT

	lda	#<projector_n_zx02
	sta	location0+LOCATION_NORTH_BG
	lda	#>projector_n_zx02
make_door_common:
	sta	location0+LOCATION_NORTH_BG+1

	rts



	;==========================
	; includes
	;==========================

.include "graphics_projector/projector_graphics.inc"

.include "leveldata_projector.inc"
