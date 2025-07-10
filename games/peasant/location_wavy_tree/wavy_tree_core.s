; Peasant's Quest

; Wavy Tree and Ned (location 2,4)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = ned_verb_table

wavy_tree_core:

.include "../location_common/common_core.s"


	;======================
	; init ned
	;======================

	jsr	init_ned

	;===================================
	; mark location visited

	lda	VISITED_3
	ora	#MAP_WAVY_TREE
	sta	VISITED_3


	;====================================================
	; clear the keyboard in case we were holding it down

	bit     KEYRESET

	;===============================
	;===============================
	;===============================
	; main loop
	;===============================
	;===============================
	;===============================

game_loop:

	;=======================
	; check keyboard

	jsr	check_keyboard

	;===================
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;===================
	; update screen

	jsr	update_screen


	;====================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame


	;=====================
	; check keyboard

	jsr	check_keyboard



	;=====================
	; flip page


;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop


	;====================
	; end of level

oops_new_location:



	;========================
	; exit level
	;========================
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

.include "handle_ned.s"
.include "wavy_tree_actions.s"

.include "../hgr_routines/hgr_sprite.s"

.include "sprites_wavy_tree/ned_sprites.inc"

	;=====================
	; update screen
	;=====================
update_screen:

	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;==========================
	; draw ned if necessary
	;==========================

	jsr	handle_ned

	rts
