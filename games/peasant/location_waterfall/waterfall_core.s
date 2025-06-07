; Peasant's Quest

; o/~ Don't go making phony calls o/~

; Waterfall, location (5,1)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = waterfall_verb_table

waterfall_core:

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

	;===================================
	; animate waterfall (if applicable)

	lda	FRAME
	and	#$7
	beq	erase_waterfall
	cmp	#4
	beq	draw_waterfall
	bne	leave_waterfall_alone

draw_waterfall:

	lda	#36
	sta	CURSOR_X
	lda	#94
	sta	CURSOR_Y

	lda	#<waterfall_sprite
	sta	INL
	lda	#>waterfall_sprite
	sta	INH

	jsr	hgr_draw_sprite

	jmp	leave_waterfall_alone
erase_waterfall:


	lda	#94
	sta	SAVED_Y1
	lda	#141
	sta	SAVED_Y2

	lda	#36
	ldx	#38


	jsr	hgr_partial_restore

leave_waterfall_alone:


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

	;====================
	; increment flame

	jsr	increment_flame

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

.include "waterfall_actions.s"

;.include "../hgr_routines/hgr_page_flip.s"
.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"

.include "../hgr_routines/hgr_sprite.s"

.include "sprites_waterfall/waterfall_sprites.inc"
