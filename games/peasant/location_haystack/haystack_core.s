; Peasant's Quest

; Haystack (location 1,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE=hay_bale_verb_table

peasantry_haystack:

.include "../location_common/common_core.s"


	;======================
	; check if in hay

	jsr	check_haystack_exit

	;===================================
	; mark location visited

	lda	VISITED_1
	ora	#MAP_HAY_BALE
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

	;=======================
	; check keyboard

	jsr	check_keyboard

	;====================
	; move peasant

	jsr	move_peasant

	;======================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; level specific
	;=====================


skip_level_specific:

	;====================
	; update screen

	jsr	update_screen

	;====================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame


	;====================
	; page flip

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
.include "haystack_actions.s"


	;========================
	; update screen
	;========================

update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;====================
	; always draw peasant

	jsr	draw_peasant

	rts
