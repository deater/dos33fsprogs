; Cliff climb minigame from Peasant's Quest
;
; the actual climbing part

; by deater (Vince Weaver) <vince@deater.net>


.include "../zp.inc"
.include "../hardware.inc"

.include "../qload.inc"
.include "../text/dialog_climb.inc"
.include "../parse_input.inc"
.include "../common_defines.inc"

; defines

MAX_ROCKS	= 3

cliff_climb:

	jsr	reset_enemy_state

;	bit	HIRES			; init graphics
;	bit	FULLGR
;	bit	SET_GR
;	bit	PAGE1

	lda	#0			; init variables
	sta	LEVEL_OVER
	sta	FRAME
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	PEASANT_DIR		; 0 = up
	sta	PEASANT_STEPS
	sta	FLAME_COUNT
	sta	CLIMB_COUNT
	sta	MAP_LOCATION
	sta	PEASANT_FALLING
	sta	MAX_HEIGHT

	lda	#19				; starting location
	sta	PEASANT_X
	lda	#86
	sta	PEASANT_Y



	;========================
	; Load Peasant Sprites
	;========================
	; from disk to save ~1k
	; TODO: move other sprites in with it?

	lda	#LOAD_CLIMB_SPRITES
	sta	WHICH_LOAD

	jsr	load_file

	; loads to $6000 (peasant_sprites_temp)

	lda	#<peasant_sprites_temp
	sta	zx_src_l+1
	lda	#>peasant_sprites_temp
	sta	zx_src_h+1

	lda	#>peasant_sprites_location

	jsr	zx02_full_decomp


	; assume hi-res lookup table already loaded

	jsr	load_graphics

	;================================
	; decompress dialog to $D000

	lda	#<climb_text_zx02
	sta	zx_src_l+1
	lda	#>climb_text_zx02
	sta	zx_src_h+1

	lda	#>dialog_location

	jsr	zx02_full_decomp



	;==========================
	;==========================
	; main loop
	;==========================
	;==========================
game_loop:

	;===========================
	; erase bg

	jsr	erase_bg


	;=====================
	; move peasant

	jsr	move_peasant

	;=====================
	; draw peasant

	jsr	draw_peasant_climb


	;=====================
	;=====================
	; draw enemies
	;=====================
	;=====================

	;=====================
	; draw bird
	;=====================

	jsr	draw_bird

	;=====================
	; draw rocks
	;=====================

	jsr	draw_rocks

	;=====================
	;=====================
	; move enemies
	;=====================
	;=====================

	;=====================
	; bird

	jsr	move_bird

	;=====================
	; rocks

	jsr	move_rocks

	;=====================
	; increment frame

	inc	FRAME

	inc	FLAME_COUNT
	lda	FLAME_COUNT
	cmp	#3
	bne	flame_good


	lda	#0
	sta	FLAME_COUNT

flame_good:

	;=====================
	; check keyboard

	jsr	check_keyboard

	;===========================
	; check level over
	;	a few ways to get here
	;	0 = fine, keep going
	;	$FF = hit top of screen, go to next
	;	$FF = falling and going down to next
	;	$80 = falling, end of game, key pressed
	;	? = won game

	lda	LEVEL_OVER
	cmp	#$80
	beq	cliff_game_over

	lda	LEVEL_OVER
	bne	cliff_reload_bg


	jsr	hgr_page_flip

	; delay

	lda	#180		; adjust?
	jsr	wait

	jmp	game_loop




	;=======================
	; here if fell
	;=======================
cliff_game_over:


	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	;===========================================
	; print the message

	bit	KEYRESET

	ldx	#<climb_fallen_message
	ldy	#>climb_fallen_message
	stx	OUTL
	sty	OUTH
	jsr	print_text_message

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	rts			; will this work?


	;==========================
	; here if off top of screen
	;==========================

cliff_reload_bg:
	lda	MAP_LOCATION
	cmp	#3
	bcc	keep_on_climbing		; blt

	;========================
	; hit the top!

	; re-load proper sprite

	lda	#PEASANT_OUTFIT_ROBE		; always robe
	jsr	load_peasant_sprites


	lda	#LOCATION_CLIFF_HEIGHTS
	sta	MAP_LOCATION

	lda	#LOAD_HEIGHTS
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	rts

keep_on_climbing:
	jsr	reset_enemy_state

	jsr	load_graphics

	lda	#0
	sta	LEVEL_OVER

	jmp	game_loop


	;================================
	; load graphics
	;================================

load_graphics:

	;========================
	; Load Priority graphics
	;========================

	ldx	MAP_LOCATION
	lda     priority_data_l,X
	sta     zx_src_l+1
	lda     priority_data_h,X
	sta     zx_src_h+1

        lda     #>priority_temp			; temporarily load to $6000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	priority_copy

	; copy collision detection info

	ldx	#0
col_copy_loop:
	lda	collision_temp,X
	sta	collision_location,X
	inx
	bne	col_copy_loop


	;=============================


	;==========================
	; Load Background Graphics
	;===========================
	; one of the three map locations


	ldx	MAP_LOCATION

	lda	bg_data_l,X
	sta	zx_src_l+1
	lda	bg_data_h,X
	sta	zx_src_h+1

	;======================
	; to offscreen

	lda	#$60

	jsr	zx02_full_decomp


	;===================
	; put peasant text

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40		; write text to $6000
	sta	DRAW_PAGE

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	;===================
	; put score

	jsr	print_score


	;====================================
	; copy background to both PAGE1/PAGE2
	;====================================
	; glitchy but how better to do it?



	lda	#0
	sta	DRAW_PAGE
	jsr	hgr_copy_faster

	lda	#$20
	sta	DRAW_PAGE
	jsr	hgr_copy_faster

	lda	DRAW_PAGE_SAVE

	rts

	;===========================
	;===========================
	; reset enemy state
	;===========================
	;===========================

	; call this when restarting, also when move to new screen
reset_enemy_state:

	lda	#0
	sta	bird_out

	lda	#3
	sta	rock_state
	sta	rock_state+1
	sta	rock_state+2

	rts




	;====================================
	; includes

	.include	"rock_code.s"
	.include	"bird_code.s"

	.include	"keyboard_climb.s"

	.include	"draw_peasant_climb.s"

	.include	"move_peasant_climb.s"

	.include	"../priority_copy.s"

	.include	"erase_bg.s"

	.include	"../hgr_routines/hgr_sprite_mask.s"
	.include 	"../hgr_routines/hgr_sprite_bg_mask.s"

climb_text_zx02:
.incbin "../text/DIALOG_CLIMB.ZX02"


priority_data_l:
	.byte <priority_cliff1,<priority_cliff2,<priority_cliff3
priority_data_h:
	.byte >priority_cliff1,>priority_cliff2,>priority_cliff3

bg_data_l:
	.byte <bg_cliff1,<bg_cliff2,<bg_cliff3
bg_data_h:
	.byte >bg_cliff1,>bg_cliff2,>bg_cliff3

bg_cliff1:
	.incbin "../location_cliff_base/graphics_cliff/cliff_base.hgr.zx02"
bg_cliff2:
	.incbin "graphics_cliff/cliff2.hgr.zx02"
bg_cliff3:
	.incbin "graphics_cliff/cliff3.hgr.zx02"

priority_cliff1:
	.incbin "../location_cliff_base/graphics_cliff/cliff_base_priority.zx02"
priority_cliff2:
	.incbin "graphics_cliff/cliff2_priority.zx02"
priority_cliff3:
	.incbin "graphics_cliff/cliff3_priority.zx02"

sprites:
	.include "sprites/enemy_sprites.inc"

sprites_xsize:
	.byte	3, 3		; bird
	.byte	3, 3, 3, 3	; bigrock
	.byte 	3, 4		; bigrock_crash
	.byte	2, 2, 2, 2	; smallrock
	.byte 	2, 4		; smallrock_crash

sprites_ysize:
	.byte	16,14		; bird
	.byte	23,22,21,22	; bigrock
	.byte	18,21		; bigrock_crash
	.byte	15,14,15,14	; smallrock
	.byte	15,19		; smallrock_crash

sprites_data_l:
	.byte <bird0_sprite,<bird1_sprite
	.byte <bigrock0_sprite,<bigrock1_sprite
	.byte <bigrock2_sprite,<bigrock3_sprite
	.byte <bigrock_crash0_sprite,<bigrock_crash1_sprite
	.byte <smallrock0_sprite,<smallrock1_sprite
	.byte <smallrock2_sprite,<smallrock3_sprite
	.byte <smallrock_crash0_sprite,<smallrock_crash1_sprite
sprites_data_h:
	.byte >bird0_sprite,>bird1_sprite
	.byte >bigrock0_sprite,>bigrock1_sprite
	.byte >bigrock2_sprite,>bigrock3_sprite
	.byte >bigrock_crash0_sprite,>bigrock_crash1_sprite
	.byte >smallrock0_sprite,>smallrock1_sprite
	.byte >smallrock2_sprite,>smallrock3_sprite
	.byte >smallrock_crash0_sprite,>smallrock_crash1_sprite

sprites_mask_l:
	.byte <bird0_mask,<bird1_mask
	.byte <bigrock0_mask,<bigrock1_mask
	.byte <bigrock2_mask,<bigrock3_mask
	.byte <bigrock_crash0_mask,<bigrock_crash1_mask
	.byte <smallrock0_mask,<smallrock1_mask
	.byte <smallrock2_mask,<smallrock3_mask
	.byte <smallrock_crash0_mask,<smallrock_crash1_mask

sprites_mask_h:
	.byte >bird0_mask,>bird1_mask
	.byte >bigrock0_mask,>bigrock1_mask
	.byte >bigrock2_mask,>bigrock3_mask
	.byte >bigrock_crash0_mask,>bigrock_crash1_mask
	.byte >smallrock0_mask,>smallrock1_mask
	.byte >smallrock2_mask,>smallrock3_mask
	.byte >smallrock_crash0_mask,>smallrock_crash1_mask

	;========================================
	; data for the enemies

bird_out:
	.byte	0

bird_x:
	.byte	37
bird_y:
	.byte	75


rock_type:		; 0=big, 1=little
	.byte	0, 1, 0
rock_state:
	.byte 	3, 3, 3	; 0 = falling, 1,2 = exploding, 3 = waiting?
rock_x:
	.byte	7, 12, 17	; remember, /7
rock_y:
	.byte	12,12,12


peasant_sprites_xsize = peasant_sprites_location+0
peasant_sprites_ysize = peasant_sprites_location+34
peasant_sprites_data_l = peasant_sprites_location+68
peasant_sprites_data_h = peasant_sprites_location+102
peasant_mask_data_l = peasant_sprites_location+136
peasant_mask_data_h = peasant_sprites_location+170

;climbing_sprite_data:
;	.incbin "sprites/climbing_sprites.zx02"


erase_data_page1_x:
	.byte	$ff,$ff,$ff,$ff,$ff,$ff	; peasant/flame/bird/rock1/rock2/rock3
erase_data_page1_y:
	.byte	0,0,0,0,0,0	; peasant/flame/bird/rock1/rock2/rock3
erase_data_page1_xsize:
	.byte	3,4,3,5,5,5	; peasant/flame/bird/rock1/rock2/rock3
erase_data_page1_ysize:
	.byte	31,10,20,21,21,21	; peasant/flame/bird/rock1/rock2/rock3

erase_data_page2_x:
	.byte	$ff,$ff,$ff,$ff,$ff,$ff	; peasant/flame/bird/rock1/rock2/rock3
erase_data_page2_y:
	.byte	0,0,0,0,0,0	; peasant/flame/bird/rock1/rock2/rock3
erase_data_page2_xsize:
	.byte	3,4,3,5,5,5	; peasant/flame/bird/rock1/rock2/rock3
erase_data_page2_ysize:
	.byte	31,10,20,21,21,21	; peasant/flame/bird/rock1/rock2/rock3




climb_end:

.assert (>climb_end - >cliff_climb) < $30 , error, "climb too big"
