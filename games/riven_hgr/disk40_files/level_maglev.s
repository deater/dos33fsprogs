; Riven -- Jungle Island -- Maglev

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk40_defines.inc"

riven_jungle_maglev:

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

	;=====================================
	; handle clicked facing west
	;=====================================
	; all we can do here is flip
	; flip us to the east
	; go lores and play the movie
handle1_clicked:

	bit	SPEAKER

	lda	#0
	sta	MAGLEV_FLIP_DIRECTION

	lda	#LOAD_MOVIE1
	sta	WHICH_LOAD

	lda	#1
	sta	LEVEL_OVER

	bit	SPEAKER

	rts

	;=====================================
	; handle clicked facing east
	;=====================================
	; if x<27, go for maglev ride
	; else, flip back west
handle2_clicked:

	bit	SPEAKER

	lda	CURSOR_X
	cmp	#27
	bcc	go_for_maglev

	lda	#1
	sta	MAGLEV_FLIP_DIRECTION

	lda	#LOAD_MOVIE1
	jmp	common_handle2

go_for_maglev:
	lda	#LOAD_MOVIE2

common_handle2:
	sta	WHICH_LOAD

	lda	#1
	sta	LEVEL_OVER

	bit	SPEAKER

	rts




	;==========================
	; includes
	;==========================


.include "graphics_maglev/maglev_graphics.inc"

.include "leveldata_maglev.inc"
