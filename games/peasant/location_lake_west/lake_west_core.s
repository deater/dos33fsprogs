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


	;==================
	; increment frame

	inc	FRAME



	;===================
	; level specific
	;=====================

	; FIXME: draw these in update screen?

at_lake_west:
	jsr	animate_bubbles_w

	;======================
	; update screen

	jsr	update_screen

	;===================
	; page flip


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

.include "../location_common/include_bottom.s"
.include "../hgr_routines/hgr_sprite.s"
.include "lake_west_actions.s"
.include "sprites_lake_west/bubble_sprites_w.inc"
.include "animate_bubbles.s"


	;========================
	; update screen
	;========================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant


	rts
