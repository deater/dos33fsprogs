; Peasant's Quest

; Peasantry Part 1 (top line of map)
; 	Gary, Kerrek 1, Well, Yellow Tree, Waterfall

WHICH_PEASANTRY = 0

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"


peasant_quest:
	lda	#0
	sta	GAME_OVER
	sta	FRAME

	jsr	hgr_make_tables

	jsr	hgr2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called


	; update map location

	jsr	update_map_location

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

	; we are PEASANT1 so locations 0...4 map to 0...4, no change

	ldx	MAP_LOCATION

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	; load priority to $400
	; indirectly as we can't trash screen holes


	ldx	MAP_LOCATION

	lda	map_priority_low,X
	sta	getsrc_smc+1
	lda	map_priority_hi,X
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


.include "wait_keypress.s"

.include "draw_peasant.s"

.include "gr_copy.s"

.include "new_map_location.s"

.include "peasant_move.s"

.include "parse_input.s"

.include "inventory.s"

.include "score.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "version.inc"
.include "loadsave_menu.s"


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



;help_message:
;.byte   0,43,24, 0,253,82
;.byte   8,41,"I don't understand. Type",13
;.byte	     "HELP for assistances.",0

;fake_error1:
;.byte   0,43,24, 0,253,82
;.byte   8,41,"?SYNTAX ERROR IN 1020",13
;.byte	     "]",127,0

;fake_error2:
;.byte   0,43,24, 0,253,82
;.byte   8,41,"?UNDEF'D STATEMENT ERROR",13
;.byte	     "]",127,0


.include "graphics/graphics_peasant1.inc"

map_backgrounds_low:
	.byte	<gary_lzsa		; 0	-- gary the horse
	.byte	<top_prints_lzsa	; 1	-- top footprints
	.byte	<wishing_well_lzsa	; 2	-- wishing well
	.byte	<leaning_tree_lzsa	; 3	-- leaning tree
	.byte	<waterfall_lzsa		; 4	-- waterfall

map_backgrounds_hi:
	.byte	>gary_lzsa		; 0	-- gary the horse
	.byte	>top_prints_lzsa	; 1	-- top footprints
	.byte	>wishing_well_lzsa	; 2	-- wishing well
	.byte	>leaning_tree_lzsa	; 3	-- leaning tree
	.byte	>waterfall_lzsa		; 4	-- waterfall


.include "graphics/priority_peasant1.inc"

map_priority_low:
	.byte	<gary_priority_lzsa		; 0	-- gary the horse
	.byte	<top_prints_priority_lzsa	; 1	-- top footprints
	.byte	<wishing_well_priority_lzsa	; 2	-- wishing well
	.byte	<leaning_tree_priority_lzsa	; 3	-- leaning tree
	.byte	<waterfall_priority_lzsa	; 4	-- waterfall

map_priority_hi:
	.byte	>gary_priority_lzsa		; 0	-- gary the horse
	.byte	>top_prints_priority_lzsa	; 1	-- top footprints
	.byte	>wishing_well_priority_lzsa	; 2	-- wishing well
	.byte	>leaning_tree_priority_lzsa	; 3	-- leaning tree
	.byte	>waterfall_priority_lzsa	; 4	-- waterfall
