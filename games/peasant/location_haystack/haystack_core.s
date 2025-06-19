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

	;====================
	; move peasant

	jsr	move_peasant

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; level specific
	;=====================


skip_level_specific:

	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster

	;====================
	; always draw peasant

	jsr	draw_peasant

	;====================
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


oops_new_location:


	;========================
	; exit level
	;========================
level_over:

	rts
.if 0
.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

;.include "../hgr_routines/hgr_partial_restore.s"
.include "../hgr_routines/hgr_sprite.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

;.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy_fast.s"

.include "../wait_a_bit.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"
.endif

.include "../location_common/include_bottom.s"
.include "haystack_actions.s"

