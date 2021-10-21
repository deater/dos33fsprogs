; Peasant's Quest

; Cliff Base

WHICH_PEASANTRY=0

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"

cliff_base:
	lda	#0
	sta	GAME_OVER
	sta	FRAME

	jsr	hgr_make_tables

	jsr	hgr2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called


	; update map location

;	jsr	update_map_location

	; update score

	jsr	update_score

	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

new_location:
	lda	#0
	sta	GAME_OVER

	;=====================
	; load bg

	lda	#<cliff_base_lzsa
	sta	getsrc_smc+1
	lda	#>cliff_base_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<cliff_base_priority_lzsa
	sta	getsrc_smc+1
	lda	#>cliff_base_priority_lzsa
	sta	getsrc_smc+2

	lda	#$20			; temporarily load to $2000

	jsr	decompress_lzsa2_fast

	; copy to $400

	jsr	gr_copy_to_page1

	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	; put score

	jsr	print_score

	;=====================
	; move peasant
	; FIXME: don't do this if loading game

	lda	#20
	sta	PEASANT_X
	lda	#150
	sta	PEASANT_Y

	;====================
	; save background

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	;=======================
	; draw initial peasant

	jsr	save_bg_1x28

	jsr	draw_peasant

game_loop:

	jsr	move_peasant

	inc	FRAME

	jsr	check_keyboard

	lda	GAME_OVER
	bmi	oops_new_location
	bne	game_over


	; delay

	lda	#200
	jsr	wait


	jmp	game_loop

oops_new_location:
	jmp	new_location


	;************************
	; exit level
	;************************
game_over:

	rts




.include "draw_peasant.s"

.include "gr_copy.s"

.include "new_map_location.s"

.include "peasant_move.s"

.include "parse_input.s"

;.include "inventory.s"

.include "score.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "version.inc"



; Moved to qload
;.include "decompress_fast_v2.s"
;.include "hgr_font.s"
;.include "draw_box.s"
;.include "hgr_rectangle.s"
;.include "hgr_1x28_sprite_mask.s"
;.include "hgr_1x5_sprite.s"
;.include "hgr_partial_save.s"
;.include "hgr_input.s"
;.include "hgr_tables.s"
;.include "hgr_text_box.s"
;.include "clear_bottom.s"
;.include "hgr_hgr2.s"
;.include "loadsave_menu.s"
;.include "wait_keypress.s"


.include "graphics_cliff/cliff_graphics.inc"

.include "graphics_cliff/priority_cliff.inc"
