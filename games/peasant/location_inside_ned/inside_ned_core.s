; Peasant's Quest

; Inside Ned's Cottage

; by Vince `deater` Weaver	vince@deater.net


.include "../location_common/include_common.s"

VERB_TABLE = inside_nn_verb_table

inside_neds_cottage_core:

.include "../location_common/common_core.s"

	;====================================================
	; draw the initial drawer to background

	jsr	draw_drawer


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
	;=======================
	; check keyboard

	jsr	check_keyboard

	;=====================
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;=======================
	; update screen

	jsr	update_screen

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame


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
	jsr	stop_walking

	; move back

	lda     #LOCATION_OUTSIDE_NN
	jsr	update_map_location


skip_level_specific:



	;====================
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

.include "../hgr_routines/hgr_sprite.s"

.include "inside_ned_actions.s"

.include "sprites_inside_ned/drawer_sprites.inc"
.include "draw_drawer.s"

	;======================
	; update screen
	;======================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant


	rts
