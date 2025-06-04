; Peasant's Quest

; Cliff Heights

; Top of the cliff

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"
.include "../redbook_sound.inc"

DIALOG_LOCATION=cliff_text_zx02
VERB_TABLE = cliff_heights_verb_table
PRIORITY_LOCATION=cliff_heights_priority_zx02
BG_LOCATION=cliff_heights_zx02

.include "../location_common/init_common.s"

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

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame

	;======================
	; check keyboard

	; original code also waited approximately 100ms?
	; this led to keypressed being lost


	lda	#13
	sta	WAIT_LOOP
wait_loop:

	jsr	check_keyboard

	lda	#50		; approx 7ms
	jsr	wait

	dec	WAIT_LOOP
	bne	wait_loop

	jsr	wait_vblank

	jmp	game_loop

oops_new_location:

;	lda	MAP_LOCATION
;	cmp	#LOCATION_TROGDOR_OUTER
;	bne	not_outer

;	lda	#2
;	sta	PEASANT_X
;	lda	#100
;	sta	PEASANT_Y

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


.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"
.include "../hgr_routines/hgr_partial_restore.s"
.include "../hgr_routines/hgr_sprite.s"

.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../wait.s"
.include "../wait_a_bit.s"

.include "../vblank.s"

.include "graphics_heights/cliff_heights_graphics.inc"
.include "graphics_heights/priority_cliff_heights.inc"



cliff_text_zx02:
.incbin "../text/DIALOG_CLIFF_HEIGHTS.ZX02"

.include "heights_actions.s"

robe_sprite_data:
	.incbin "../sprites_peasant/robe_sprites.zx02"
;	.incbin "../sprites_peasant/robe_shield_sprites.zx02"


.include "draw_lightning.s"

.include "../location_common/flame_common.s"


