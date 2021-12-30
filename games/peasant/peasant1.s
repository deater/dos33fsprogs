; Peasant's Quest

; Peasantry Part 1 (top line of map)

; 	Gary, Kerrek 1, Well, Yellow Tree, Waterfall

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE   = LOCATION_POOR_GARY	; index starts here (0)

peasantry1:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables		; necessary?
;	jsr	hgr2			; necessary?

	; decompress dialog to $d000

	lda	#<peasant1_text_lzsa
	sta	getsrc_smc+1
	lda	#>peasant1_text_lzsa
	sta	getsrc_smc+2

	lda	#$D0

	jsr	decompress_lzsa2_fast


	; update score

	jsr	update_score

	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

new_location:
	lda	#0
	sta	LEVEL_OVER

	;==========================
	; load updated verb table
	;==========================

	; setup default verb table

	jsr	setup_default_verb_table

	; we are PEASANT1 so locations 0...4 map to 0...4

	ldx	MAP_LOCATION

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table


	;===========================
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


	;=====================
	; load bg

	; we are PEASANT1 so locations 0...4 map to 0...4, no change

	ldx	MAP_LOCATION

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	; copy to $4000

	jsr	hgr_copy

	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	; put score

	jsr	print_score




	;====================
	; handle kerrek
	;====================

	; clear out old state otherwise kerrek can follow us around

	lda	#0
	sta	KERREK_STATE

	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_1
	bne	not_kerrek

	jsr	kerrek_setup

not_kerrek:


	;====================
	; save background

;	lda	PEASANT_X
;	sta	CURSOR_X
;	lda	PEASANT_Y
;	sta	CURSOR_Y

	;=======================
	; draw initial peasant

;	jsr	save_bg_1x28

;	jsr	draw_peasant

	;===================
	; check hay

	jsr	check_haystack_exit


	;========================================
	;========================================
	;========================================
	; main loop
	;========================================
	;========================================
	;========================================

game_loop:

	;===================================
	; animate waterfall (if applicable)

	lda	MAP_LOCATION
	cmp	#LOCATION_WATERFALL
	bne	leave_waterfall_alone

	lda	FRAME
	and	#$7
	beq	erase_waterfall
	cmp	#4
	beq	draw_waterfall
	bne	leave_waterfall_alone

draw_waterfall:

	lda	#36
	sta	CURSOR_X
	lda	#94
	sta	CURSOR_Y

	lda	#<waterfall_sprite
	sta	INL
	lda	#>waterfall_sprite
	sta	INH

	jsr	hgr_draw_sprite

	jmp	leave_waterfall_alone
erase_waterfall:


	lda	#94
	sta	SAVED_Y1
	lda	#141
	sta	SAVED_Y2

	lda	#36
	ldx	#38


	jsr	hgr_partial_restore

leave_waterfall_alone:


	;======================
	; move peasant

	jsr	move_peasant

	;======================
	; always draw peasant

	jsr	draw_peasant

	;=======================
	; next frame

	inc	FRAME

	;=======================
	; check keyboard

	jsr	check_keyboard

	; FIXME: draw kerrek before peasant if behind him?

	jsr	kerrek_draw

	jsr	kerrek_move_and_check_collision

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	game_over

	; delay

	lda	#200
	jsr	wait

	jmp	game_loop

	;====================
	; end of level

oops_new_location:

	; special case if leaving with baby in well

	; trouble though, by this point MAP_LOCATION is the new one?

	lda	PREVIOUS_LOCATION
	cmp	#LOCATION_OLD_WELL
	bne	skip_level_specific

at_old_well:
	lda	GAME_STATE_0
	and	#BABY_IN_WELL
	beq	skip_level_specific

	ldx	#<well_leave_baby_in_well_message
	ldy	#>well_leave_baby_in_well_message
	jsr	finish_parse_message

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK	; needed?
	sta	LEVEL_OVER
	jmp	game_over

skip_level_specific:


	jmp	new_location


	;************************
	; exit level
	;************************
game_over:

	rts

.include "peasant_common.s"
.include "move_peasant.s"
.include "draw_peasant.s"

.include "gr_copy.s"

.include "new_map_location.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "hgr_sprite.s"

.include "hgr_copy.s"

;.include "text/peasant1.inc"

.include "graphics_peasantry/graphics_peasant1.inc"
.include "sprites/waterfall_sprites.inc"

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


.include "graphics_peasantry/priority_peasant1.inc"

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


verb_tables_low:
	.byte   <gary_verb_table		; 0	-- gary the horse
	.byte   <kerrek_verb_table		; 1	-- top footprints
	.byte   <wishing_well_verb_table	; 2	-- wishing well
	.byte   <yellow_tree_verb_table		; 3	-- leaning tree
	.byte   <waterfall_verb_table		; 4	-- waterfall

verb_tables_hi:
	.byte   >gary_verb_table		; 0	-- gary the horse
	.byte   >kerrek_verb_table		; 1	-- top footprints
	.byte   >wishing_well_verb_table	; 2	-- wishing well
	.byte   >yellow_tree_verb_table		; 3	-- leaning tree
	.byte   >waterfall_verb_table		; 4	-- waterfall


peasant1_text_lzsa:
.incbin "DIALOG_PEASANT1.LZSA"

.include "peasant1_actions.s"
