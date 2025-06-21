; Peasant's Quest

; Kerrek1 (Top Prints), Location (2,1)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = kerrek_verb_table

kerrek1_core:

.include "../location_common/common_core.s"


	;====================
	; handle kerrek
	;====================

	; clear out old state otherwise kerrek can follow us around

	lda	#0
	sta	KERREK_STATE

	jsr	kerrek_setup


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

	jsr	check_keyboard

	;======================
	; move peasant

	jsr	move_peasant

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;==========================
	; update screen


	jsr	update_screen


	;===========================
	; handle kerrek

	jsr	kerrek_move_and_check_collision


	; oh kerrek where is thine sting
	; play music sting if needed
	lda	kerrek_play_sting
	beq	no_sting
	jsr	kerrek_warning_music
	dec	kerrek_play_sting
no_sting:


	;=======================
	; increment frame

	inc	FRAME


	;=======================
	; flip page

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop

	;====================
	; end of level

oops_new_location:

;	jmp	new_location


	;========================
	; exit level
	;========================
level_over:
	; note: check reason for load if changing gamestate

	rts


.include "../location_common/include_bottom.s"

.include "../wait_a_bit.s"
.include "../hgr_routines/hgr_sprite.s"
.include "kerrek1_actions.s"
.include "sprites_kerrek1/kerrek_sprites.inc"

	;==========================
	; update screen
	;==========================
update_screen:


	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;======================
	; draw kerrerk

	; FIXME: draw kerrek before peasant if behind him?

	jsr	kerrek_draw

	;======================
	; always draw peasant

	jsr	draw_peasant


	rts
