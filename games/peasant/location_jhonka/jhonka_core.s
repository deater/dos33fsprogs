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

	;==============
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;==================
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

level_over:

	; FIXME: check for load from savegame if modifying game state

	rts

.if 0
.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"

.include "../hgr_routines/hgr_sprite.s"

.endif

.include "../location_common/include_bottom.s"
.include "jhonka_actions.s"
