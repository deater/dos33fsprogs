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
	jsr	hgr2			; necessary?

	; decompress dialog to $D000

	lda	#<peasant3_text_lzsa
	sta	getsrc_smc+1
	lda	#>peasant3_text_lzsa
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

	;=====================
	; load bg

	; we are PEASANT3 so locations 10...14 map to 0...4, no change

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	; Load priority

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
;.include "score.s"

.include "gr_copy.s"

.include "new_map_location.s"
.include "peasant_move.s"



;.include "parse_input.s"

;.include "inventory.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "version.inc"



.include "graphics_peasantry/graphics_peasant3.inc"

;.include "sprites/boat_sprites.inc"

map_backgrounds_low:
	.byte	<jhonka_lzsa		; 10	-- jhonka
	.byte	<cottage_lzsa		; 11	-- cottage
	.byte	<lake_w_lzsa		; 12	-- lake west
	.byte	<lake_e_lzsa		; 13	-- lake east
	.byte	<inn_lzsa		; 14	-- inn

map_backgrounds_hi:
	.byte	>jhonka_lzsa		; 10	-- jhonka
	.byte	>cottage_lzsa		; 11	-- cottage
	.byte	>lake_w_lzsa		; 12	-- lake west
	.byte	>lake_e_lzsa		; 13	-- lake east
	.byte	>inn_lzsa		; 14	-- inn

.include "graphics_peasantry/priority_peasant3.inc"

map_priority_low:
	.byte	<jhonka_priority_lzsa		; 10	-- jhonka
	.byte	<cottage_priority_lzsa		; 11	-- cottage
	.byte	<lake_w_priority_lzsa		; 12	-- lake west
	.byte	<lake_e_priority_lzsa		; 13	-- lake east
	.byte	<inn_priority_lzsa		; 14	-- inn

map_priority_hi:
	.byte	>jhonka_priority_lzsa		; 10	-- jhonka
	.byte	>cottage_priority_lzsa		; 11	-- cottage
	.byte	>lake_w_priority_lzsa		; 12	-- lake west
	.byte	>lake_e_priority_lzsa		; 13	-- lake east
	.byte	>inn_priority_lzsa		; 14	-- inn

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


peasant3_text_lzsa:
.incbin "DIALOG_PEASANT3.LZSA"

.include "peasant3_actions.s"
