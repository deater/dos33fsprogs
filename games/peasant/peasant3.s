; Peasant's Quest

; Peasantry Part 3 (third line of map)

WHICH_PEASANTRY = 2

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"


peasant_quest:
	lda	#0
	sta	GAME_OVER

	jsr	hgr_make_tables

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called





	lda	#0
	sta	FRAME

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

	jsr	save_bg_7x28

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
	jsr	WAIT


	jmp	game_loop

oops_new_location:
	jmp	new_location


	;************************
	; exit level
	;************************
game_over:
	rts


peasant_text:
	.byte 25,2,"Peasant's Quest",0



.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "draw_peasant.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
.include "hgr_7x28_sprite_mask.s"
.include "hgr_1x5_sprite.s"
;.include "hgr_save_restore.s"
.include "hgr_partial_save.s"
.include "hgr_input.s"
.include "hgr_tables.s"
.include "hgr_text_box.s"
.include "clear_bottom.s"

.include "gr_copy.s"

.include "new_map_location.s"
.include "peasant_move.s"

.include "score.s"

.include "parse_input.s"

.include "inventory.s"

.include "keyboard.s"

.include "wait_a_bit.s"

.include "graphics/graphics_peasant3.inc"
.include "graphics/priority_peasant3.inc"

.include "version.inc"

help_message:
.byte   0,43,24, 0,253,82
.byte   8,41,"I don't understand. Type",13
.byte	     "HELP for assistances.",0

fake_error1:
.byte   0,43,24, 0,253,82
.byte   8,41,"?SYNTAX ERROR IN 1020",13
.byte	     "]",127,0

fake_error2:
.byte   0,43,24, 0,253,82
.byte   8,41,"?UNDEF'D STATEMENT ERROR",13
.byte	     "]",127,0



map_backgrounds_low:
;	.byte	<todo_lzsa		; 0
;	.byte	<todo_lzsa		; 1
;	.byte	<todo_lzsa		; 2
;	.byte	<waterfall_lzsa		; 3	-- temp intentional bug
;	.byte	<waterfall_lzsa		; 4	-- waterfall
;	.byte	<todo_lzsa		; 5
;	.byte	<todo_lzsa		; 6
;	.byte	<todo_lzsa		; 7
;	.byte	<river_lzsa		; 8	-- river
;	.byte	<knight_lzsa		; 9	-- knight
	.byte	<jhonka_lzsa		; 10	-- jhonka
	.byte	<cottage_lzsa		; 11	-- cottage
	.byte	<lake_w_lzsa		; 12	-- lake west
	.byte	<lake_e_boat_lzsa		; 13	-- lake east
	.byte	<inn_lzsa		; 14	-- inn
;	.byte	<todo_lzsa		; 15
;	.byte	<todo_lzsa		; 16
;	.byte	<todo_lzsa		; 17
;	.byte	<lady_cottage_lzsa	; 18	-- cottage lady
;	.byte	<crooked_tree_lzsa	; 19	-- crooked tree

map_backgrounds_hi:
;	.byte	>todo_lzsa		; 0
;	.byte	>todo_lzsa		; 1
;	.byte	>todo_lzsa		; 2
;	.byte	>todo_lzsa		; 3
;	.byte	>waterfall_lzsa		; 4	-- waterfall
;	.byte	>todo_lzsa		; 5
;	.byte	>todo_lzsa		; 6
;	.byte	>todo_lzsa		; 7
;	.byte	>river_lzsa		; 8	-- river
;	.byte	>knight_lzsa		; 9	-- knight
	.byte	>jhonka_lzsa		; 10	-- jhonka
	.byte	>cottage_lzsa		; 11	-- cottage
	.byte	>lake_w_lzsa		; 12	-- lake west
	.byte	>lake_e_boat_lzsa		; 13	-- lake east
	.byte	>inn_lzsa		; 14	-- inn
;	.byte	>todo_lzsa		; 15
;	.byte	>todo_lzsa		; 16
;	.byte	>todo_lzsa		; 17
;	.byte	>lady_cottage_lzsa	; 18	-- cottage lady
;	.byte	>crooked_tree_lzsa	; 19	-- crooked tree


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
