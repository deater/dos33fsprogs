; Peasant's Quest Ending

; From when the sword hits Trogdor on

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"

trogdor:
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

trogdor_open:

	lda	#<trogdor_open_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_open_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress


trogdor_flame1:

	lda	#<trogdor_flame1_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_flame1_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

trogdor_flame2:

	lda	#<trogdor_flame2_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_flame2_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress


game_over:

;	jsr	game_over

	jsr	trogdor_cave


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

.include "graphics_trogdor/trogdor_graphics.inc"

trogdor_string:
	.byte 34,"I can honestly say it'll",13
	.byte "be a pleasure and an honor",13
	.byte "to burninate you, Rather",13
	.byte "Dashing.",0

trogdor_string2:
	.byte "Aw that sure was nice of",13
	.byte "him!",0

trogdor_string3:
	.byte "Congratulations! You've",13
	.byte "won! No one can kill",13
	.byte "Trogdor but you came closer",13
	.byte "than anybody ever! Way to",13
	.byte "go!",0

