; Riven -- Inside Rotate room, area 32

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk10_defines.inc"

room_32_start:

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

; done in title

;	lda	#$20
;	sta	HGR_PAGE
;	jsr	hgr_make_tables

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
	; move to center
	;==========================
move_to_center:

	; if 17 or less, go to center_45
	; if 23 or more, go to center_51
	; otherwise, go directly to pillar 5(?)

	lda	CURSOR_X
	cmp	#18
	bcc	go_center_45		; blt

	cmp	#23
	bcs	go_center_51		; bge

	; do nothing

	rts

go_center_45:
	lda     #LOAD_CENTER
	sta     WHICH_LOAD

	lda     #RIVEN_CENTER_45
	sta     LOCATION

	jmp	done_dir

go_center_51:
	lda	#LOAD_CENTER
	sta	WHICH_LOAD

	lda     #RIVEN_CENTER_51
	sta     LOCATION

done_dir:
	lda     #DIRECTION_N
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER
	rts

	;==========================
	; includes
	;==========================


.include "graphics_32/32_graphics.inc"

.include "leveldata_32.inc"