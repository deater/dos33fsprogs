; Riven -- Jungle Island -- Stairs

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk41_defines.inc"

riven_jungle_tunnel2:

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
        ; handle split dir
        ;==========================
handle_split_dir1:

	; if 19 or less, go E
	; if 20, do nothing
	; if 21 or more, go W

	lda	CURSOR_X
	cmp	#21
	bcs	go_west

	cmp	#19
	bcc	go_east

	rts

go_west:
	lda	#LOAD_STAIRS
	sta	WHICH_LOAD

	lda	#RIVEN_UP1
	sta	LOCATION


	lda	#DIRECTION_W
	bne	done_dir	; bra

go_east:
	lda	#LOAD_COVE
	sta	WHICH_LOAD

	lda	#RIVEN_DOWN1
	sta	LOCATION

	lda	#DIRECTION_E
done_dir:
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER

	rts


	;==========================
        ; handle split dir2
        ;==========================
handle_split_dir2:

	; if 14 or less, go N
	; if 15 or more, go E

	lda	CURSOR_X
	cmp	#15
	bcs	go_east2

go_north2:
	lda	#LOAD_STAIRS
	sta	WHICH_LOAD

	lda	#RIVEN_STAIRS
	sta	LOCATION


	lda	#DIRECTION_N
	bne	done_dir2	; bra

go_east2:
	lda	#LOAD_COVE
	sta	WHICH_LOAD

	lda	#RIVEN_DOWN1
	sta	LOCATION

	lda	#DIRECTION_E
done_dir2:
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER

	rts




	;==========================
	; includes
	;==========================


.include "graphics_stairs/stairs_graphics.inc"

.include "leveldata_stairs.inc"
