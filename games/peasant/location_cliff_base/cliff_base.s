; Peasant's Quest

; Cliff Base

; just the cliff base
;	we're going crazy with disk accesses now

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

cliff_base:

DIALOG_LOCATION=cliff_text_zx02
VERB_TABLE=cliff_base_verb_table
PRIORITY_LOCATION=cliff_base_priority_zx02
BG_LOCATION=cliff_base_zx02

	; custom init
	lda	#0
	sta	KEEPER_COUNT
	sta	IN_QUIZ

	; Note: to get to this point of the game you have to be
	;       in a robe and on fire, so we should enforce that

	lda	GAME_STATE_2
	ora	#ON_FIRE
	sta	GAME_STATE_2


.include "../location_common/init_common.s"

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

	;===================
	; move peasant

	jsr	move_peasant

	;====================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


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


	jmp	game_loop

oops_new_location:

	;========================
	; exit level
	;========================
level_over:

	cmp	#NEW_FROM_LOAD		; see if loading save game
	beq	exiting_cliff

	; new location

	lda	#4
	sta	PEASANT_X
	lda	#170
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

.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy.s"

.include "../new_map_location.s"

.include "../keyboard.s"

;.include "../wait.s"
.include "../wait_a_bit.s"

.include "graphics_cliff/cliff_graphics.inc"
.include "graphics_cliff/priority_cliff.inc"

cliff_text_zx02:
.incbin "../text/DIALOG_CLIFF_BASE.ZX02"

.include "cliff_base_actions.s"

robe_sprite_data:
	.incbin "../sprites_peasant/robe_sprites.zx02"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"
