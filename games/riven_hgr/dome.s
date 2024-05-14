; Riven -- Dome Island

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

riven_dome:

	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	HOME
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

	jmp	really_exit


	;==========================
	; includes
	;==========================

	.include	"zx02_optim.s"

	.include	"keyboard.s"

	.include	"hgr_14x14_sprite.s"
	.include	"draw_pointer.s"

	.include	"log_table.s"

.include "graphics_dome/dome_graphics.inc"

.include "common_sprites.inc"

.include "leveldata_dome.inc"
