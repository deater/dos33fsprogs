; Peasant's Quest

; Gary the Horse (Location 1,1)

; by Vince `deater` Weaver	vince@deater.net


.include "../location_common/include_common.s"

VERB_TABLE = gary_verb_table

gary_core:

.include "../location_common/common_core.s"

	;==================================
	; see if need to draw hole in fence
	jsr	gary_update_bg

	;===================================
	; mark location visited

	lda	VISITED_0
	ora	#MAP_POOR_GARY
	sta	VISITED_0


	;=====================
	; make sure not wearing mask

	lda	#0
	sta	WEARING_MASK

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

	;=======================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over



	;========================
	; update screen

	jsr	update_screen


	;=======================
	; increment frame

	inc	FRAME

	;=======================
	; increment flame

	jsr	increment_flame



	;=======================
	; flip screen

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


.include "../location_common/include_bottom.s"

.include "../hgr_routines/hgr_sprite.s"

.include "gary_update_bg.s"
.include "gary_actions.s"
.include "draw_gary.s"
.include "draw_gary_scare.s"

.include "sprites_gary/gary_sprites.inc"
.include "sprites_gary/gary_bg.inc"
.include "sprites_gary/gary_scare.inc"

	;=========================
	; update screen
	;=========================

update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=======================
	; draw gary

	jsr	draw_gary

	;======================
	; draw peasant

	jsr	draw_peasant

	;=======================
	; draw mask, if necessary

	lda	WEARING_MASK
	beq	not_wearing_mask

	lda	#15
	sta	CURSOR_X
	lda	#119
	sta     CURSOR_Y

	lda	#<peasant_mask
	sta	INL
	lda	#>peasant_mask
	sta	INH

	jsr	hgr_draw_sprite


not_wearing_mask:

	rts
