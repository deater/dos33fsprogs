; Peasant's Quest

; Peasantry Part 2 (second line of map)

;	haystack, puddle, archery, river, knight (pass)


WHICH_PEASANTRY=1

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"


peasant_quest:
	lda	#0
	sta	GAME_OVER
	sta	FRAME

	jsr	hgr_make_tables		; necessary?
	jsr	hgr2			; necessary?

	; decompress dialog to $D000

	lda	#<peasant2_text_lzsa
        sta     getsrc_smc+1
        lda     #>peasant2_text_lzsa
        sta     getsrc_smc+2

        lda     #$D0

        jsr     decompress_lzsa2_fast


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

	;==========================
	; load updated verb table

	; we are PEASANT2 so locations 5...9 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#5
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table


	;=====================
	; load bg

	; we are PEASANT2 so locations 5...9 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#5
	tax

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
;	sta	last_bg_l
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2
;	sta	last_bg_h

	lda	#$40

	jsr	decompress_lzsa2_fast


	; we are PEASANT2 so locations 5...9 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#5
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
	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_INN
	bne	really_level_over

	; be sure we're in range
	lda	PEASANT_X
	cmp	#6
	bcc	really_level_over	; fine

	cmp	#18
	bcc	to_left
	cmp	#30
	bcc	to_right

really_level_over:

	rts

to_right:
	lda	#31
	sta	PEASANT_X
	rts

to_left:
	lda	#5
	sta	PEASANT_X
	rts


.include "draw_peasant.s"

.include "gr_copy.s"

.include "new_map_location.s"
.include "peasant_move.s"

.include "score.s"

;.include "parse_input.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "graphics_peasantry/graphics_peasant2.inc"
.include "graphics_peasantry/priority_peasant2.inc"

.include "version.inc"

;.include "inventory.s"




; moved to QLOAD

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



map_backgrounds_low:
	.byte	<haystack_lzsa		; 5	-- haystack
	.byte	<puddle_lzsa		; 6	-- puddle
	.byte	<archery_lzsa		; 7	-- archery
	.byte	<river_lzsa		; 8	-- river
	.byte	<knight_lzsa		; 9	-- knight

map_backgrounds_hi:
	.byte	>haystack_lzsa		; 5	-- haystack
	.byte	>puddle_lzsa		; 6	-- puddle
	.byte	>archery_lzsa		; 7	-- archery
	.byte	>river_lzsa		; 8	-- river
	.byte	>knight_lzsa		; 9	-- knight

map_priority_low:
	.byte	<haystack_priority_lzsa		; 5	-- haystack
	.byte	<puddle_priority_lzsa		; 6	-- puddle
	.byte	<archery_priority_lzsa		; 7	-- archery
	.byte	<river_priority_lzsa		; 8	-- river
	.byte	<knight_priority_lzsa		; 9	-- knight

map_priority_hi:
	.byte	>haystack_priority_lzsa		; 5	-- haystack
	.byte	>puddle_priority_lzsa		; 6	-- puddle
	.byte	>archery_priority_lzsa		; 7	-- archery
	.byte	>river_priority_lzsa		; 8	-- river
	.byte	>knight_priority_lzsa		; 9	-- knight

verb_tables_low:
	.byte	<hay_bale_verb_table		; 5	-- haystack
	.byte	<puddle_verb_table		; 6	-- puddle
	.byte	<archery_verb_table		; 7	-- archery
	.byte	<river_stone_verb_table		; 8	-- river
	.byte	<mountain_pass_verb_table	; 9	-- knight

verb_tables_hi:
	.byte	>hay_bale_verb_table		; 5	-- haystack
	.byte	>puddle_verb_table		; 6	-- puddle
	.byte	>archery_verb_table		; 7	-- archery
	.byte	>river_stone_verb_table		; 8	-- river
	.byte	>mountain_pass_verb_table	; 9	-- knight




peasant2_text_lzsa:
.incbin "DIALOG_PEASANT2.LZSA"

;.include "dialog_peasant2.inc"

.include "peasant2_actions.s"
