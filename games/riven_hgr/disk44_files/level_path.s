; Riven -- Jungle Island, initial path

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk44_defines.inc"

path_start:

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
        ; handle split dir
        ;==========================
handle_split_dir1:

	; if 19 or less, go to $E0
	; if 20, do nothing
	; if 21 or more, go to $E1

	lda	CURSOR_X
	cmp	#21
	bcs	go_right

	cmp	#19
	bcc	go_left

        rts

go_left:
	lda	#$E0
	sta	LEVEL_OVER
	rts

go_right:
	lda	#$E1
	sta	LEVEL_OVER
	rts

	;==========================
	; includes
	;==========================


.include "graphics_path/path_graphics.inc"

.include "leveldata_path.inc"
