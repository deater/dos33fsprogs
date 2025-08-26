; Peasant's Quest

; Jhonka Cave (location 1,3)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = jhonka_cave_verb_table

jhonka_core:

.include "../location_common/common_core.s"

	;=============================
	; reset jhonka

	lda	#0
	sta	JHONKA_COUNT
	sta	IN_QUIZ

	;=============================
	; handle note on door

	jsr	unpost_note

	;=============================
	; handle riches

	jsr	remove_riches

	;=============================
	; handle background haystack

	jsr	haystack_bg

	;==========================
	; see if print hay message

before_jhonka_cave:
	; check to see if in hay

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	no_before_game_text

	ldx	#<jhonka_in_hay_message
	ldy	#>jhonka_in_hay_message
	jsr	finish_parse_message

no_before_game_text:


	;============================
	; add jhonka collision

	jsr	check_kerrek_dead
	bcc	skip_add_jhonka

	lda	#$08
	sta	collision_location+$b9
	sta	collision_location+$ba
	sta	collision_location+$bb
skip_add_jhonka:


	;===================================
	; mark location visited

	lda	VISITED_2
	ora	#MAP_JHONKA_CAVE
	sta	VISITED_2

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

	;=======================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard


	;=======================
	; don't move if being quizzed

	lda	IN_QUIZ
	beq	normal_move_peasant

	; keep from moving
	lda	OLD_DIR
	sta	PEASANT_DIR
	jmp	check_done_level

	;==============
	; move peasant
normal_move_peasant:

	jsr	move_peasant

	;=====================
	; check if level over
check_done_level:
	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;===================
	; update screen

	jsr	update_screen


	;==================
	; increment frame

	inc	FRAME

	;==================
	; increment flame

	jsr	increment_flame


	;=====================
	; flip page

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop


	;====================
	; exit level
	;====================
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
.include "jhonka_actions.s"
.include "draw_jhonka.s"
.include "sprites_jhonka/sprites_jhonka.inc"
.include "sprites_jhonka/sprites_riches.inc"
.include "sprites_jhonka/sprites_beat.inc"
.include "update_bg.s"
.include "jhonka_beat.s"

USE_BG_PALETTE=1
.include "../hgr_routines/hgr_sprite_mask.s"
.include "../hgr_routines/hgr_sprite.s"
.include "../hgr_routines/hgr_sprite_custom_bg_mask.s"

BLOWN_AWAY_OFFSET=0
.include "../location_haystack/sprites_haystack/blown_away_sprite.inc"
.include "../location_haystack/sprites_haystack/haystack_sprite.inc"
.include "../location_haystack/check_haystack.s"
.include "../location_haystack/draw_haystack.s"
.include "haystack_data.s"

	;======================
	; update screen
	;======================

update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; draw peasant

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	skip_draw_peasant
	jsr	draw_peasant
skip_draw_peasant:


	;=====================
	; draw haystack

	jsr	draw_haystack

	;=====================
	; draw jhonka

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_JHONKA
	bne	skip_draw_jhonka

	jsr	draw_jhonka
skip_draw_jhonka:

	rts
