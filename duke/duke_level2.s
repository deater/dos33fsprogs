; Duke Level2 -- Living Dangerously

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

duke_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	TEXTGR

	jsr	clear_top	; avoid grey stripes at load

	;=====================
	; init vars
	;=====================

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	DISP_PAGE
	sta	DUKE_WALKING
	sta	DUKE_JUMPING
	sta	LEVEL_OVER
	sta	LASER_OUT
	sta	DUKE_XL
	sta	DUKE_FALLING
	sta	DUKE_SHOOTING
	sta	KICK_UP_DUST
	sta	DOOR_ACTIVATED

	lda	#<enemy_data
	sta	ENEMY_DATAL
	lda	#>enemy_data
	sta	ENEMY_DATAH

	lda	#2			; draw twice (both pages)
	sta	UPDATE_STATUS

	lda	#4
	sta	DRAW_PAGE

	lda	#18
	sta	DUKE_X
	lda	#0
	sta	DUKE_Y
	lda	#1
	sta	DUKE_DIRECTION


	jsr	update_status_bar

	;====================================
	; load level1 background
	;====================================

        lda	#<level2_bg_lzsa
	sta	LZSA_SRC_LO
        lda	#>level2_bg_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	;====================================
	; load level1 tilemap
	;====================================

        lda	#<level2_data_lzsa
	sta	LZSA_SRC_LO
        lda	#>level2_data_lzsa
	sta	LZSA_SRC_HI
	lda	#$90			; load to page $9000
	jsr	decompress_lzsa2_fast

	;====================================
	; copy in tilemap subset
	;====================================
	lda	#10
	sta	TILEMAP_X
	lda	#18
	sta	TILEMAP_Y

	jsr	copy_tilemap_subset

	;====================================
	;====================================
	; Main LOGO loop
	;====================================
	;====================================

duke_loop:

	; copy over background

	jsr	gr_copy_to_current

	; draw tilemap

	jsr	draw_tilemap

	; draw enemies

	jsr	draw_enemies

	; draw laser

	jsr	draw_laser

	; draw duke

	jsr	draw_duke

	; handle door opening

	jsr	check_open_door

	; draw a status bar

	jsr	draw_status_bar

	jsr	page_flip

	jsr	handle_keypress

	jsr	move_duke

;	jsr	move_enemies

	jsr	move_laser


	;========================
	; increment frame count
	;========================

	inc	FRAMEL
	bne	no_frame_oflo
	inc	FRAMEH
no_frame_oflo:

	;===========================
	; check end of level
	;===========================

	lda	LEVEL_OVER
	beq	do_duke_loop

	jmp	done_with_duke




do_duke_loop:

	; delay
;	lda	#200
;	jsr	WAIT

	jmp	duke_loop


done_with_duke:
	bit	KEYRESET	; clear keypress

	rts			; exit back


	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics/level2_graphics.inc"

	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
	.include	"gr_copy.s"
	.include	"gr_pageflip.s"
	.include	"gr_putsprite_crop.s"
	.include	"decompress_fast_v2.s"

	.include	"status_bar.s"
	.include	"keyboard.s"
	.include	"joystick.s"

	.include	"text_drawbox.s"
	.include	"print_help.s"
	.include	"quit_yn.s"
	.include	"level_end.s"

	.include	"draw_duke.s"
	.include	"move_duke.s"
	.include	"handle_laser.s"
	.include	"draw_tilemap.s"
	.include	"enemies.s"
	.include	"actions.s"

	.include	"sound_effects.s"
	.include	"speaker_tone.s"

level2_data_lzsa:
	.incbin		"maps/level2_map.lzsa"
