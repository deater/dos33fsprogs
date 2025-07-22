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
	; wait until keypress
	;========================================

	bit	KEYRESET

map_wait_loop:

	;========================================
	; draw rather dashing at current position
	;========================================
	; note there is only one position per location
	;	it isn't adjusted for sub-location X,Y
draw_at_location:
	ldx	PREVIOUS_LOCATION
	lda	head_location_x,X
	sta	CURSOR_X
	lda	head_location_y,X
	sta	CURSOR_Y

	lda	FRAME
	and	#$10
	beq	draw_head
draw_blank:
	lda	#<nohead_sprite
	sta	INL
	lda	#>nohead_sprite
	jmp	draw_common

draw_head:
	lda	#<head_sprite
	sta	INL
	lda	#>head_sprite

draw_common:
	sta	INH

	jsr	hgr_draw_sprite

wait_for_keypress:
	lda	KEYPRESS				; 4
	bmi	done_map

	inc	FRAME

	lda	#100
	jsr	wait

	jmp	map_wait_loop

done_map:

	bit	KEYRESET	; clear the keyboard buffer

	lda	PREVIOUS_LOCATION	; return to previous location

	jmp	update_map_location


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

;================
; HEAD_LOCATIONS

head_location_x:
.byte	7	; 49	; LOCATION_POOR_GARY	=	0
.byte	13	; 91	; LOCATION_KERREK_1	=	1
.byte	20	; 140	; LOCATION_OLD_WELL	=	2
.byte	27	; 189	; LOCATION_YELLOW_TREE	=	3
.byte	31	; 217	; LOCATION_WATERFALL	=	4
.byte	6	; 42	; LOCATION_HAY_BALE	=	5
.byte	12	; 84	; LOCATION_MUD_PUDDLE	=	6
.byte	18	; 126	; LOCATION_ARCHERY	=	7
.byte	26	; 182	; LOCATION_RIVER_STONE	=	8
.byte	30	; 210	; LOCATION_MOUNTAIN_PASS=	9
.byte	5	; 35	; LOCATION_JHONKA_CAVE	=	10
.byte	13	; 91	; LOCATION_YOUR_COTTAGE	=	11
.byte	17	; 119	; LOCATION_LAKE_WEST	=	12
.byte	28	; 196	; LOCATION_LAKE_EAST	=	13
.byte	33	; 231	; LOCATION_OUTSIDE_INN	=	14
.byte	8	; 56	; LOCATION_OUTSIDE_NN	=	15
.byte	14	; 98	; LOCATION_WAVY_TREE	=	16
.byte	19	; 133	; LOCATION_KERREK_2	=	17
.byte	26	; 182	; LOCATION_OUTSIDE_LADY	=	18
.byte	33	; 231	; LOCATION_BURN_TREES	=	19
.byte	36	; 252	; LOCATION_CLIFF_BASE	=	20
.byte	36	; 252	; LOCATION_CLIFF_HEIGHTS=	21
.byte	36	; 252	; LOCATION_TROGDOR_OUTER=	22
.byte	36	; 252	; LOCATION_TROGDOR_LAIR	=	23
.byte	2	; 14	; LOCATION_HIDDEN_GLEN	=	24
.byte	25	; 175	; LOCATION_INSIDE_LADY	=	25
.byte	5	; 35	; LOCATION_INSIDE_NN	=	26
.byte	31	; 217	; LOCATION_INSIDE_INN	=	27
.byte	19	; 133	; LOCATION_ARCHERY_GAME	=	28
.byte	36	; 252	; LOCATION_MAP		=	29
.byte	36	; 252	; LOCATION_CLIMB	=	30
.byte	36	; 252	; LOCATION_OUTER2	=	31
.byte	36	; 252	; LOCATION_OUTER3	=	32
.byte	31	; 217	; LOCATION_INSIDE_INN_NIGHT=	33

head_location_y:
.byte	63		; LOCATION_POOR_GARY	=	0
.byte	63		; LOCATION_KERREK_1	=	1
.byte	63		; LOCATION_OLD_WELL	=	2
.byte	63		; LOCATION_YELLOW_TREE	=	3
.byte	63		; LOCATION_WATERFALL	=	4
.byte	91		; LOCATION_HAY_BALE	=	5
.byte	91		; LOCATION_MUD_PUDDLE	=	6
.byte	105		; LOCATION_ARCHERY	=	7
.byte	98		; LOCATION_RIVER_STONE	=	8
.byte	91		; LOCATION_MOUNTAIN_PASS=	9
.byte	126		; LOCATION_JHONKA_CAVE	=	10
.byte	119		; LOCATION_YOUR_COTTAGE	=	11
.byte	126		; LOCATION_LAKE_WEST	=	12
.byte	126		; LOCATION_LAKE_EAST	=	13
.byte	126		; LOCATION_OUTSIDE_INN	=	14
.byte	154		; LOCATION_OUTSIDE_NN	=	15
.byte	154		; LOCATION_WAVY_TREE	=	16
.byte	147		; LOCATION_KERREK_2	=	17
.byte	161		; LOCATION_OUTSIDE_LADY	=	18
.byte	154		; LOCATION_BURN_TREES	=	19
.byte	84		; LOCATION_CLIFF_BASE	=	20
.byte	84		; LOCATION_CLIFF_HEIGHTS=	21
.byte	84		; LOCATION_TROGDOR_OUTER=	22
.byte	84		; LOCATION_TROGDOR_LAIR	=	23
.byte	70		; LOCATION_HIDDEN_GLEN	=	24
.byte	152		; LOCATION_INSIDE_LADY	=	25
.byte	154		; LOCATION_INSIDE_NN	=	26
.byte	122		; LOCATION_INSIDE_INN	=	27
.byte	91		; LOCATION_ARCHERY_GAME	=	28
.byte	84		; LOCATION_MAP		=	29
.byte	84		; LOCATION_CLIMB	=	30
.byte	84		; LOCATION_OUTER2	=	31
.byte	84		; LOCATION_OUTER3	=	32
.byte	122		; LOCATION_INSIDE_INN_NIGHT=	33







map_index:
	.byte	$01

.include "../new_map_location.s"

.include "graphics_map/map_graphics.inc"
.include "sprites_map/map_sprites.inc"

.include "../hgr_routines/hgr_sprite.s"
