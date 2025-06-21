; Peasant's Quest

; Wishing Well (location 3,1)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = wishing_well_verb_table

well_core:

.include "../location_common/common_core.s"


	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;========================================
	;========================================
	;========================================
	; main loop
	;========================================
	;========================================
	;========================================

game_loop:

	;=======================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

	;======================
	; move peasant

	jsr	move_peasant

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=======================
	; update screen

	jsr	update_screen

	;=======================
	; increment frame

	inc	FRAME


	;=======================
	; page flip

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop


	;====================
	; end of level

oops_new_location:

	; special case if leaving with baby in well

	; trouble though, by this point MAP_LOCATION is the new one?

	lda	PREVIOUS_LOCATION
	cmp	#LOCATION_OLD_WELL
	bne	skip_level_specific

at_old_well:
	lda	GAME_STATE_0
	and	#BABY_IN_WELL
	beq	skip_level_specific

	ldx	#<well_leave_baby_in_well_message
	ldy	#>well_leave_baby_in_well_message
	jsr	finish_parse_message

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK	; needed?
	sta	LEVEL_OVER
	jmp	level_over

skip_level_specific:


;	jmp	new_location


	;========================
	; exit level
	;========================
level_over:
	; note: check reason for load if changing gamestate

	rts



.include "../location_common/include_bottom.s"

.include "well_actions.s"


	;==============================
	; update screen
	;==============================
update_screen:
	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;======================
	; always draw peasant

	jsr	draw_peasant

	rts




