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
	; extra init

	lda	#0
	sta	WEARING_MASK		; make sure not wearing mask
	sta	SUPPRESS_DRAWING	; no suppressions to start

	;======================================================
	; check if in hay, and if so, make us no longer in hay

	jsr	check_haystack_exit

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

	; bit of a hack
	jsr	check_moving
	bcc	didnt_move

	; turn off mask if moved

	lda	#0
	sta	WEARING_MASK

didnt_move:

	;=======================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over



	;========================
	; update screen

	jsr	update_screen


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
.include "draw_gary_revenge.s"

.include "sprites_gary/gary_sprites.inc"
.include "sprites_gary/gary_bg.inc"
.include "sprites_gary/gary_scare.inc"

BLOWN_AWAY_OFFSET = 0
.include "../location_haystack/check_haystack.s"
.include "../location_haystack/sprites_haystack/blown_away_sprite.inc"
.include "../hgr_routines/hgr_sprite_custom_bg_mask.s"
.include "haystack_data.s"

	;=========================
	; update screen
	;=========================

update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=======================
	; draw gary

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_GARY
	bne	gary_suppressed

	jsr	draw_gary

gary_suppressed:

	;======================
	; draw peasant

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	peasant_suppressed

	; hack to draw injured peasant at end
	lda	SUPPRESS_DRAWING
	and	#CUSTOM_PEASANT
	beq	regular_draw_peasant

	jsr	handle_draw_peasant_revenge

	jmp	peasant_suppressed

regular_draw_peasant:

	jsr	draw_peasant

peasant_suppressed:

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


	;=======================
	; increment frame

	inc	FRAME

	;=======================
	; increment flame

	jsr	increment_flame

	rts
