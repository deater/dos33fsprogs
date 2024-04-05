; Keen PoC Level 1

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"


MAX_TILE_X = 96		; 116 - 20
MAX_TILE_Y = 5		; (34 - 24)/2 (maybe?)

keen_start:
	;===================
	; init screen
;	jsr	TEXT
;	jsr	HOME
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

	lda	#4
	sta	DRAW_PAGE

	; Level 1
	; start at 2,24 (remember tiles 2 bytes high even though 4 pixels)
	; 	but with reference to starting tilemap (0,5) should be
	;		2,8?

	lda	#2
	sta	KEEN_X
	lda	#24
	sta	KEEN_Y
	lda	#1
	sta	KEEN_DIRECTION

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
	; we copy in full screen, 40x48 = 20x12 tiles
	;	we start out assuming position is 0,5

	lda	#0
	sta	TILEMAP_X
	lda	#5
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

	; handle door opening

;	jsr	check_open_door

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
	beq	do_keen_loop

	jmp	done_with_keen

do_keen_loop:

	; delay
;	lda	#200
;	jsr	WAIT

	jmp	keen_loop


done_with_keen:
	bit	KEYRESET	; clear keypress


        lda     #LOAD_MARS
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

level1_data_zx02:
	.incbin		"maps/level1_map.zx02"
