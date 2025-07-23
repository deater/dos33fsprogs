; Peasant's Quest

; Crooked / Burninated Tree (location 4,5)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = crooked_tree_verb_table

burninated_core:

.include "../location_common/common_core.s"


	;===================================
	; mark location visited

	lda	VISITED_3
	ora	#MAP_BURN_TREES
	sta	VISITED_3


	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;===============================
	;===============================
	;===============================
	; main loop
	;===============================
	;===============================
	;===============================

game_loop:

	;=======================
	; check keyboard

	jsr	check_keyboard

	;===================
	; move peasant

	jsr	move_peasant

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;====================
	; update screen

	jsr	update_screen


	;====================
	; increment frame

	inc	FRAME

	;===================
	; increment flame

	jsr	increment_flame


	;==========================================
	; check if lighting on fire at crooked tree
	;==========================================

	lda	MAP_LOCATION
	cmp	#LOCATION_BURN_TREES
	bne	not_burn_trees

	; see if already on fire

	lda	GAME_STATE_2
	and	#ON_FIRE
	bne	not_burn_trees

	; see if have grease on head

	lda	GAME_STATE_2
	and	#GREASE_ON_HEAD
	beq	not_burn_trees

	; check if X in range
	lda	PEASANT_X
	cmp	#$A		; blt
	bcc	not_burn_trees
	cmp	#$D
	bcs	not_burn_trees	; bge

	; check if Y in range
	lda	PEASANT_Y
	cmp	#$85
	bcs	not_burn_trees	; bge
	cmp	#$70
	bcc	not_burn_trees	; blt

	; finally set on fire

	lda	GAME_STATE_2
	ora	#ON_FIRE
	sta	GAME_STATE_2

	; increment score
	lda	#$10	; bcd
	jsr	score_points

	ldx	#<crooked_catch_fire_message
	ldy	#>crooked_catch_fire_message
	jsr	partial_message_step

not_burn_trees:



	;======================
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

.include "burninated_actions.s"
.include "draw_flame.s"

.include "../hgr_routines/hgr_sprite.s"
.include "sprites_burninated/flame_sprites.inc"


	;=======================
	; update screen
	;=======================

update_screen:
	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; draw flame

	jsr	draw_flame

	;=====================
	; always draw peasant

	jsr	draw_peasant

	rts
