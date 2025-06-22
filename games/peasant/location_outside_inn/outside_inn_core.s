; Peasant's Quest

; Outside the Inn (location 5,3)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = inn_verb_table

outside_inn_core:

.include "../location_common/common_core.s"

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;=====================
	; at inn

before_inn:
	; see if pot on head

	lda	GAME_STATE_1
	and	#POT_ON_HEAD
	beq	no_before_game_text

	; take pot off head

	lda	GAME_STATE_1
	and	#<(~POT_ON_HEAD)
	sta	GAME_STATE_1

	ldx	#<outside_inn_pot_message
	ldy	#>outside_inn_pot_message
	jsr	finish_parse_message

no_before_game_text:


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


	;===================
	; update screen

	jsr	update_screen


	;==================
	; increment frame

	inc	FRAME

	;==================
	; increment flame

	jsr	increment_flame

	;===================
	; level specific
	;=====================

skip_level_specific:




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
.include "outside_inn_actions.s"


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


	rts
