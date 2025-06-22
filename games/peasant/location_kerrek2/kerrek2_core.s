; Peasant's Quest

; Kerrek2 (Bottom Prints), Location (3,4)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = kerrek_verb_table

kerrek2_core:

.include "../location_common/common_core.s"



	;====================
	; handle kerrek
	;====================

	; clear out state otherwise kerrek can follow us around

	lda	#0
	sta	KERREK_STATE

	jsr	kerrek_setup

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

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

	;===================
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

	;====================
	; increment flame

	jsr	increment_flame

	;==========================
	; check if kerrek collision
	;==========================

	jsr	kerrek_move_and_check_collision


	;==================
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



.include "../wait_a_bit.s"
.include "../location_common/include_bottom.s"

.include "../hgr_routines/hgr_sprite.s"

.include "../location_kerrek1/kerrek1_actions.s"
.include "../location_kerrek1/sprites_kerrek1/kerrek_sprites.inc"



	;=========================
	; update screen
	;=========================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant


	;=====================
	; draw kerrek
	;  FIXME: what if in front of/behind peasant?

	jsr	kerrek_draw


	rts
