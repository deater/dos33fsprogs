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
	sta	ARROW_SCORE
	sta	WIND_DIR

	lda	#4
	sta	ARROWS_LEFT		; 0 indexed, so 5

	jsr	hgr_make_tables


restart_game:

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


	; also load to $40
	;	in final version prob load to $60 instead

	lda	#<bg_data
	sta	zx_src_l+1
	lda	#>bg_data
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp


try_again:

game_loop:
	;======================
	; clear flag

	jsr	clear_flag

	;======================
	; pick wind direction

	; 5 possibilities
	; we approximate, 0 is slightly more likely

	; in actual game you can't have the same value twice in a row

try_wind_again:
	jsr	random8
	and	#$f
	tax
	lda	wind_dir_lookup,X
	cmp	WIND_DIR
	beq	try_wind_again

	sta	WIND_DIR

	;====================
	; reset bow position

	lda	#3
	sta	BOW_X


	;===================
	;===================
	; bow loop
	;===================
	;===================

bow_loop:

	;===================
	; check keypress
	;===================

	jsr	keyboard_bow
	bcs	take_shot

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

	;===================
	;===================
	; take shot
	;===================
	;===================

take_shot:

	lda	#0			; 0..32?
	sta	POWER_METER

;	lda	#$11
;	sta	METER_ADD

	;===================
	;===================
	; meter loop
	;===================
	;===================

	; actual game
	;	meter-r and meter-l start at origin
	;		+/- 10 until one button press
	;		after, left +/-12 until second button press
	;	goes until meter_r less than meter_mc.y
	;		looks like from 208-350, roughly 140, so 14 steps?

	; horizoffset = (meterl-metery)/5  (max +-15)
	; vertoffset = -(center-r + (center-l)/3, +-15
	; wind -12,-6,0,6,12 (only adjust starting point, not add)
	; each frame add horiz/vert
	

meter_loop:

	;=======================
	; increment power meter
	;=======================

	jsr	keyboard_meter
	bcs	end_meter

	;===================
	; draw bow

;	jsr	draw_bow

	;===================
	; draw string

;	jsr	draw_string

	;===================
	; draw arrow

;	jsr	draw_arrow

	;===================
	; draw windsock

	jsr	draw_flag

	inc	FRAME

	jmp	meter_loop

	;===================

end_meter:


	;===================
	;===================
	; arrow loop
	;===================
	;===================

arrow_loop:



	;===================
	; draw bow

;	jsr	draw_bow

	;===================
	; draw string

;	jsr	draw_string

	;===================
	; draw arrow

;	jsr	draw_arrow

	;===================
	; draw windsock

	jsr	draw_flag

	inc	FRAME

	;===================
	; move arrow

	jmp	arrow_loop

	;===================

end_arrow:

	;=====================
	; decrement tries

	dec	ARROWS_LEFT
	bmi	game_over

	;======================
	; erase arrow

	jmp	try_again

game_over:
	bit	TEXTGR

	lda	ARROW_SCORE
	clc
	adc	#'0'
	sta	score_string+8

	ldx	#0
string_loop:
	lda	score_string,X
	beq	string_loop_done
	sta	$650,X
	inx
	jmp	string_loop
string_loop_done:

	jsr	wait_until_keypress

	bit	FULLGR

	jmp	restart_game

score_string:
	.byte "SCORE: 0   ",0

	.include	"zx02_optim.s"
	.include	"hgr_sprite.s"
	.include	"hgr_tables.s"
	.include	"keyboard_target.s"

	.include	"draw_bow.s"
	.include	"draw_flag.s"

	.include	"random8.s"
	.include	"wait_keypress.s"

bg_data:
	.incbin "target_graphics/target_bg.hgr.zx02"


	.include "target_sprites/bow_sprites.inc"
	.include "target_sprites/flag_sprites.inc"
	.include "target_sprites/arrow_sprites.inc"





	;=======================
	; draw arrow
	;=======================
draw_arrow:

	rts


wind_dir_lookup:
	.byte 0,0,0,1, 1,1,2,2
	.byte 2,3,3,3, 4,4,4,0

	; 108...176 currently, is 68 high
	;	70/5 = 14 steps

	; 172 ... 108 = 64, 16 steps?  so 4 each?
meter_y_lookup:
	.byte	172,168,164,160, 156,152,148,144
	.byte	140,136,132,128, 124,120,116,112

