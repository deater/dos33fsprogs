; Peasant's Quest

; Inside Lady's Cottage

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = inside_cottage_verb_table

hidden_glen_core:

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

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;===========================
	; copy bg to current screen

	lda	#$60
	jsr	hgr_copy_fast


	;=====================
	; always draw peasant

	jsr	draw_peasant

	;=====================
	; increment frame

	inc	FRAME


	;=====================
	; level specific
	;=====================


inside_lady_cottage:
	; check if leaving

	lda	PEASANT_Y
	cmp	#$95
	bcc	skip_level_specific

	; we're exiting, print proper message

	lda	INVENTORY_2
	and	#INV2_TRINKET
	bne	after_trinket_message

	lda	INVENTORY_2_GONE
	and	#INV2_TRINKET
	bne	after_trinket_message


before_trinket_message:
	ldx	#<inside_cottage_leaving_message
	ldy	#>inside_cottage_leaving_message
	jsr	finish_parse_message
	jmp	done_trinket_message

after_trinket_message:
	ldx	#<inside_cottage_leaving_post_trinket_message
	ldy	#>inside_cottage_leaving_post_trinket_message
	jsr	finish_parse_message

done_trinket_message:

	; put outside door
	lda	#$17
	sta	PEASANT_X
	lda	#$7D
	sta	PEASANT_Y

	; stop walking
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD


	; move back

	lda     #LOCATION_OUTSIDE_LADY
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

.include "inside_lady_actions.s"

.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"

.include "../hgr_routines/hgr_sprite.s"
