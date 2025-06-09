; Peasant's Quest

; Inside Inn

;	a lot happens at the Inn

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = inside_inn_verb_table

inside_inn_core:

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

	;========================
	; move the peasant

	jsr	move_peasant

	;===========================
	; copy bg to current screen

	lda	#$60
	jsr	hgr_copy_fast

	;========================
	; always draw the peasant

	jsr	draw_peasant

	;========================
	; increment the frame

	inc	FRAME

	;=====================
	; level specific
	;=====================

	lda	MAP_LOCATION
	cmp	#LOCATION_INSIDE_INN
	bne	skip_level_specific

exit_inside_inn:
	; check if leaving

	lda	PEASANT_Y
	cmp	#$95
	bcc	skip_level_specific

	; we're exiting, print proper message

;	lda	INVENTORY_2
;	and	#INV2_TRINKET
;	bne	after_trinket_message

;	lda	INVENTORY_2_GONE
;	and	#INV2_TRINKET
;	bne	after_trinket_message


;before_trinket_message:
;	ldx	#<inside_cottage_leaving_message
;	ldy	#>inside_cottage_leaving_message
;	jsr	finish_parse_message
;	jmp	done_trinket_message

;after_trinket_message:
;	ldx	#<inside_cottage_leaving_post_trinket_message
;	ldy	#>inside_cottage_leaving_post_trinket_message
;	jsr	finish_parse_message

done_trinket_message:

	; put outside door
	lda	#$9
	sta	PEASANT_X
	lda	#$69
	sta	PEASANT_Y

	; stop walking
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD


	; move back

	lda     #LOCATION_INSIDE_INN
	jsr	update_map_location


skip_level_specific:

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;====================
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

	; NOTE: check for load from savegame if modify game state

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

.include "inside_inn_actions.s"

;.include "../hgr_routines/hgr_page_flip.s"
.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"

