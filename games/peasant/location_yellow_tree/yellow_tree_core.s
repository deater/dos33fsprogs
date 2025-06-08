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


	;======================
	; move peasant

	jsr	move_peasant

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;===========================
	; copy bg to current screen

	lda	#$60
	jsr	hgr_copy_fast


	;======================
	; always draw peasant

	jsr	draw_peasant

	;=======================
	; increment frame

	inc	FRAME

	;=======================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

;	jsr	wait_vblank

        jsr	hgr_page_flip

        jmp	game_loop

	;====================
	; end of level

oops_new_location:

;	jmp	new_location


	;========================
	; exit level
	;========================
level_over:
	; note: check reason for load if changing gamestate

	rts

.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

.include "yellow_tree_actions.s"

.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"

.include "../hgr_routines/hgr_sprite.s"
