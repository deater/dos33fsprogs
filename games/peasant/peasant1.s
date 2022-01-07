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

	;=========================
	; update bg based on gary

	lda	MAP_LOCATION
	cmp	#LOCATION_POOR_GARY
	bne	no_update_gary

	; FIXME: draw broken fence if necessary
	; update fence in collision layer if necessary

	; see if gary out
	lda	GAME_STATE_0
	and	#GARY_SCARED
	bne	no_draw_gary

	; draw gary in background before copying

	lda	#9
	sta	CURSOR_X
	lda	#120
	sta	CURSOR_Y

	lda	#<gary_base_sprite
	sta	INL
	lda	#>gary_base_sprite
	sta	INH

	; switch to page1
	lda	#$60
	sta	hgr_sprite_page_smc+1

	jsr	hgr_draw_sprite

	; switch back to page2
	lda	#$00
	sta	hgr_sprite_page_smc+1

no_draw_gary:

no_update_gary:

	;==================
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

	;=======================
	; animate gary of applicable

	; check if on gary screen

	lda	MAP_LOCATION
	cmp	#LOCATION_POOR_GARY
	beq	flies_check_gary_out
	jmp	no_draw_gary_flies

flies_check_gary_out:
	; see if gary out
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	do_draw_gary_flies
	jmp	no_draw_gary_flies

	;=====================
	; draw the flies
do_draw_gary_flies:
	; flies on 32 frame loop
	; odd = fly1
	; even= fly2
	; 12/14 = tail1
	; 13/15 = tail2

	lda	FRAME
	and	#$3f			; 63 = $3f
	lsr
	cmp	#12
	beq	draw_tail1
	cmp	#13
	beq	draw_tail2
	cmp	#14
	beq	draw_tail1
	cmp	#15
	beq	draw_tail2

	; else normal
	and	#1
	beq	draw_fly1
	bne	draw_fly2

draw_tail1:
	lda	#<gary_tail1_sprite
	sta	INL
	lda	#>gary_tail1_sprite
	jmp	draw_flies

draw_tail2:
	lda	#<gary_tail2_sprite
	sta	INL
	lda	#>gary_tail2_sprite
	jmp	draw_flies

draw_fly2:
	lda	#<gary_fly2_sprite
	sta	INL
	lda	#>gary_fly2_sprite
	jmp	draw_flies

draw_fly1:
	lda	#<gary_fly1_sprite
	sta	INL
	lda	#>gary_fly1_sprite

draw_flies:
	sta	INH

	lda	#7
	sta	CURSOR_X
	lda	#120
	sta	CURSOR_Y

	jsr	hgr_draw_sprite


	;=====================
	; draw the foot
do_draw_gary_foot:
	; foot on 32 frame loop
	; 28/29 = foot1
	; 30/31 = foot2

	lda	FRAME
	and	#$3f			; 63 = $3f
	lsr
	cmp	#28
	beq	draw_foot1
	cmp	#29
	beq	draw_foot2
	cmp	#30
	beq	draw_foot1
	cmp	#31
	beq	draw_foot2

draw_foot0:
	lda	#<gary_foot0_sprite
	sta	INL
	lda	#>gary_foot0_sprite
	jmp	draw_foot

draw_foot1:
	lda	#<gary_foot1_sprite
	sta	INL
	lda	#>gary_foot1_sprite
	jmp	draw_foot

draw_foot2:
	lda	#<gary_foot2_sprite
	sta	INL
	lda	#>gary_foot2_sprite
	jmp	draw_foot

draw_foot:
	sta	INH

	lda	#11
	sta	CURSOR_X
	lda	#136
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

done_draw_foot:


no_draw_gary_flies:



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
.include "sprites/gary_sprites.inc"

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
