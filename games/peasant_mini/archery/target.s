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

bow_loop:

	;===================
	; check keypress
	;===================

	jsr	keyboard_bow

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

	; TODO

	inc	FRAME

	jmp	bow_loop





	.include	"zx02_optim.s"
	.include	"hgr_sprite.s"
	.include	"hgr_tables.s"
	.include	"keyboard_target.s"

bg_data:
	.incbin "target_graphics/target_bg.hgr.zx02"


	.include "target_sprites/bow_sprites.inc"



	;=======================
	; draw bow
	;=======================
draw_bow:

	;=======================

	lda	BOW_X
	sta	CURSOR_X
	lda	#159
	sta	CURSOR_Y

	lda	#<bow_sprite0
	sta	INL
	lda	#>bow_sprite0
	sta	INH

	jsr	hgr_draw_sprite

	;==========================

	clc
	lda	BOW_X
	adc	#8

	sta	CURSOR_X
	lda	#159
	sta	CURSOR_Y

	lda	#<bow_sprite1
	sta	INL
	lda	#>bow_sprite1
	sta	INH

	jsr	hgr_draw_sprite

	;====================

	clc
	lda	BOW_X
	adc	#15

	sta	CURSOR_X
	lda	#159
	sta	CURSOR_Y

	lda	#<bow_sprite2
	sta	INL
	lda	#>bow_sprite2
	sta	INH

	jsr	hgr_draw_sprite

	;====================

	clc
	lda	BOW_X
	adc	#22

	sta	CURSOR_X
	lda	#159
	sta	CURSOR_Y

	lda	#<bow_sprite3
	sta	INL
	lda	#>bow_sprite3
	sta	INH

	jsr	hgr_draw_sprite

	rts



	;=======================
	; draw string
	;=======================
draw_string:

.if 0
	;=======================

	lda	BOW_X
	sta	CURSOR_X
	lda	#159
	sta	CURSOR_Y

	lda	#<bow_sprite0
	sta	INL
	lda	#>bow_sprite0
	sta	INH

	jsr	hgr_draw_sprite
.endif
	rts


	;=======================
	; draw arrow
	;=======================
draw_arrow:

	rts
