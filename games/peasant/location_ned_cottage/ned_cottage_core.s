; Peasant's Quest

; Ned's Cottage (Empty Hut) Location 1,4

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = ned_cottage_verb_table

ned_cottage_core:

.include "../location_common/common_core.s"

	;====================
	; update ned cottage if necessary

	lda	GAME_STATE_2
	and	#COTTAGE_ROCK_MOVED
	beq	not_necessary_cottage

	; 161,117
	lda	#23
	sta	CURSOR_X
	lda	#117
	sta	CURSOR_Y

	lda	#<rock_moved_sprite
	sta	INL
	lda	#>rock_moved_sprite
	sta	INH

	jsr	hgr_draw_sprite


not_necessary_cottage:

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


	;=======================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

;	jsr	wait_vblank

        jsr	hgr_page_flip





	;===============================
	; check if can enter ned cottage
	;===============================

	; OK are are at the cottage, is the door open?

	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	beq	not_ned_cottage

	; at cottage, door open, check our co-ords
	lda	PEASANT_Y	; #$68
	cmp	#$64
	bcc	not_ned_cottage
	cmp	#$70
	bcs	not_ned_cottage

	lda	PEASANT_X	; 15 - 17
	cmp	#15
	bcc	not_ned_cottage
	cmp	#18
	bcs	not_ned_cottage

	; we did it, we're entering Ned's cottage

	lda	#LOCATION_INSIDE_NN
	jsr	update_map_location

	lda	#11
	sta	PEASANT_X
	lda	#$90
	sta	PEASANT_Y
	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD


not_ned_cottage:


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

.include "ned_cottage_actions.s"

.include "../hgr_routines/hgr_sprite.s"

.include "sprites_ned_cottage/ned_sprites.inc"
