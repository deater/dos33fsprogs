; Peasant's Quest

; Gary the Horse (Location 1,1)

; by Vince `deater` Weaver	vince@deater.net


.include "../location_common/include_common.s"

VERB_TABLE = gary_verb_table

gary_core:

.include "../location_common/common_core.s"


.include "gary_update_bg.s"

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


	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster

	;======================
	; always draw peasant

	jsr	draw_peasant

	;=======================
	; draw gary

	.include "draw_gary.s"


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

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


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

.include "../location_common/include_bottom.s"

.if 0
.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
;.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"


.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"


.endif

.include "../hgr_routines/hgr_sprite.s"

.include "gary_actions.s"
.include "sprites_gary/gary_sprites.inc"
