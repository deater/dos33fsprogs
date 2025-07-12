; Archery minigame from Peasant's Quest
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"

hposn_high	= $1000
hposn_low	= $1100

target_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#$00
	sta	DRAW_PAGE

	jsr	hgr_make_tables

	lda	#3
	sta	BOW_X

	;===================
	; Load graphics
	;===================

load_graphics:

	lda	#<bg_data
	sta	zx_src_l+1
	lda	#>bg_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp




game_loop:
	;======================
	; clear flag

	jsr	clear_flag

	;======================
	; pick wind direction

	; 5 possibilities
	; we approximate, 0 is slightly more likely

	jsr	random8
	and	#$f
	tax
	lda	wind_dir_lookup,X
	sta	WIND_DIR

bow_loop:

	;===================
	; check keypress
	;===================

	jsr	keyboard_bow
	bcs	shot_done

	;===================
	; draw bow

	jsr	draw_bow

	;===================
	; draw string

	jsr	draw_string

	;===================
	; draw arrow

	jsr	draw_arrow

	;===================
	; draw windsock

	jsr	draw_flag

	inc	FRAME

	jmp	bow_loop
shot_done:

	jmp	game_loop




	.include	"zx02_optim.s"
	.include	"hgr_sprite.s"
	.include	"hgr_tables.s"
	.include	"keyboard_target.s"

	.include	"draw_bow.s"
	.include	"draw_flag.s"

	.include	"random8.s"

bg_data:
	.incbin "target_graphics/target_bg.hgr.zx02"


	.include "target_sprites/bow_sprites.inc"
	.include "target_sprites/flag_sprites.inc"





	;=======================
	; draw arrow
	;=======================
draw_arrow:

	rts


wind_dir_lookup:
	.byte 0,0,0,1, 1,1,2,2
	.byte 2,3,3,3, 4,4,4,0
