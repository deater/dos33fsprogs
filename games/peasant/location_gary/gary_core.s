; Peasant's Quest

; Gary the Horse (Location 1,1)

; by Vince `deater` Weaver	vince@deater.net


.include "../location_common/include_common.s"

VERB_TABLE = gary_verb_table

gary_core:

.include "../location_common/common_core.s"


.include "gary_update_bg.s"

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;========================================
	;========================================
	;========================================
	; main loop
	;========================================
	;========================================
	;========================================

game_loop:

	;=======================
	; check keyboard

	jsr	check_keyboard

	;======================
	; move peasant

	jsr	move_peasant

	;=======================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over



	;========================
	; update screen

	jsr	update_screen


	;=======================
	; increment frame

	inc	FRAME

	;=======================
	; increment flame

	jsr	increment_flame



	;=======================
	; flip screen

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

.include "gary_actions.s"
.include "sprites_gary/gary_sprites.inc"


	;=========================
	; update screen
	;=========================

update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=======================
	; draw gary

	.include "draw_gary.s"

	;======================
	; draw peasant

	jsr	draw_peasant

	rts
