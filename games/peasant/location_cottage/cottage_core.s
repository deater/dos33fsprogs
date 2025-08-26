; Peasant's Quest

; Your poor, poor, cottage

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = cottage_verb_table

cottage_core:

.include "../location_common/common_core.s"

	;===================================
	; mark location visited

	lda	VISITED_2
	ora	#MAP_YOUR_COTTAGE
	sta	VISITED_2

	;======================================================
	; check if in hay, and if so, make us no longer in hay

	jsr	check_haystack_exit



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

	;=====================
	; update screen

	jsr	update_screen

	;==================
	; increment frame

	inc	FRAME

	;==================
	; increment flame

	jsr	increment_flame

	;=====================
	; page flip

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop


        ;====================
        ; end of level
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
.include "cottage_actions.s"

BLOWN_AWAY_OFFSET = 0
.include "../location_haystack/check_haystack.s"
.include "../location_haystack/sprites_haystack/blown_away_sprite.inc"
.include "haystack_data.s"
.include "../hgr_routines/hgr_sprite_custom_bg_mask.s"


	;==========================
	; update screen
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; draw peasant

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	skip_draw_peasant

	jsr	draw_peasant

skip_draw_peasant:

	rts
