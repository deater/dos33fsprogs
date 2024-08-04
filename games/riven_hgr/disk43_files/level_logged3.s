; Riven -- Jungle Island -- Logging area 3

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk43_defines.inc"

riven_logged3:

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

        ; if 19 or less, go to disk44
        ; if 20, do nothing
        ; if 21 or more, go W

	lda	CURSOR_X
	cmp	#21
	bcs	go_west

	cmp	#19
	bcc	go_disk44

	rts

go_west:
	lda	#LOAD_LOGGED4
	sta	WHICH_LOAD

	lda	#RIVEN_LOGGED4
	sta	LOCATION

        lda     #1
        sta     LEVEL_OVER



	lda	#DIRECTION_W
	bne	done_dir        ; bra

go_disk44:
        lda     #$E2
        sta     LEVEL_OVER

        lda     #DIRECTION_E
done_dir:
        sta     DIRECTION

        rts





	;==========================
	; includes
	;==========================


.include "graphics_logged3/logged3_graphics.inc"

.include "leveldata_logged3.inc"
