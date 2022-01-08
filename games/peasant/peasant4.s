; Peasant's Quest

; Peasantry Part 4 (bottom line of map)

;	ned cottage, wavy tree, kerrek 2, lady cottage, burninated tree

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE   = LOCATION_OUTSIDE_NN     ; index starts here (15)

peasantry4:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables		; necessary?
;	jsr	hgr2			; necessary?

	; decompress dialog to $D000

	lda	#<peasant4_text_lzsa
	sta	getsrc_smc+1
	lda	#>peasant4_text_lzsa
	sta	getsrc_smc+2

	lda	#$D0

	jsr	decompress_lzsa2_fast

	; update score

	jsr 	update_score

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


	; we are PEASANT4 so locations 15...19 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table

	;=========================
	; load priority to $400

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	getsrc_smc+1
	lda	map_priority_hi,X
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_page1


	;=====================
	; load bg

	; we are PEASANT1 so locations 15...19 map to 0...4, no change

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	jsr	hgr_copy

	;====================
	; update ned cottage if necessary

	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_NN
	bne	not_necessary_cottage

	lda	GAME_STATE_2
	and	#COTTAGE_ROCK_MOVED
	beq	not_necessary_cottage

	; 161,117
	lda	#23
	sta	CURSOR_X
	lda	#117
	sta	CURSOR_Y

	lda	#<rock_moved_sprite
	sta	INL
	lda	#>rock_moved_sprite
	sta	INH

	jsr	hgr_draw_sprite


not_necessary_cottage:


	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	;==============
	; put score

	jsr	print_score


	;====================
	; handle kerrek
	;====================

	; clear out state

	lda	#0
	sta	KERREK_STATE

	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_2
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


	;======================
	; check if in haystack

	jsr	check_haystack_exit



	;===============================
	;===============================
	;===============================
	; main loop
	;===============================
	;===============================
	;===============================

game_loop:

	;===================
	; move peasant

	jsr	move_peasant

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;====================
	; increment frame

	inc	FRAME

	;=====================
	; check keyboard

	jsr	check_keyboard

	;==========================
	; check if kerrek collision
	;==========================

	jsr	kerrek_draw

	jsr	kerrek_move_and_check_collision

	;==========================
	; check if lighting on fire
	;==========================

	lda	MAP_LOCATION
	cmp	#LOCATION_BURN_TREES
	bne	not_burn_trees

	; see if already on fire

	lda	GAME_STATE_2
	and	#ON_FIRE
	bne	not_burn_trees

	; see if have grease on head

	lda	GAME_STATE_2
	and	#GREASE_ON_HEAD
	beq	not_burn_trees

	; check if X in range
	lda	PEASANT_X
	cmp	#$A		; blt
	bcc	not_burn_trees
	cmp	#$D
	bcs	not_burn_trees	; bge

	; check if Y in range
	lda	PEASANT_Y
	cmp	#$85
	bcs	not_burn_trees	; bge
	cmp	#$70
	bcc	not_burn_trees	; blt

	; finally set on fire

	lda	GAME_STATE_2
	ora	#ON_FIRE
	sta	GAME_STATE_2

	; increment score
	lda	#$10	; bcd
	jsr	score_points

	ldx	#<crooked_catch_fire_message
	ldy	#>crooked_catch_fire_message
	jsr	partial_message_step

not_burn_trees:

	;===============================
	; check if can enter ned cottage
	;===============================
	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_NN
	bne	not_ned_cottage

	; OK are are at the cottage, is the door open?

	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	beq	not_ned_cottage

	; at cottage, door open, check our co-ords
	lda	PEASANT_Y	; #$68
	cmp	#$64
	bcc	not_ned_cottage
	cmp	#$70
	bcs	not_ned_cottage

	lda	PEASANT_X	; 15 - 17
	cmp	#15
	bcc	not_ned_cottage
	cmp	#18
	bcs	not_ned_cottage

	; we did it, we're entering Ned's cottage

	lda	#LOCATION_INSIDE_NN
	jsr	update_map_location

	lda	#11
	sta	PEASANT_X
	lda	#$90
	sta	PEASANT_Y
	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD


not_ned_cottage:

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	; delay

	lda	#200
	jsr	wait


	jmp	game_loop

oops_new_location:
	jmp	new_location


	;************************
	; exit level
	;************************
level_over:

	; note: check for load from savegame if change state

	rts



.include "peasant_common.s"
.include "move_peasant.s"
.include "draw_peasant.s"

.include "gr_copy.s"
.include "hgr_copy.s"

.include "new_map_location.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "graphics_peasantry/graphics_peasant4.inc"
.include "graphics_peasantry/priority_peasant4.inc"




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

.include "sprites/ned_sprites.inc"

.include "hgr_sprite.s"
