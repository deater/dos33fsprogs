; Duke PoC Level 1

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
	sta	JOYSTICK_ENABLED
	sta	DUKE_WALKING
	sta	DUKE_JUMPING
	sta	LEVEL_OVER
	sta	LASER_OUT
	sta	DUKE_XL
	sta	SCORE0
	sta	SCORE1
	sta	SCORE2
	sta	DUKE_FALLING
	sta	DUKE_SHOOTING
	sta	KICK_UP_DUST
	sta	DOOR_ACTIVATED
	sta	INVENTORY

	lda	#<enemy_data
	sta	ENEMY_DATAL
	lda	#>enemy_data
	sta	ENEMY_DATAH

	; FIXME: temporary
;	lda	INVENTORY
;	ora	#INV_RED_KEY
;	sta	INVENTORY

;	lda	#$10
;	sta	SCORE0

	lda	#1
	sta	FIREPOWER

	lda	#2			; draw twice (both pages)
	sta	UPDATE_STATUS

	lda	#7
	sta	HEALTH

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

        lda	#<level1_bg_lzsa
	sta	LZSA_SRC_LO
        lda	#>level1_bg_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	;====================================
	; load level1 tilemap
	;====================================

        lda	#<level1_data_lzsa
	sta	LZSA_SRC_LO
        lda	#>level1_data_lzsa
	sta	LZSA_SRC_HI
	lda	#$90			; load to page $9000
	jsr	decompress_lzsa2_fast

	;====================================
	; copy in tilemap subset
	;====================================
	lda	#28
	sta	TILEMAP_X
	lda	#0
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


        lda     #LOAD_DUKE2
        sta     WHICH_LOAD

	rts			; exit back


	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics/level1_graphics.inc"

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
	.include	"duke_sprites.inc"
	.include	"move_duke.s"
	.include	"handle_laser.s"
	.include	"draw_tilemap.s"
	.include	"enemies_level1.s"
	.include	"actions_level1.s"

	.include	"sound_effects.s"
	.include	"speaker_tone.s"

level1_data_lzsa:
	.incbin		"maps/level1_map.lzsa"
