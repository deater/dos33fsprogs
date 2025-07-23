; Peasant's Quest

; o/~ By the beautiful, the beautiful river o/~  (location 4,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = river_stone_verb_table

peasantry_river_core:

.include "../location_common/common_core.s"

	;===================================
	; mark location visited

	lda	VISITED_1
	ora	#MAP_RIVER_STONE
	sta	VISITED_1

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET



	;================================
	;================================
	;================================
	; main loop
	;================================
	;================================
	;================================
game_loop:

	;====================
	; check keyboard

	jsr	check_keyboard

	;====================
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; update screen

	jsr	update_screen

	;====================
	; increment frame

	inc	FRAME

	;===================
	; increment flame

	jsr	increment_flame


	;====================
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
.include "river_actions.s"

.include "animate_river.s"
.include "sprites_river/river_current_sprites.inc"
.include "sprites_river/river_night_sprites.inc"

	;==========================
	; update screen
	;==========================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;====================
	; always draw peasant

	jsr	draw_peasant

	;=======================
	; handle river animation
	;=======================

	jsr	animate_river



	rts
