; Peasant's Quest

; Inside Ned's Cottage

; by Vince `deater` Weaver	vince@deater.net


.include "../location_common/include_common.s"

VERB_TABLE = inside_nn_verb_table

inside_neds_cottage_core:

.include "../location_common/common_core.s"


	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;============================
	;============================
	;============================
	; main loop
	;============================
	;============================
	;============================

game_loop:

	;=====================
	; move peasant

	jsr	move_peasant

	;=====================
	; always draw peasant

	jsr	draw_peasant

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;===========================
	; copy bg to current screen

	lda	#$60
	jsr	hgr_copy_fast

	;=====================
	; increment frame

	inc	FRAME


inside_nn_cottage:
	; check if leaving

	lda	PEASANT_Y
	cmp	#$95
	bcc	skip_level_specific

	; put outside door
	lda	#13
	sta	PEASANT_X
	lda	#$71
	sta	PEASANT_Y

	; stop walking
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	; move back

	lda     #LOCATION_OUTSIDE_NN
	jsr	update_map_location


skip_level_specific:

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

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

.include "inside_ned_actions.s"

.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"

.include "../hgr_routines/hgr_sprite.s"
