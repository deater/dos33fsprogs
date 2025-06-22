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

	;=======================
	; check keyboard

	jsr	check_keyboard

	;======================
	; move peasant

	jsr	move_peasant

	;======================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location		; we used to diffentiate
	bne	level_over			; if we had more than one level
						; per file
	;======================
	; level specific

	;======================
	; update screen

	jsr	update_screen


	;=======================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame

	;====================
	; page flip

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

	;=============================
	; update screen
	;=============================

update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;======================
	; draw waterfall

	.include "draw_waterfall.s"

	;======================
	; always draw peasant

	jsr	draw_peasant

	rts



.include "../hgr_routines/hgr_sprite.s"
.include "../location_common/include_bottom.s"
.include "waterfall_actions.s"
.include "sprites_waterfall/waterfall_sprites.inc"
