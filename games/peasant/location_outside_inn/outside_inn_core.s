; Peasant's Quest

; Outside the Inn (location 5,3)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = inn_verb_table

outside_inn_core:

.include "../location_common/common_core.s"

	;=======================================
	; check if note is there, if so post it

	jsr	post_note

	;===================================
	; mark location visited

	lda	VISITED_2
	ora	#MAP_OUTSIDE_INN
	sta	VISITED_2

	;=====================
	; check if pot on head

check_pot_head:

	lda	GAME_STATE_1
	and	#POT_ON_HEAD
	beq	no_before_game_text

	; load regular robe sprites

	lda	#PEASANT_OUTFIT_ROBE
	jsr	load_peasant_sprites

	; draw animation

	jsr	remove_pot_from_head

	; take pot off head

	lda	GAME_STATE_1
	and	#<(~POT_ON_HEAD)
	sta	GAME_STATE_1

	ldx	#<outside_inn_pot_message
	ldy	#>outside_inn_pot_message
	jsr	finish_parse_message

	; stop walking

	jsr	stop_walking

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

	;====================
	; check keyboard

	jsr	check_keyboard

	;==============
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

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

	;===================
	; level specific
	;=====================

skip_level_specific:




	;=====================
	; flip page

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
.include "outside_inn_actions.s"
.include "sprites_outside_inn/sprites_inn.inc"
.include "draw_remove_pot.s"
.include "sprites_outside_inn/pot_remove.inc"

.include "../hgr_routines/hgr_sprite.s"

	;=====================
	; update screen
	;=====================
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

	rts


	;==========================
	; post note
	;==========================
	; default is no note
	; if FISH_FED not true then post it
post_note:

	lda	GAME_STATE_1
	and	#FISH_FED		; will be 1 if FISH_FED
	bne	no_post_note

draw_note:
	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	lda	#<note_sprite
	sta	INL
	lda	#>note_sprite
	sta     INH

	lda	#9			; 63/7 = 9
	sta	CURSOR_X
	lda	#100
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

no_post_note:

	rts
