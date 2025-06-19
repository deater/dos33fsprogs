; Peasant's Quest

; Pebble Lake West (Location 4,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = lake_west_verb_table

lake_west_core:

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

;	lda	#$60
	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;==================
	; increment frame

	inc	FRAME

	;====================
	; check keyboard

	jsr	check_keyboard


	;===================
	; level specific
	;=====================

at_lake_west:
	jsr	animate_bubbles_w

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

.if 0
.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"



;.include "../hgr_routines/hgr_page_flip.s"
.include "../hgr_routines/hgr_copy_fast.s"



;.include "../wait.s"
.endif

.include "../location_common/include_bottom.s"
.include "../hgr_routines/hgr_sprite.s"
.include "lake_west_actions.s"
.include "sprites_lake_west/bubble_sprites_w.inc"
.include "animate_bubbles.s"
