; Game Engine for Apple II Commander Keen

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

	.include "enemies.inc"

level_data	= $6000
	max_tile_x	= level_data+0
	max_tile_y	= level_data+1
	start_keen_tilex= level_data+2
	start_keen_tiley= level_data+3
	start_tilemap_x	= level_data+4
	start_tilemap_y	= level_data+5
	num_enemies	= level_data+6
	hardtop_tiles	= level_data+7
	allhard_tiles	= level_data+8
enemy_data	= $6100
	enemy_data_out		= enemy_data+0
	enemy_data_exploding	= enemy_data+8
	enemy_data_type		= enemy_data+16
	enemy_data_direction	= enemy_data+24
	enemy_data_tilex	= enemy_data+32
	enemy_data_tiley	= enemy_data+40
	enemy_data_x		= enemy_data+48
	enemy_data_y		= enemy_data+56
	enemy_data_state	= enemy_data+64
	enemy_data_count	= enemy_data+72

oracle_message	= $6200
level_data_zx02 = $6300

level_start:
	;===================
	; init screen

	bit	KEYRESET

	bit	SET_GR
	bit	PAGE1
	bit	LORES
	bit	FULLGR

	jsr	clear_top	; avoid grey stripes at load

	;=====================
	; init vars
	;=====================

	lda	max_tile_x
	sta	MAX_TILE_X
	sec
	sbc	#20
	sta	max_tilex_minus_20_smc+1
	lda	MAX_TILE_X
	sec
	sbc	#1
	sta	max_tilex_minus_1_smc+1

	lda	max_tile_y
	sta	MAX_TILE_Y
	sec
	sbc	#6
	sta	max_tiley_minus_6_smc+1

;	lda	start_keen_tilex
;	sta	START_KEEN_TILEX
;	lda	start_keen_tiley
;	sta	START_KEEN_TILEY
;	lda	start_tilemap_x
;	sta	START_TILEMAP_X
;	lda	start_tilemap_y
;	sta	START_TILEMAP_Y

	lda	num_enemies
	sta	NUM_ENEMIES
	lda	hardtop_tiles
	sta	HARDTOP_TILES
	lda	allhard_tiles
	sta	ALLHARD_TILES

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	KEEN_WALKING
	sta	KEEN_JUMPING
	sta	LEVEL_OVER
	sta	LASER_OUT
	sta	KEEN_XL
	sta	KEEN_FALLING
	sta	KEEN_SHOOTING
	sta	KEYCARDS
	sta	ORACLE_SPOKEN

	; debug

;	lda	#9
;	sta	RAYGUNS

	lda	#4
	sta	DRAW_PAGE

	; set starting location

	lda	start_keen_tilex
	sta	KEEN_TILEX
	lda	start_keen_tiley
	sta	KEEN_TILEY

	lda	#0			; offset from tile location
	sta	KEEN_X
	sta	KEEN_Y

	lda	#RIGHT			; direction
	sta	KEEN_DIRECTION


	;====================================
	; load tilemap
	;====================================

        lda	#<level_data_zx02
	sta	ZX0_src
        lda	#>level_data_zx02
	sta	ZX0_src+1
	lda	#$90			; load to page $9000
	jsr	full_decomp

	;====================================
	; copy in tilemap subset
	;====================================
	; we copy in full screen, 40x48 = 20x12 tiles
	;	we start out assuming position is 0,5

	lda	start_tilemap_x
	sta	TILEMAP_X
	lda	start_tilemap_y
	sta	TILEMAP_Y

	jsr	copy_tilemap_subset

	;====================================
	;====================================
	; Main loop
	;====================================
	;====================================

keen_loop:

	; draw tilemap

	jsr	draw_tilemap

	; draw enemies

	jsr	draw_enemies

	; draw laser

	jsr	draw_laser

	; draw keen

	jsr	draw_keen

	jsr	page_flip

	jsr	handle_keypress

	jsr	move_keen

	jsr	move_enemies

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
	bne	done_with_keen

	;===========================
	; delay
	;===========================

;	lda	#200
;	jsr	WAIT


	jmp	keen_loop


done_with_keen:
	bit	KEYRESET	; clear keypress

	; three reasons we could get here
	;	NEXT_LEVEL    = finished level by exiting door
	;	GAME_OVER     = hit ESC and said Y to QUIT
	;	TOUCHED_ENEMY = touched an enemy

	lda	LEVEL_OVER
	cmp	#NEXT_LEVEL
	beq	level_over

	cmp	#GAME_OVER
	beq	game_over

	; got here, touched enemy


	;============================
	; end animation
	;============================

	lda	#1
	sta	PLAY_END_SOUND

	inc	KEEN_TILEY		; move down

	sec
        lda     KEEN_TILEX
        sbc     TILEMAP_X
        asl
        clc
        adc     KEEN_X
        sta     XPOS

        sec
        lda     KEEN_TILEY
        sbc     TILEMAP_Y
        asl
        asl
        clc
        adc     KEEN_Y
        sta     YPOS

level_end_animation:
	jsr	draw_tilemap

	ldx	#<keen_sprite_squish
	lda	#>keen_sprite_squish
	stx	INL
	sta	INH
	jsr	put_sprite_crop

	jsr	page_flip

	lda	PLAY_END_SOUND
	beq	skip_end_sound

	ldy	#SFX_KEENDIESND
	jsr	play_sfx

	dec	PLAY_END_SOUND
skip_end_sound:


	lda	#50
	jsr	WAIT

	dec	YPOS
	dec	YPOS

	bpl	level_end_animation


	dec	KEENS
	bpl	level_over

game_over:

	; mars plays the sound

	lda	#GAME_OVER
	sta	LEVEL_OVER

level_over:

        lda     #LOAD_MARS
        sta     WHICH_LOAD

	rts			; exit back


	;==========================
	; includes
	;==========================

	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
	.include	"gr_pageflip.s"
	.include	"gr_putsprite_crop.s"
	.include	"zx02_optim.s"

	.include	"status_bar.s"
	.include	"keyboard.s"
	.include	"joystick.s"

	.include	"text_drawbox.s"
	.include	"text_help.s"
	.include	"text_quit_yn.s"

	.include	"draw_keen.s"
	.include	"sprites/keen_sprites.inc"
	.include	"move_keen.s"
	.include	"handle_laser.s"
	.include	"draw_tilemap.s"
	.include	"engine_enemies.s"
	.include	"engine_items.s"

	.include	"level1_sfx.s"
	.include	"longer_sound.s"

	.include	"random16.s"

	.include	"tilemap_lookup.s"
