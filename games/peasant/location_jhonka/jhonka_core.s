; Peasant's Quest

; Jhonka Cave (location 1,3)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = jhonka_cave_verb_table

jhonka_core:

.include "../location_common/common_core.s"

	;=====================
	; at jhonka cave

before_jhonka_cave:
	; check to see if in hay

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	no_before_game_text

	ldx	#<jhonka_in_hay_message
	ldy	#>jhonka_in_hay_message
	jsr	finish_parse_message


no_before_game_text:


	;===================================
	; mark location visited

	lda	VISITED_2
	ora	#MAP_JHONKA_CAVE
	sta	VISITED_2

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;=================================
	;=================================
	;=================================
	; main loop
	;=================================
	;=================================
	;=================================

game_loop:

	;=======================
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


	;====================
	; exit level
	;====================
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
.include "jhonka_actions.s"


	;======================
	; update screen
	;======================

update_screen:

	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant

	rts
