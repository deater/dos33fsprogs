; Peasant's Quest

; Cliff Base

; just the cliff base
;	we're going crazy with disk accesses now

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE=cliff_base_verb_table

cliff_base_core:

.include "../location_common/common_core.s"


	; Note: to get to this point of the game you have to be
	;       in a robe and on fire, so we should enforce that

	lda	GAME_STATE_2
	ora	#ON_FIRE
	sta	GAME_STATE_2

	; robe2 = PEASANT_OUTER_SPRITES sprite set

	lda	#PEASANT_OUTFIT_ROBE2
	sta	WHICH_PEASANT_SPRITES

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;===========================
	;===========================
	;===========================
	; main loop
	;===========================
	;===========================
	;===========================
game_loop:

	;======================
	; check keyboard

	jsr	check_keyboard


	;===================
	; move peasant

	jsr	move_peasant

	;====================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; update screen

	jsr	update_screen

	;=====================
	; increment frame

	inc	FRAME

	;=====================
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

.include "cliff_base_actions.s"


	;============================
	; update screen
	;============================
update_screen:


	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant


	rts
