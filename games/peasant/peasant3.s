; Peasant's Quest

; Peasantry Part 3 (third line of map)

;	Jhonka, your cottage, w lake, e lake, inn

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE   = LOCATION_JHONKA_CAVE	; index starts here (10)

peasantry3:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables		; necessary?
;	jsr	hgr2			; necessary?

	; decompress dialog to $D000

	lda	#<peasant3_text_zx02
	sta	zx_src_l+1
	lda	#>peasant3_text_zx02
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
	;==========================

	; setup default verb table

	jsr	setup_default_verb_table


	; we are PEASANT3 so locations 10...14 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table

	;===========================
	; Load priority to $400
	; indirectly as we can't touch screen holes

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	zx_src_l+1
	lda	map_priority_hi,X
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	gr_copy_to_page1


	;=====================
	; load bg

	; we are PEASANT3 so locations 10...14 map to 0...4, no change

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	zx_src_l+1
	lda	map_backgrounds_hi,X
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

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
	; save background

;	lda	PEASANT_X
;	sta	CURSOR_X
;	lda	PEASANT_Y
;	sta	CURSOR_Y

	;=======================
	; draw initial peasant

;	jsr	save_bg_1x28

;	jsr	draw_peasant

	;=======================
	; check if in hay

	jsr check_haystack_exit


	;=======================
	; before game text
	;=======================


	lda	MAP_LOCATION

	cmp	#LOCATION_JHONKA_CAVE
	beq	before_jhonka_cave

	cmp	#LOCATION_OUTSIDE_INN
	beq	before_inn

	bne	no_before_game_text


	;=====================
	; at inn

before_inn:
	; see if pot on head

	lda	GAME_STATE_1
	and	#POT_ON_HEAD
	beq	no_before_game_text

	; take pott off head

	lda	GAME_STATE_1
	and	#<(~POT_ON_HEAD)
	sta	GAME_STATE_1

	ldx	#<outside_inn_pot_message
	ldy	#>outside_inn_pot_message
	jsr	finish_parse_message

	;=====================
	; at jhonka cave

before_jhonka_cave:
	; check to see if in hay

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	no_before_game_text

	ldx	#<jhonka_in_hay_message
	ldy	#>jhonka_in_hay_message
	jsr	finish_parse_message


no_before_game_text:


	;=================================
	;=================================
	;=================================
	; main loop
	;=================================
	;=================================
	;=================================

game_loop:

	;==============
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;==================
	; increment frame

	inc	FRAME

	;====================
	; check keyboard

	jsr	check_keyboard


	;===================
	; level specific
	;=====================

	lda	MAP_LOCATION
	cmp	#LOCATION_LAKE_EAST
	beq	at_lake_east
	cmp	#LOCATION_LAKE_WEST
	beq	at_lake_west
	bne	skip_level_specific

at_lake_east:
	jsr	animate_bubbles_e

        ; draw dude

	lda	GAME_STATE_1
	and	#FISH_FED
	bne	done_dude

	lda	FRAME
	and	#$8
	beq	draw_boat1

draw_boat0:
	lda	#<boat0
	sta	INL
	lda	#>boat0
	jmp	done_choose_boat
draw_boat1:
	lda	#<boat1
	sta	INL
	lda	#>boat1

done_choose_boat:
        sta     INH

        lda     #1
        sta     CURSOR_X
        lda     #70
        sta     CURSOR_Y

        jsr     hgr_draw_sprite

done_dude:


	jmp	skip_level_specific

at_lake_west:
	jsr	animate_bubbles_w

skip_level_specific:

	;=========
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

	; FIXME: check for load from savegame if modifying game state

	rts


.include "peasant_common.s"
.include "move_peasant.s"
.include "draw_peasant.s"

.include "gr_copy.s"
.include "hgr_copy.s"
.include "hgr_sprite.s"

.include "new_map_location.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "graphics_peasantry/graphics_peasant3.inc"

.include "sprites/boat_sprites.inc"

map_backgrounds_low:
	.byte	<jhonka_zx02		; 10	-- jhonka
	.byte	<cottage_zx02		; 11	-- cottage
	.byte	<lake_w_zx02		; 12	-- lake west
	.byte	<lake_e_zx02		; 13	-- lake east
	.byte	<inn_zx02		; 14	-- inn

map_backgrounds_hi:
	.byte	>jhonka_zx02		; 10	-- jhonka
	.byte	>cottage_zx02		; 11	-- cottage
	.byte	>lake_w_zx02		; 12	-- lake west
	.byte	>lake_e_zx02		; 13	-- lake east
	.byte	>inn_zx02		; 14	-- inn

.include "graphics_peasantry/priority_peasant3.inc"

map_priority_low:
	.byte	<jhonka_priority_zx02		; 10	-- jhonka
	.byte	<cottage_priority_zx02		; 11	-- cottage
	.byte	<lake_w_priority_zx02		; 12	-- lake west
	.byte	<lake_e_priority_zx02		; 13	-- lake east
	.byte	<inn_priority_zx02		; 14	-- inn

map_priority_hi:
	.byte	>jhonka_priority_zx02		; 10	-- jhonka
	.byte	>cottage_priority_zx02		; 11	-- cottage
	.byte	>lake_w_priority_zx02		; 12	-- lake west
	.byte	>lake_e_priority_zx02		; 13	-- lake east
	.byte	>inn_priority_zx02		; 14	-- inn

verb_tables_low:
	.byte   <jhonka_cave_verb_table		; 10	-- jhonka
	.byte   <cottage_verb_table		; 11	-- cottage
	.byte   <lake_west_verb_table		; 12	-- lake west
	.byte   <lake_east_verb_table		; 13	-- lake east
	.byte   <inn_verb_table			; 14	-- inn

verb_tables_hi:
	.byte   >jhonka_cave_verb_table		; 10	-- jhonka
	.byte   >cottage_verb_table		; 11	-- cottage
	.byte   >lake_west_verb_table		; 12	-- lake west
	.byte   >lake_east_verb_table		; 13	-- lake east
	.byte   >inn_verb_table			; 14	-- inn


peasant3_text_zx02:
.incbin "DIALOG_PEASANT3.ZX02"

.include "peasant3_actions.s"

.include "animate_bubbles.s"
