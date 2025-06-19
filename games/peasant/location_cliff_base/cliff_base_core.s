; Peasant's Quest

; Cliff Base

; just the cliff base
;	we're going crazy with disk accesses now

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE=cliff_base_verb_table

cliff_base_core:

.include "../location_common/common_core.s"

	; custom init
	lda	#0
	sta	KEEPER_COUNT
	sta	IN_QUIZ

	; Note: to get to this point of the game you have to be
	;       in a robe and on fire, so we should enforce that

	lda	GAME_STATE_2
	ora	#ON_FIRE
	sta	GAME_STATE_2

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;===========================
	;===========================
	;===========================
	; main loop
	;===========================
	;===========================
	;===========================
game_loop:

	;===================
	; move peasant

	jsr	move_peasant

	;====================
	; check if done level

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

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame

	;======================
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

	cmp	#NEW_FROM_LOAD		; see if loading save game
	beq	exiting_cliff

	; new location

	lda	#4
	sta	PEASANT_X
	lda	#170
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
exiting_cliff:
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

.endif

.include "../location_common/include_bottom.s"

.include "cliff_base_actions.s"

