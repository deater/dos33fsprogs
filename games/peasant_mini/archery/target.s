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

	lda	#0
	sta	BOW_INDEX

	; check if odd or even

	lda	BOW_X
	and	#$1
	eor	#$1			; our sprite X is off by one
	asl
	asl
	sta	draw_bow_smc+1

draw_bow_loop:
	clc
	lda	BOW_INDEX
draw_bow_smc:
	adc	#0
	tax

	; set xpos,ypos

	clc
	lda	BOW_X
	adc	bow_sprite_offsets,X
	sta	CURSOR_X
	lda	#159
	sta	CURSOR_Y

	; set up sprites

	lda	bow_sprites_l,X
	sta	INL
	lda	bow_sprites_h,X
	sta	INH

	jsr	hgr_draw_sprite

	inc	BOW_INDEX
	lda	BOW_INDEX
	cmp	#4
	bne	draw_bow_loop


	rts



	;=======================
	; draw string
	;=======================
draw_string:

	lda	#0
	sta	BOW_INDEX

	; check if odd or even

	lda	BOW_X
	and	#$1
	eor	#$1			; our sprite X is off by one
	asl
	sta	draw_string_smc+1

draw_string_loop:
	clc
	lda	BOW_INDEX
draw_string_smc:
	adc	#0
	tax

	; set xpos,ypos

	clc
	lda	BOW_X
	adc	string_sprite_offsets,X
	sta	CURSOR_X
	lda	#183
	sta	CURSOR_Y

	; set up sprites

	lda	string_sprites_l,X
	sta	INL
	lda	string_sprites_h,X
	sta	INH

	jsr	hgr_draw_sprite

	inc	BOW_INDEX
	lda	BOW_INDEX
	cmp	#2
	bne	draw_string_loop


	rts


	;=======================
	; draw arrow
	;=======================
draw_arrow:

	rts

bow_sprite_offsets:
	.byte 0,8,15,22,0,8,15,22

bow_sprites_l:
	.byte <bow_sprite_odd0,<bow_sprite_odd1
	.byte <bow_sprite_odd2,<bow_sprite_odd3
	.byte <bow_sprite_even0,<bow_sprite_even1
	.byte <bow_sprite_even2,<bow_sprite_even3

bow_sprites_h:
	.byte >bow_sprite_odd0,>bow_sprite_odd1
	.byte >bow_sprite_odd2,>bow_sprite_odd3
	.byte >bow_sprite_even0,>bow_sprite_even1
	.byte >bow_sprite_even2,>bow_sprite_even3


string_sprite_offsets:
	.byte 3,14,3,14

string_sprites_l:
	.byte <string_sprite_odd0,<string_sprite_odd1
	.byte <string_sprite_even0,<string_sprite_even1

string_sprites_h:
	.byte >string_sprite_odd0,>string_sprite_odd1
	.byte >string_sprite_even0,>string_sprite_even1

