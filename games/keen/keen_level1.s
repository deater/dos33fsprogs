; Keen PoC Level 1

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

keen_start:
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
	sta	KEEN_WALKING
	sta	KEEN_JUMPING
	sta	LEVEL_OVER
	sta	LASER_OUT
	sta	KEEN_XL
	sta	SCORE0
	sta	SCORE1
	sta	SCORE2
	sta	KEEN_FALLING
	sta	KEEN_SHOOTING
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
	sta	KEEN_X
	lda	#0
	sta	KEEN_Y
	lda	#1
	sta	KEEN_DIRECTION


	jsr	update_status_bar

	;====================================
	; load level1 background
	;====================================

	lda	#<level1_bg_zx02
	sta	ZX0_src
	lda	#>level1_bg_zx02
	sta	ZX0_src+1

	lda	#$c    ; load to page $c00

	jsr	full_decomp


	;====================================
	; load level1 tilemap
	;====================================

        lda	#<level1_data_zx02
	sta	ZX0_src
        lda	#>level1_data_zx02
	sta	ZX0_src+1
	lda	#$90			; load to page $9000
	jsr	full_decomp

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

keen_loop:

	; copy over background

	jsr	gr_copy_to_current

	; draw tilemap

	jsr	draw_tilemap

	; draw enemies

	jsr	draw_enemies

	; draw laser

	jsr	draw_laser

	; draw keen

	jsr	draw_keen

	; handle door opening

	jsr	check_open_door

	; draw a status bar

	jsr	draw_status_bar

	jsr	page_flip

	jsr	handle_keypress

	jsr	move_keen

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
	beq	do_keen_loop

	jmp	done_with_keen




do_keen_loop:

	; delay
;	lda	#200
;	jsr	WAIT

	jmp	keen_loop


done_with_keen:
	bit	KEYRESET	; clear keypress


        lda     #LOAD_KEEN2
        sta     WHICH_LOAD

	rts			; exit back


	;==========================
	; includes
	;==========================

	; level graphics
level1_bg_zx02:
	.incbin	"graphics/level1_bg.gr.zx02"

	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
	.include	"gr_copy.s"
	.include	"gr_pageflip.s"
	.include	"gr_putsprite_crop.s"
	.include	"zx02_optim.s"

	.include	"status_bar.s"
	.include	"keyboard.s"
	.include	"joystick.s"

	.include	"text_drawbox.s"
	.include	"print_help.s"
	.include	"quit_yn.s"
	.include	"level_end.s"

	.include	"draw_keen.s"
	.include	"keen_sprites.inc"
	.include	"move_keen.s"
	.include	"handle_laser.s"
	.include	"draw_tilemap.s"
	.include	"enemies_level1.s"
	.include	"actions_level1.s"
	.include	"item_level1.s"

	.include	"sound_effects.s"
	.include	"speaker_tone.s"

level1_data_zx02:
	.incbin		"maps/level1_map.zx02"
