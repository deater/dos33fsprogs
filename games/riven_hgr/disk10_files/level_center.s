; Riven -- Inside Rotate room, center

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "../zp.inc"
	.include "../hardware.inc"
	.include "../common_defines.inc"
	.include "../qload.inc"
	.include "disk10_defines.inc"

center_start:

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


	;===========================
	; go to a particular pillar
	;===========================

; weird order to keep branch < 128 bytes

go_pillar_3:
	lda	#3
	bne	pillar_common		; bra
go_pillar_4:
	lda	#4
	bne	pillar_common		; bra
go_pillar_5:
	lda	#5
	bne	pillar_common		; bra
go_pillar_1:
	lda	#1
	bne	pillar_common		; bra
go_pillar_2:
	lda	#2
;	bne	pillar_common		; bra

pillar_common:
	sta	WHICH_PILLAR

	lda     #LOAD_PILLARS
	sta     WHICH_LOAD

	lda	#RIVEN_BEETLE_R
	sta     LOCATION

	lda     #DIRECTION_S
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER
	rts


	;==========================
	; move 51
	;==========================
move_51:
	; if 5 or less, go to center 45
	; if 12 or less, go to pillar 5
	; if 28 or more, go to pillar 1
	; if 34 or more, go to center 12
	; otherwise, go directly to level 15

	lda	CURSOR_X
	cmp	#6
	bcc	go_center_45		; blt
	cmp	#13
	bcc	go_pillar_5		; blt

	cmp	#34
	bcs	go_center_12		; bge
	cmp	#28
	bcs	go_pillar_1		; bge

	; go to level_15

	lda     #LOAD_15
	sta     WHICH_LOAD

	lda	#RIVEN_15
	jmp	go_edge

	;==========================
	; move 45
	;==========================
move_45:
	; if 5 or less, go to center 34
	; if 12 or less, go to pillar 4
	; if 28 or more, go to pillar 5
	; if 34 or more, go to center 51
	; otherwise, go directly to level 54

	lda	CURSOR_X
	cmp	#6
	bcc	go_center_34		; blt
	cmp	#13
	bcc	go_pillar_4		; blt

	cmp	#34
	bcs	go_center_51		; bge
	cmp	#28
	bcs	go_pillar_5		; bge

	rts



	;==========================
	; move 34
	;==========================
move_34:
	; if 5 or less, go to center 23
	; if 12 or less, go to pillar 3
	; if 28 or more, go to pillar 4
	; if 34 or more, go to center 45
	; otherwise, go directly to level 34

	lda	CURSOR_X
	cmp	#6
	bcc	go_center_23		; blt
	cmp	#13
	bcc	go_pillar_3		; blt

	cmp	#34
	bcs	go_center_45		; bge
	cmp	#28
	bcs	go_pillar_4		; bge

	; go to level_34

	rts


	;==========================
	; move 23
	;==========================
move_23:
	; if 5 or less, go to center 12
	; if 12 or less, go to pillar 2
	; if 28 or more, go to pillar 3
	; if 34 or more, go to center 34
	; otherwise, go directly to level 34

	lda	CURSOR_X
	cmp	#6
	bcc	go_center_12		; blt
	cmp	#13
	bcc	go_pillar_2		; blt

	cmp	#34
	bcs	go_center_34		; bge
	cmp	#28
	bcs	go_pillar_3		; bge

	; go to level_23

	rts

	;==========================
	; move 12
	;==========================
move_12:
	; if 5 or less, go to center 51
	; if 12 or less, go to pillar 1
	; if 28 or more, go to pillar 2
	; if 34 or more, go to center 23
	; otherwise, go directly to level 12

	lda	CURSOR_X
	cmp	#6
	bcc	go_center_51		; blt
	cmp	#13
	bcc	go_pillar_1		; blt

	cmp	#34
	bcs	go_center_23		; bge
	cmp	#28
	bcs	go_pillar_2		; bge

	; go to level_23

	rts

	;======================
	; go to edge room
	;======================

go_edge:
	sta     LOCATION

	lda     #DIRECTION_S
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER
	rts


	;============================
	; go to next center location
	; move around ring
	;============================

go_center_12:
	lda     #RIVEN_CENTER_12
	jmp	done_center
go_center_23:
	lda     #RIVEN_CENTER_23
	jmp	done_center
go_center_34:
	lda     #RIVEN_CENTER_34
	jmp	done_center
go_center_45:
	lda     #RIVEN_CENTER_45
	jmp	done_center
go_center_51:
	lda     #RIVEN_CENTER_51
done_center:
	sta     LOCATION

	lda     #LOAD_CENTER
	sta     WHICH_LOAD

	lda     #DIRECTION_N
	sta	DIRECTION

	lda	#1
	sta	LEVEL_OVER
	rts




	;==========================
	; includes
	;==========================


.include "graphics_center/center_graphics.inc"

.include "leveldata_center.inc"





