; Peasant's Quest

; Puddle (location 2,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE=puddle_verb_table

peasantry_puddle:

.include "../location_common/common_core.s"

	;===================================
	; mark location visited

	lda	VISITED_1
	ora	#MAP_MUD_PUDDLE
	sta	VISITED_1


	;====================================
	; draw mud if necessary

	jsr	make_muddy

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;================================
	;================================
	;================================
	; main loop
	;================================
	;================================
	;================================
game_loop:

	;=======================
	; check keyboard

	jsr	check_keyboard

	;====================
	; move peasant

	jsr	move_peasant

	;====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; handle mud puddle
	;=====================

at_mud_puddle:
	; see if falling in

	; see if puddle wet
	lda	GAME_STATE_1
	and	#PUDDLE_WET
	beq	skip_level_specific

	; see if clean
	lda	GAME_STATE_2
	and	#COVERED_IN_MUD
	bne	skip_level_specific

	; see if X in range
	lda	PEASANT_X
	cmp	#$B
	bcc	skip_level_specific
	cmp	#$1B
	bcs	skip_level_specific

	; see if Y in range
	lda	PEASANT_Y
	cmp	#$64
	bcc	skip_level_specific
	cmp	#$80
	bcs	skip_level_specific

	; in range!
	ldx	#<puddle_walk_in_message
	ldy	#>puddle_walk_in_message
	jsr	partial_message_step

	; make muddy
	lda	GAME_STATE_2
	ora	#COVERED_IN_MUD
	sta	GAME_STATE_2

	; do animation?

	; points if we haven't already
	lda	GAME_STATE_2
	and	#GOT_MUDDY_ALREADY
	bne	skip_level_specific

	; add 2 points to score

	lda	#2
	jsr	score_points

	lda	GAME_STATE_2
	ora	#GOT_MUDDY_ALREADY
	sta	GAME_STATE_2


skip_level_specific:

	;====================
	; update screen

	jsr	update_screen


	;====================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame

	;========================
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
.include "puddle_actions.s"
.include "sprites_puddle/mud_sprites.inc"
.include "handle_mud.s"
.include "../hgr_routines/hgr_sprite.s"

	;==========================
	; update screen
	;==========================

update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster



	;====================
	; always draw peasant

	jsr	draw_peasant


	rts
