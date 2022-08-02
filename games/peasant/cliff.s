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
;	jsr	hgr2

	; decompress dialog to $D000

	lda	#<cliff_text_zx02
	sta	zx_src_l+1
	lda	#>cliff_text_zx02
	sta	zx_src_h+1

	lda	#$D0

	jsr	zx02_full_decomp


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

	;===============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	zx_src_l+1
	lda	map_priority_hi,X
	sta	zx_src_h+1

	lda	#$20			; temporarily load to $2000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	gr_copy_to_page1


	;=====================
	; load bg

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	zx_src_l+1
	lda	map_backgrounds_hi,X
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	hgr_copy

	;===================
	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	; put score

	jsr	print_score


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

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;=====================
	; increment frame

	inc	FRAME

	;======================
	; check keyboard

	jsr	check_keyboard

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	; delay

	lda	#200
	jsr	wait


	jmp	game_loop

oops_new_location:

	; new location but same file

	lda	MAP_LOCATION
	cmp	#LOCATION_CLIFF_HEIGHTS
	bne	not_the_cliff

	lda	PREVIOUS_LOCATION
	cmp	#LOCATION_TROGDOR_OUTER
	beq	to_cliff_from_outer

to_cliff_from_cliff:
	lda	#18
	sta	PEASANT_X
	lda	#140
	sta	PEASANT_Y
	bne	not_the_cliff		; bra

to_cliff_from_outer:
	lda	#32
	sta	PEASANT_X
	lda	#120
	sta	PEASANT_Y
	bne	not_the_cliff		; bra

not_the_cliff:

	lda	MAP_LOCATION
	cmp	#LOCATION_TROGDOR_OUTER
	bne	not_outer

	lda	#2
	sta	PEASANT_X
	lda	#100
	sta	PEASANT_Y

not_outer:
just_go_there:

	jmp	new_location


	;************************
	; exit level
	;************************
level_over:

	cmp	#NEW_FROM_LOAD		; see if loading save game
	beq	exiting_cliff

	; new location
	; in theory this can only be TROGDOR

	lda	#4
	sta	PEASANT_X
	lda	#170
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
exiting_cliff:
	rts




.include "draw_peasant.s"
.include "move_peasant.s"

.include "gr_copy.s"
.include "hgr_copy.s"

.include "new_map_location.s"




.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "version.inc"


.include "graphics_cliff/cliff_graphics.inc"
.include "graphics_cliff/priority_cliff.inc"

map_backgrounds_low:
	.byte   <cliff_base_zx02
	.byte   <cliff_heights_zx02
	.byte   <outer_zx02

map_backgrounds_hi:
	.byte   >cliff_base_zx02
	.byte   >cliff_heights_zx02
	.byte   >outer_zx02

map_priority_low:
	.byte	<cliff_base_priority_zx02
	.byte	<cliff_heights_priority_zx02
	.byte	<outer_priority_zx02

map_priority_hi:
	.byte	>cliff_base_priority_zx02
	.byte	>cliff_heights_priority_zx02
	.byte	>outer_priority_zx02

verb_tables_low:
	.byte	<cliff_base_verb_table
	.byte	<cliff_heights_verb_table
	.byte	<cave_outer_verb_table

verb_tables_hi:
	.byte	>cliff_base_verb_table
	.byte	>cliff_heights_verb_table
	.byte	>cave_outer_verb_table



cliff_text_zx02:
.incbin "DIALOG_CLIFF.ZX02"

.include "cliff_actions.s"
