; Peasant's Quest Trgodor scene

; The inner sanctum

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = trogdor_inner_verb_table


trogdor:
	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

.include "../location_common/common_core.s"


	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;====================
	; intro message

	ldx	#<trogdor_entry_message
	ldy	#>trogdor_entry_message
	jsr	finish_parse_message


	;==========================
	;==========================
	;==========================
	; main loop
	;==========================
	;==========================
	;==========================

game_loop:

	;====================
	; check keyboard

	jsr	check_keyboard

	;===================
	; move peasant

	jsr	move_peasant_tiny

	;======================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; update screen

	jsr	update_screen


	;====================
	; increment frame

	inc	FRAME

	;=====================
	; flip page

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop



	;=======================
	; exit level
	;======================

oops_new_location:
level_over:

	; go to end credits

	lda     #LOAD_ENDING
        sta     WHICH_LOAD

        rts


; include bottom.s

.include "move_peasant_tiny.s"
.include "draw_peasant_tiny.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
;.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

;.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"


; end include_bottom.s



;.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy_fast.s"

.include "../wait_a_bit.s"


.include "../hgr_routines/hgr_sprite.s"

.include "../ssi263/ssi263_simple_speech.s"
.include "trogdor_speech.s"
.include "trogdor_sleep.s"

;.include "graphics_trogdor/trogdor_graphics.inc"
;.include "graphics_trogdor/priority_trogdor.inc"

.include "sprites_trogdor/trogdor_sprites.inc"
.include "sprites_trogdor/sleep_sprites.inc"

.include "trogdor_actions.s"


	;===========================
	; update screen
	;===========================

update_screen:

	;==========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;===================
	; always draw peasant

	jsr	draw_peasant_tiny

	;======================
	; draw sleeping trogdor

	jsr	draw_sleeping_trogdor


	rts
