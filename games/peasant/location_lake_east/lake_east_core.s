; Peasant's Quest

; Peblle Lake East (Location 4,3)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = lake_east_verb_table

lake_east_core:

.include "../location_common/common_core.s"

	;====================================================
	; clear the keyboard in case we were holding it down

	bit     KEYRESET

	;=================================
	;=================================
	;=================================
	; main loop
	;=================================
	;=================================
	;=================================

game_loop:
	;====================
	; check keyboard

	jsr	check_keyboard

	;==============
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;===================
	; level specific


	;===================
	; update screen

	jsr	update_screen

	;==================
	; increment frame

	inc	FRAME

	;==================
	; increment flame

	jsr	increment_flame


	;=====================
	; flip page

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop


	;========================
	; exit level
	;========================
oops_new_location:
level_over:

	;===============================
	; handle end of level
	;===============================

.include "../location_common/end_of_level_common.s"

	;======================================
	; special case leaving-level borders

.include "borders.s"

really_level_over:
	rts



.include "../location_common/include_bottom.s"

.include "../hgr_routines/hgr_sprite.s"
.include "../hgr_routines/hgr_sprite_mask.s"

.include "lake_east_actions.s"
.include "sprites_lake_east/boat_sprites.inc"
.include "sprites_lake_east/boat_sprites_fish.inc"
.include "sprites_lake_east/bubble_sprites_e.inc"
.include "sprites_lake_east/throw_sprites.inc"

.include "animate_bubbles.s"
.include "animate_fish.s"
.include "../wait_a_bit.s"


	;=====================
	; update screen
	;=====================

update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;===========================
	; draw dude/boat

	jsr	draw_dude


	;===========================
	; draw bubbles
	;	she is the joy and laughter

	jsr	animate_bubbles_e


	;=====================
	; almost always draw peasant

	lda	SUPPRESS_PEASANT
	bne	skip_peasant

	jsr	draw_peasant
skip_peasant:

	rts


	;===========================
        ; draw dude in boat
	;===========================
draw_dude:
	lda	GAME_STATE_1
	and	#FISH_FED
	bne	done_dude

	lda	FRAME
	and	#$8
	beq	draw_boat1

draw_boat0:
	lda	#<boat0
	sta	INL
	lda	#>boat0
	jmp	done_choose_boat
draw_boat1:
	lda	#<boat1
	sta	INL
	lda	#>boat1

done_choose_boat:
        sta     INH

        lda     #1
        sta     CURSOR_X
        lda     #70
        sta     CURSOR_Y

        jsr     hgr_draw_sprite

done_dude:
	rts

sprites_data_l:
	.byte <throw_sprite0,<throw_sprite1,<throw_sprite2
	.byte <throw_sprite3,<throw_sprite4,<throw_sprite5
	.byte <throw_sprite6
	.byte <feed_sprite0,<feed_sprite1,<feed_sprite2,<feed_sprite3

sprites_data_h:
	.byte >throw_sprite0,>throw_sprite1,>throw_sprite2
	.byte >throw_sprite3,>throw_sprite4,>throw_sprite5
	.byte >throw_sprite6
	.byte >feed_sprite0,>feed_sprite1,>feed_sprite2,>feed_sprite3

sprites_mask_l:
	.byte <throw_mask0,<throw_mask1,<throw_mask2
	.byte <throw_mask3,<throw_mask4,<throw_mask5
	.byte <throw_mask6
	; mask and sprite are the same
	.byte <feed_sprite0,<feed_sprite1,<feed_sprite2,<feed_sprite3

sprites_mask_h:
	.byte >throw_mask0,>throw_mask1,>throw_mask2
	.byte >throw_mask3,>throw_mask4,>throw_mask5
	.byte >throw_mask6
	.byte >feed_sprite0,>feed_sprite1,>feed_sprite2,>feed_sprite3

sprites_xsize:
	.byte 2,2,2
	.byte 2,2,2
	.byte 2
	.byte 2,2,2,2
sprites_ysize:
	.byte 30,30,30
	.byte 30,30,30
	.byte 30
	.byte 10,11,10,8
