; Peasant's Quest

; Hidden Glen

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = hidden_glen_verb_table

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

	lda	#0
	sta	ARCHER_COUNT

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

	;======================
	; update screen

	jsr	update_screen

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame

	;=====================================
	; check if in line of Dongolev's arrow

	jsr	check_in_range

skip_level_specific:


	;=================
	; page flip

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

.include "hidden_glen_actions.s"
.include "hidden_glen_intrusion.s"

.include "archer.s"

.include "../hgr_routines/hgr_sprite.s"
.include "sprites_hidden_glen/archer_sprites.inc"

	;========================
	; update screen
	;========================
update_screen:


	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;==========================
	; draw archer if necessary
	;	note: might need extra work to make sure appears
	;	in front of / behind peasant

	jsr	draw_archer


	rts


	;============================
	; check in range
	;============================
check_in_range:

	; first check if he's there
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	bne	not_in_range

	; check if in range
	; guessing from 77 -> 90?

	; also check X to see if behind dongolev or tree

	lda	PEASANT_Y
	cmp	#77
	bcc	not_in_range		; blt

	cmp	#90
	bcs	not_in_range		; bge

	lda	PEASANT_X
	cmp	#30
	bcs	not_in_range		; bge

	cmp	#12
	bcc	not_in_range		; blt

	;=========================
	; oops we're getting shot

	jsr	range_intrusion_setup

	ldx	#<hidden_glen_walk_in_way_message
	ldy	#>hidden_glen_walk_in_way_message
	jsr	partial_message_step

	jsr	range_intrusion_action

	ldx	#<hidden_glen_walk_in_way_message2
	ldy	#>hidden_glen_walk_in_way_message2
	jsr	partial_message_step

	ldx	#<hidden_glen_walk_in_way_message3
	ldy	#>hidden_glen_walk_in_way_message3
	jsr	partial_message_step


not_in_range:
	rts


