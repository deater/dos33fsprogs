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

	;===================
	; level specific
	;=====================

skip_level_specific:


	;====================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop

oops_new_location:
;       jmp     new_location


        ;========================
        ; exit level

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

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"


;.include "../hgr_routines/hgr_page_flip.s"
.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"
.endif

.include "../location_common/include_bottom.s"
.include "outside_inn_actions.s"
