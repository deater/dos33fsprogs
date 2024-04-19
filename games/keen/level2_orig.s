; Keen PoC Level 2 (First Shrine)

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

	.include "level2_data.inc"


level2_start:
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

	lda	#START_KEEN_TILEX
	sta	KEEN_TILEX
	lda	#START_KEEN_TILEY
	sta	KEEN_TILEY

	lda	#0			; offset from tile location
	sta	KEEN_X
	sta	KEEN_Y

	lda	#RIGHT			; direction
	sta	KEEN_DIRECTION


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
	; we copy in full screen, 40x48 = 20x12 tiles
	;	we start out assuming position is 0,5

	lda	#START_TILEMAP_X
	sta	TILEMAP_X
	lda	#START_TILEMAP_Y
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
	beq	level1_levelover

	cmp	#GAME_OVER
	beq	level1_gameover

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
	bpl	level1_levelover

level1_gameover:

	; mars plays the sound

	lda	#GAME_OVER
	sta	LEVEL_OVER

level1_levelover:

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
	.include	"level1_enemies.s"
	.include	"level1_items.s"

	.include	"level1_sfx.s"
	.include	"longer_sound.s"

	.include	"random16.s"

	.include	"tilemap_lookup.s"

level1_data_zx02:
	.incbin		"maps/level2_map.zx02"


oracle_message:
	;      012345678901234567890123456789012345678
	.byte 2,21,"YOU HEAR IN YOUR MIND:",0
	.byte 2,22,"IT IS TOO BAD THAT YOU CANNOT READ",0
	.byte 2,23,"THE STANDARD GALACTIC ALPHABET, HUMAN",0
