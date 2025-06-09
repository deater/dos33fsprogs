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

	;==============
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;===========================
	; copy bg to current screen

	lda	#$60
	jsr	hgr_copy_fast

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;==================
	; increment frame

	inc	FRAME

	;===================
	; level specific
	;=====================

at_lake_east:
	jsr	animate_bubbles_e

        ; draw dude

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

	;====================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop

oops_new_location:
;	jmp	new_location


	;========================
	; exit level
	;========================
level_over:

	; FIXME: check for load from savegame if modifying game state

	rts

.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

.include "lake_east_actions.s"

;.include "../hgr_routines/hgr_page_flip.s"
.include "../hgr_routines/hgr_copy_fast.s"

.include "../hgr_routines/hgr_sprite.s"

.include "sprites_lake_east/boat_sprites.inc"
.include "sprites_lake_east/bubble_sprites_e.inc"

.include "animate_bubbles.s"

;.include "../wait.s"
