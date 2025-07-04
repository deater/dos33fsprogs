; Peasant's Quest

; o/~ It's The Map o/~

; by Vince `deater` Weaver	vince@deater.net

.include "../hardware.inc"
.include "../zp.inc"

.include "../qload.inc"
.include "../inventory/inventory.inc"
.include "../parse_input.inc"
.include "../common_defines.inc"

	;=============================================
	; note, we are a level here, loaded from disk
	; so we have to act as one

the_map:
	lda	#0
	sta	LEVEL_OVER
	sta	FRAME


	; FIXME: clear and use DRAW_PAGE

;	jsr	hgr2_clearscreen

	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

	lda	#0
	sta	LEVEL_OVER

	;===========================
	; load bg to current screen?

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE


	lda	#<map_zx02
	sta	zx_src_l+1
	lda	#>map_zx02
	sta	zx_src_h+1

	lda	DRAW_PAGE
	clc
	adc	#$20

	jsr	zx02_full_decomp

	;=============================
	; draw all visited locations
	;=============================

	;============================
	; row 1

	; debug
;	lda	#$1f
;	sta	VISITED_0

	ldx	#0
	lda	#1
	sta	map_index
row1_loop:
	lda	VISITED_0
	and	map_index
	beq	row1_skip_draw
row1_draw:
	lda	row1_x,X
	sta	CURSOR_X
	lda	row1_y,X
	sta	CURSOR_Y

	lda	row1_sprite_l,X
	sta	INL
	lda	row1_sprite_h,X
	sta	INH

	txa
	pha

	jsr	hgr_draw_sprite

	pla
	tax


row1_skip_draw:
	asl	map_index
	inx
	cpx	#5
	bne	row1_loop


	;============================
	; row 2

	; debug
;	lda	#$1f
;	sta	VISITED_1

	ldx	#0
	lda	#1
	sta	map_index
row2_loop:
	lda	VISITED_1
	and	map_index
	beq	row2_skip_draw
row2_draw:
	lda	row2_x,X
	sta	CURSOR_X
	lda	row2_y,X
	sta	CURSOR_Y

	lda	row2_sprite_l,X
	sta	INL
	lda	row2_sprite_h,X
	sta	INH

	txa
	pha

	jsr	hgr_draw_sprite

	pla
	tax


row2_skip_draw:
	asl	map_index
	inx
	cpx	#5
	bne	row2_loop

	;============================
	; row 3

	; debug
;	lda	#$1f
;	sta	VISITED_2

	ldx	#0
	lda	#1
	sta	map_index
row3_loop:
	lda	VISITED_2
	and	map_index
	beq	row3_skip_draw
row3_draw:
	lda	row3_x,X
	sta	CURSOR_X
	lda	row3_y,X
	sta	CURSOR_Y

	lda	row3_sprite_l,X
	sta	INL
	lda	row3_sprite_h,X
	sta	INH

	txa
	pha

	jsr	hgr_draw_sprite

	pla
	tax


row3_skip_draw:
	asl	map_index
	inx
	cpx	#5
	bne	row3_loop

	;============================
	; row 4

	; debug
;	lda	#$1f
;	sta	VISITED_3

	ldx	#0
	lda	#1
	sta	map_index
row4_loop:
	lda	VISITED_3
	and	map_index
	beq	row4_skip_draw
row4_draw:
	lda	row4_x,X
	sta	CURSOR_X
	lda	row4_y,X
	sta	CURSOR_Y

	lda	row4_sprite_l,X
	sta	INL
	lda	row4_sprite_h,X
	sta	INH

	txa
	pha

	jsr	hgr_draw_sprite

	pla
	tax


row4_skip_draw:
	asl	map_index
	inx
	cpx	#5
	bne	row4_loop





	;========================================
	; draw rather dashing at current position
	;========================================
	; note there is only one position per location
	;	it isn't adjusted for sub-location X,Y


map_loop:

	bit	KEYRESET

	jsr	wait_until_keypress

	lda	PREVIOUS_LOCATION	; return to previous location

	jmp	update_map_location

	rts

row1_x:
	.byte  4,10,17,24,29
row1_y:
	.byte 67,52,51,58,55
row1_sprite_l:
	.byte <map00_sprite,<map10_sprite,<map20_sprite
	.byte <map30_sprite,<map40_sprite
row1_sprite_h:
	.byte >map00_sprite,>map10_sprite,>map20_sprite
	.byte >map30_sprite,>map40_sprite

row2_x:
	.byte  3,11,16,22,31
row2_y:
	.byte 80,98,89,85,85
row2_sprite_l:
	.byte <map01_sprite,<map11_sprite,<map21_sprite
	.byte <map31_sprite,<map41_sprite
row2_sprite_h:
	.byte >map01_sprite,>map11_sprite,>map21_sprite
	.byte >map31_sprite,>map41_sprite

row3_x:
	.byte  6,10,17,23,29
row3_y:
	.byte 118,105,106,115,107
row3_sprite_l:
	.byte <map02_sprite,<map12_sprite,<map22_sprite
	.byte <map32_sprite,<map42_sprite
row3_sprite_h:
	.byte >map02_sprite,>map12_sprite,>map22_sprite
	.byte >map32_sprite,>map42_sprite

row4_x:
	.byte  4,10,16,23,29
row4_y:
	.byte 145,139,157,144,143
row4_sprite_l:
	.byte <map03_sprite,<map13_sprite,<map23_sprite
	.byte <map33_sprite,<map43_sprite
row4_sprite_h:
	.byte >map03_sprite,>map13_sprite,>map23_sprite
	.byte >map33_sprite,>map43_sprite






map_index:
	.byte	$01

.include "../new_map_location.s"

.include "graphics_map/map_graphics.inc"
.include "sprites_map/map_sprites.inc"

.include "../hgr_routines/hgr_sprite.s"
