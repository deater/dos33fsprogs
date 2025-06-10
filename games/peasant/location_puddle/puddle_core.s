; Peasant's Quest

; Puddle (location 2,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE=puddle_verb_table

peasantry_puddle:

.include "../location_common/common_core.s"

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

	;====================
	; move peasant

	jsr	move_peasant

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;===========================
	; copy bg to current screen

	lda	#$60
	jsr	hgr_copy_fast

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
	; always draw peasant

	jsr	draw_peasant

	;====================
	; increment frame

	inc	FRAME


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


	;========================
	; exit level
	;========================
level_over:


really_level_over:

	rts

.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

;.include "../hgr_routines/hgr_partial_restore.s"
;.include "../hgr_routines/hgr_sprite.s"

.include "../wait_a_bit.s"

.include "../new_map_location.s"

.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy_fast.s"

.include "../keyboard.s"

.include "../vblank.s"


;puddle_text_zx02:
;.incbin "../text/DIALOG_PUDDLE.ZX02"

.include "puddle_actions.s"
