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

	;=======================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR		; why?

	jsr	check_keyboard

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop


	;========================
	; exit level
	;========================
oops_new_location:
level_over:
	; note: check reason for load if changing gamestate


	;==========================================================
	; be sure on DRAW_PAGE=$20 when leaving as we load to PAGE2

	lda	DRAW_PAGE
	bne	on_proper_page

	jsr	update_screen
	jsr	hgr_page_flip

on_proper_page:

	lda	PEASANT_NEWY
	sta	PEASANT_Y


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
