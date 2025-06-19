; Peasant's Quest

; Crooked / Burninated Tree (location 4,5)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = crooked_tree_verb_table

burninated_core:

.include "../location_common/common_core.s"


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

	;===================
	; move peasant

	jsr	move_peasant

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster


	;=====================
	; always draw peasant

	jsr	draw_peasant

	;====================
	; increment frame

	inc	FRAME


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

	;=======================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop


oops_new_location:
;	jmp	new_location


	;========================
	; exit level
	;========================
level_over:

	; note: check for load from savegame if change state

	rts

.if 0
.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"

.endif

.include "../location_common/include_bottom.s"

.include "burninated_actions.s"

.include "../hgr_routines/hgr_sprite.s"

