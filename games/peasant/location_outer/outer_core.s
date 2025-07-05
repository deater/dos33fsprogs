; Peasant's Quest

; Trogdor's Outer Sanctum

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = cave_outer_verb_table

outer_core:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	FLAME_COUNT
	sta	KEEPER_COUNT
	sta	IN_QUIZ

.include "../location_common/common_core.s"

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

	;======================
	; check keyboard

	lda	IN_QUIZ
	cmp	#2		; means waiting for answer
	bne	normal_keyboard_check

	; FIXME: need to drain?

	jsr	check_keyboard_answer

	jmp	done_keyboard_check

normal_keyboard_check:

	;====================
	; normal check keyboard

	lda	PEASANT_DIR	; needed to keep keybaord from changing
	sta	OLD_DIR		; direction while being quizzed

	jsr	check_keyboard

done_keyboard_check:

	;===================================
	; keep from moving if being quizzed
	;===================================

	lda	IN_QUIZ
	beq	not_in_quiz

	lda	#0		; keep from moving
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	lda	OLD_DIR		; keep from changing dir
	sta	PEASANT_DIR

not_in_quiz:

	;==========================
	; see if keeper triggered

	lda	IN_QUIZ
	bne	done_check_keeper

check_keeper1:
	lda	INVENTORY_2
	and	#INV2_TROGSHIELD	; only if not have shield
	bne	check_keeper2

	lda	PEASANT_X		; only if ourx > 9
	cmp	#10
	bcc	check_keeper2

	jsr	handle_keeper1

check_keeper2:


done_check_keeper:



	;===================
	; move peasant

	jsr	move_peasant

	;====================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;=====================
	; update screen

	jsr	update_screen

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame


	;=======================
	; flip page

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop



;not_outer:
;just_go_there:


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

;.include "../hgr_routines/hgr_sprite.s"
.include "../hgr_routines/hgr_sprite_mask.s"

.include "keeper1.s"
.include "outer_actions.s"

.include "sprites_outer/keeper1_sprites.inc"
.include "sprites_outer/ron_sprites.inc"
.include "sprites_outer/keeper2_sprites.inc"
;.include "sprites_outer/guitar_sprites.inc"


	;======================
	; update screen
	;======================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=============
	; draw keeper

	lda	IN_QUIZ		; need to draw keeper if quizzing
	beq	no_draw_keeper

	jsr	draw_keeper

no_draw_keeper:


	;=====================
	; always draw peasant

	jsr	draw_peasant


	rts
