; Peasant's Quest Ending

; From when the sword hits Trogdor on

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"

ending:
	lda	#0
	sta	GAME_OVER

	jsr	hgr_make_tables

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called


	lda	#0
	sta	FRAME

	; update score

	jsr	update_score

	; start music?


trogdor_cave:

	lda	#<trogdor_cave_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_cave_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

boat:

	lda	#<lake_e_boat_lzsa
	sta	getsrc_smc+1
	lda	#>lake_e_boat_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress


waterfall:

	lda	#<waterfall_lzsa
	sta	getsrc_smc+1
	lda	#>waterfall_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

jhonka:

	lda	#<jhonka_lzsa
	sta	getsrc_smc+1
	lda	#>jhonka_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

cottage:

	lda	#<cottage_lzsa
	sta	getsrc_smc+1
	lda	#>cottage_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress



final_screen:

	lda	#<the_end_lzsa
	sta	getsrc_smc+1
	lda	#>the_end_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

game_over:

	jsr	game_over


peasant_text:
	.byte 25,2,"Peasant's Quest",0


.include "decompress_fast_v2.s"
.include "wait_keypress.s"

;.include "draw_peasant.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
;.include "hgr_7x28_sprite_mask.s"
.include "hgr_1x5_sprite.s"
;.include "hgr_save_restore.s"
.include "hgr_partial_save.s"
.include "hgr_input.s"
.include "hgr_tables.s"
.include "hgr_text_box.s"
.include "clear_bottom.s"
.include "gr_offsets.s"

.include "gr_copy.s"

.include "score.s"

.include "wait_a_bit.s"

.include "version.inc"

.include "graphics_end/ending_graphics.inc"
