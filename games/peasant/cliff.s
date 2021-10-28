; Peasant's Quest

; Cliff

;	Cliff base, cliff heights, trogdor outer

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE	= LOCATION_CLIFF_BASE ; (20)

cliff_base:
	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables
	jsr	hgr2

	; decompress dialog to $D000

	lda	#<cliff_text_lzsa
	sta	getsrc_smc+1
	lda	#>cliff_text_lzsa
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

	; setup default verb table

	jsr	setup_default_verb_table

	; local verb table

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table



	;=====================
	; load bg

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	; load priority to $400
	; indirectly as we can't trash screen holes

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

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

	lda	LEVEL_OVER
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

;.include "parse_input.s"

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

map_backgrounds_low:
	.byte   <cliff_base_lzsa
	.byte   <cliff_heights_lzsa
	.byte   <outer_lzsa

map_backgrounds_hi:
	.byte   >cliff_base_lzsa
	.byte   >cliff_heights_lzsa
	.byte   >outer_lzsa

map_priority_low:
	.byte	<cliff_base_priority_lzsa
	.byte	<cliff_heights_priority_lzsa
	.byte	<outer_priority_lzsa

map_priority_hi:
	.byte	>cliff_base_priority_lzsa
	.byte	>cliff_heights_priority_lzsa
	.byte	>outer_priority_lzsa

verb_tables_low:
	.byte	<cliff_base_verb_table
	.byte	<cliff_heights_verb_table
	.byte	<cave_outer_verb_table

verb_tables_hi:
	.byte	>cliff_base_verb_table
	.byte	>cliff_heights_verb_table
	.byte	>cave_outer_verb_table



cliff_text_lzsa:
.incbin "DIALOG_CLIFF.LZSA"

.include "cliff_actions.s"
