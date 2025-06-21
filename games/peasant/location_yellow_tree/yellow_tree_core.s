; Peasant's Quest

; Yellow/Leaning tree, location (4,1)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = yellow_tree_verb_table

yellow_tree_core:

.include "../location_common/common_core.s"


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

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;=====================
	; update screen

	jsr	update_screen


	;=======================
	; increment frame

	inc	FRAME


	;========================
	; flip pages

;	jsr	wait_vblank

        jsr	hgr_page_flip

        jmp	game_loop


	;========================
	; exit level
	;========================
oops_new_location:
level_over:
	; note: check reason for load if changing gamestate

	rts


.include "../location_common/include_bottom.s"
.include "yellow_tree_actions.s"


	;==========================
	; update screen
	;==========================

update_screen:

	;===========================
	; copy bg to current screen

	lda	#$60
	jsr	hgr_copy_faster


	;======================
	; always draw peasant

	jsr	draw_peasant

	rts
