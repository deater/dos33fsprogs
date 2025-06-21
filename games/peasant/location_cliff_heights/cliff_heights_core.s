; Peasant's Quest

; Cliff Heights

; Top of the cliff

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = cliff_heights_verb_table

.include "../location_common/common_core.s"

cliff_heights:

	; custom init

	lda	#0
	sta	KEEPER_COUNT
	sta	IN_QUIZ

	;========================
	; Note: to get to this point of the game you have to be
	;	in a robe and on fire, so we should enforce that

	lda	GAME_STATE_2
	ora	#ON_FIRE
	sta	GAME_STATE_2



	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	; See if we need to give points

	lda	GAME_STATE_3
	and	#CLIFF_CLIMBED
	bne	cliff_already_climbed

	; only set this if just arrived, not if loading saved game

	lda	#14
	sta	PEASANT_X
	lda	#150
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	; score points

	lda	#3
	jsr	score_points

	lda	GAME_STATE_3
	ora	#CLIFF_CLIMBED
	sta	GAME_STATE_3

	; print the message

	ldx	#<cliff_heights_top_message
	ldy	#>cliff_heights_top_message
        jsr     finish_parse_message

	jsr	restore_parse_message

cliff_already_climbed:

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

	jsr	check_keyboard


	;===================
	; move peasant

	jsr	move_peasant

	;====================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	beq	level_good

	jmp	level_over

level_good:

	;====================
	; update screen

	jsr	update_screen

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame


	;==================
	; flip page

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop

        ;====================
        ; end of level


oops_new_location:
not_outer:
just_go_there:

;	jmp	new_location


	;========================
	; exit level
	;========================
level_over:

	cmp	#NEW_FROM_LOAD		; see if loading save game
	beq	exiting_cliff

	; new location
	; in theory this can only be OUTER

	lda	#2
	sta	PEASANT_X
	lda	#100
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
exiting_cliff:
	rts


.include "../location_common/include_bottom.s"

.include "../hgr_routines/hgr_sprite.s"

.include "heights_actions.s"

.include "draw_lightning.s"

	;=========================
	; update screen
	;=========================
update_screen:

	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster

	;=====================
	; draw lightning

	lda     MAP_LOCATION
	cmp	#LOCATION_CLIFF_HEIGHTS
	bne	no_lightning
	jsr	draw_lightning
no_lightning:


	;=====================
	; always draw peasant

	jsr	draw_peasant

	rts
