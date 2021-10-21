; Peasant's Quest

; Peasantry Part 3 (third line of map)

; Jhonka, your cottage, w lake, e lake, inn

WHICH_PEASANTRY = 2

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"

peasant_quest:
	lda	#0
	sta	GAME_OVER
	sta	FRAME
	jsr	hgr_make_tables

	jsr	hgr2


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

	;=====================
	; load bg

	; we are PEASANT3 so locations 10...14 map to 0...4, no change

	lda	MAP_LOCATION
	sec
	sbc	#10
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
	sbc	#10
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

.include "gr_copy.s"

.include "new_map_location.s"
.include "peasant_move.s"

.include "score.s"

.include "parse_input.s"

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
