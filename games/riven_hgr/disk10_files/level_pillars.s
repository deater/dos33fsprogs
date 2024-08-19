; Riven -- Inside Rotate room, Pillars

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk10_defines.inc"

pillars_start:

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

	; set up proper stained glass

	ldx	WHICH_PILLAR
	dex				; 1 indexed -> 0 indexed
	lda	stained_bg_l,X
	sta	location2+LOCATION_SOUTH_BG
	lda	stained_bg_h,X
	sta	location2+LOCATION_SOUTH_BG+1


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

	; if 9 or less, left
	; if 31 or more, right
	; otherwise look at beetle

	lda	CURSOR_X
	cmp	#10
	bcc	go_left			; blt

	cmp	#31
	bcs	go_right		; bge

	; look at beetle

	lda     #LOAD_PILLARS
	sta     WHICH_LOAD

	lda     #RIVEN_BEETLE_R_OPEN
	sta     LOCATION

	lda     #DIRECTION_S
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER
	rts

	rts

go_left:
	ldx	WHICH_PILLAR	; 1-indexed
	dex
	lda	left_lookup,X

	jmp	go_common

go_right:
	ldx	WHICH_PILLAR	; 1-indexed
	dex
	lda	right_lookup,X

go_common:

	sta     LOCATION

	lda     #LOAD_CENTER
	sta     WHICH_LOAD

	lda     #DIRECTION_N
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER

	rts


	;==========================
	; view_stained
	;==========================
	; if clicked, view stained glass
view_stained:

	lda     #LOAD_PILLARS
	sta     WHICH_LOAD

	lda     #RIVEN_STAINED
	sta     LOCATION

	lda     #DIRECTION_S
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER
	rts


	;==========================
	; stained glass tables

stained_bg_l:
	.byte <stained01_zx02
	.byte <stained02_zx02
	.byte <stained03_zx02
	.byte <stained04_zx02
	.byte <stained05_zx02

stained_bg_h:
	.byte >stained01_zx02
	.byte >stained02_zx02
	.byte >stained03_zx02
	.byte >stained04_zx02
	.byte >stained05_zx02

left_lookup:
	.byte	RIVEN_CENTER_51		; 1
	.byte	RIVEN_CENTER_12		; 2
	.byte	RIVEN_CENTER_23		; 3
	.byte	RIVEN_CENTER_34		; 4
	.byte	RIVEN_CENTER_45		; 5


right_lookup:
	.byte	RIVEN_CENTER_12		; 1
	.byte	RIVEN_CENTER_23		; 2
	.byte	RIVEN_CENTER_34		; 3
	.byte	RIVEN_CENTER_45		; 4
	.byte	RIVEN_CENTER_51		; 5



	;==========================
	; includes
	;==========================


.include "graphics_pillars/pillars_graphics.inc"

.include "leveldata_pillars.inc"
