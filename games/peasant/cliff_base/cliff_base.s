; Peasant's Quest

; Cliff Base

; just the cliff base
;	we're going crazy with disk accesses now

; by Vince `deater` Weaver	vince@deater.net

.include "../zp.inc"
.include "../hardware.inc"

.include "../peasant_sprite.inc"
.include "../qload.inc"
.include "../inventory/inventory.inc"
.include "../parse_input.inc"

collision_location = $bc00

LOCATION_BASE	= LOCATION_CLIFF_BASE ; (20)

cliff_base:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	FLAME_COUNT

	jsr	hgr_make_tables

	;================================
	; decompress dialog to $D000

	lda	#<cliff_text_zx02
	sta	zx_src_l+1
	lda	#>cliff_text_zx02
	sta	zx_src_h+1

	lda	#$D0

	jsr	zx02_full_decomp

	;===============================
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

	; copy collision detection info

	ldx	#0
col_copy_loop:
	lda	$2400,X
	sta	collision_location,X
	inx
	bne	col_copy_loop


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

	lda	#$20				; load to $2000

	jsr	zx02_full_decomp

	jsr	hgr_copy			; copy to $4000

	;===================
	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	;===================
	; put score

	jsr	print_score


	;======================
	; always activate text

	jsr	setup_prompt

	;========================
	; Load Peasant Sprites
	;========================
	; Note: to get to this point of the game you have to be
	;	in a robe and on fire, so we should enforce that

	lda	GAME_STATE_2
	ora	#ON_FIRE
	sta	GAME_STATE_2

	lda	#<robe_sprite_data
	sta	zx_src_l+1
	lda	#>robe_sprite_data
	sta	zx_src_h+1

	lda	#$a0

	jsr	zx02_full_decomp

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

	;====================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; always draw peasant

	jsr	draw_peasant

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	inc	FLAME_COUNT
	lda	FLAME_COUNT
	cmp	#3
	bne	flame_good

	lda	#0
	sta	FLAME_COUNT

flame_good:

	;======================
	; check keyboard

	; original code also waited approximately 100ms?
	; this led to keypressed being lost

	lda	#13
	sta	WAIT_LOOP
wait_loop:
	jsr	check_keyboard

	lda	#50		; approx 7ms
	jsr	wait

	dec	WAIT_LOOP
	bne	wait_loop


	jmp	game_loop

oops_new_location:

	; new location but same file

;	lda	MAP_LOCATION
;	cmp	#LOCATION_CLIFF_HEIGHTS
;	bne	not_the_cliff

;	lda	PREVIOUS_LOCATION
;	cmp	#LOCATION_TROGDOR_OUTER
;	beq	to_cliff_from_outer

;to_cliff_from_cliff:
;	lda	#18
;	sta	PEASANT_X
;	lda	#140
;	sta	PEASANT_Y
;	bne	not_the_cliff		; bra

;to_cliff_from_outer:
;	lda	#32
;	sta	PEASANT_X
;	lda	#120
;	sta	PEASANT_Y
;	bne	not_the_cliff		; bra

;not_the_cliff:

;	lda	MAP_LOCATION
;	cmp	#LOCATION_TROGDOR_OUTER
;	bne	not_outer

;	lda	#2
;	sta	PEASANT_X
;	lda	#100
;	sta	PEASANT_Y

;not_outer:
;just_go_there:

;	jmp	new_location


	;************************
	; exit level
	;************************
level_over:

	cmp	#NEW_FROM_LOAD		; see if loading save game
	beq	exiting_cliff

	; new location

	lda	#4
	sta	PEASANT_X
	lda	#170
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
exiting_cliff:
	rts


.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"
.include "../hgr_partial_restore.s"


.include "../gr_copy.s"
.include "../hgr_copy.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../wait.s"
.include "../wait_a_bit.s"

.include "../version.inc"


.include "graphics_cliff/cliff_graphics.inc"
.include "graphics_cliff/priority_cliff.inc"

map_backgrounds_low:
	.byte   <cliff_base_zx02

map_backgrounds_hi:
	.byte   >cliff_base_zx02

map_priority_low:
	.byte	<cliff_base_priority_zx02

map_priority_hi:
	.byte	>cliff_base_priority_zx02

verb_tables_low:
	.byte	<cliff_base_verb_table

verb_tables_hi:
	.byte	>cliff_base_verb_table



cliff_text_zx02:
.incbin "../text/DIALOG_CLIFF_BASE.ZX02"

.include "cliff_base_actions.s"

robe_sprite_data:
	.incbin "../sprites_peasant/robe_sprites.zx02"
