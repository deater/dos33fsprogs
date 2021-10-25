; Peasant's Quest

; Peasantry Part 4 (bottom line of map)

;	ned cottage, wavy tree, kerrek 2, lady cottage, burninated tree

WHICH_PEASANTRY = 3

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

peasantry4:

	lda	#0
	sta	GAME_OVER
	sta	FRAME

	jsr	hgr_make_tables		; necessary?
	jsr	hgr2			; necessary?

	; decompress dialog to $D000

	lda	#<peasant4_text_lzsa
	sta	getsrc_smc+1
	lda	#>peasant4_text_lzsa
	sta	getsrc_smc+2

	lda	#$D0

	jsr	decompress_lzsa2_fast


	; update map location

	jsr	update_map_location

	; update score

	jsr 	update_score

	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

new_location:
	lda	#0
	sta	GAME_OVER

	;==========================
	; load updated verb table

	; we are PEASANT4 so locations 15...19 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#15
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table

	;=====================
	; load bg

	; we are PEASANT1 so locations 15...19 map to 0...4, no change

	lda	MAP_LOCATION
	sec
	sbc	#15
	tax

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	; load priority

	lda	MAP_LOCATION
	sec
	sbc	#15
	tax

	lda	map_priority_low,X
	sta	getsrc_smc+1
	lda	map_priority_hi,X
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

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





.include "draw_peasant.s"

; moved to qload

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
;.include "wait_keypress.s"
;.include "loadsave_menu.s"

.include "gr_copy.s"

.include "peasant_move.s"

.include "score.s"

.include "new_map_location.s"

;.include "parse_input.s"

;.include "inventory.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "graphics_peasantry/graphics_peasant4.inc"
.include "graphics_peasantry/priority_peasant4.inc"

.include "version.inc"




map_backgrounds_low:
	.byte	<empty_hut_lzsa		; 15	-- empty hut
	.byte	<ned_lzsa		; 16	-- ned
	.byte	<bottom_prints_lzsa	; 17	-- bottom footprints
	.byte	<lady_cottage_lzsa	; 18	-- cottage lady
	.byte	<crooked_tree_lzsa	; 19	-- crooked tree

map_backgrounds_hi:
	.byte	>empty_hut_lzsa		; 15	-- empty hut
	.byte	>ned_lzsa		; 16	-- ned
	.byte	>bottom_prints_lzsa	; 17	-- bottom footprints
	.byte	>lady_cottage_lzsa	; 18	-- cottage lady
	.byte	>crooked_tree_lzsa	; 19	-- crooked tree



map_priority_low:
	.byte	<empty_hut_priority_lzsa	; 15	-- empty hut
	.byte	<ned_priority_lzsa		; 16	-- ned
	.byte	<bottom_prints_priority_lzsa	; 17	-- bottom footprints
	.byte	<lady_cottage_priority_lzsa	; 18	-- cottage lady
	.byte	<crooked_tree_priority_lzsa	; 19	-- crooked tree

map_priority_hi:
	.byte	>empty_hut_priority_lzsa	; 15	-- empty hut
	.byte	>ned_priority_lzsa		; 16	-- ned
	.byte	>bottom_prints_priority_lzsa	; 17	-- bottom footprints
	.byte	>lady_cottage_priority_lzsa	; 18	-- cottage lady
	.byte	>crooked_tree_priority_lzsa	; 19	-- crooked tree



verb_tables_low:
	.byte	<ned_cottage_verb_table		; 15	-- empty hut
	.byte	<ned_verb_table			; 16	-- ned
	.byte	<kerrek_verb_table		; 17	-- bottom footprints
	.byte	<lady_cottage_verb_table	; 18	-- cottage lady
	.byte	<crooked_tree_verb_table	; 19	-- crooked tree

verb_tables_hi:
	.byte	>ned_cottage_verb_table		; 15	-- empty hut
	.byte	>ned_verb_table			; 16	-- ned
	.byte	>kerrek_verb_table		; 17	-- bottom footprints
	.byte	>lady_cottage_verb_table	; 18	-- cottage lady
	.byte	>crooked_tree_verb_table	; 19	-- crooked tree


peasant4_text_lzsa:
.incbin "DIALOG_PEASANT4.LZSA"

.include "peasant4_actions.s"
