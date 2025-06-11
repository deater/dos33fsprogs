; Peasant's Quest

; Kerrek2 (Bottom Prints), Location (3,4)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = kerrek_verb_table

kerrek2_core:

.include "../location_common/common_core.s"



	;====================
	; handle kerrek
	;====================

	; clear out state otherwise kerrek can follow us around

	lda	#0
	sta	KERREK_STATE

	jsr	kerrek_setup

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

	lda	#$60
	jsr	hgr_copy_fast

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;====================
	; increment frame

	inc	FRAME

	;==========================
	; check if kerrek collision
	;==========================

	jsr	kerrek_draw

	jsr	kerrek_move_and_check_collision


	;=======================
	; check keyboard

	lda     PEASANT_DIR
	sta     OLD_DIR

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

	; note: check for load from savegame if change state

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

.include "../location_kerrek1/kerrek1_actions.s"
.include "../location_kerrek1/sprites_kerrek1/kerrek_sprites.inc"

.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"
.include "../wait_a_bit.s"

.include "../hgr_routines/hgr_sprite.s"

.include "../redbook_sound.inc"

