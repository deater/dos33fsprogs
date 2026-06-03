; Archery minigame from Peasant's Quest
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>

; vaguely trying to make this as similar to the actual game
;	code to make inclusion easier


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

	jsr	hgr_make_tables		; init hi-res lookup tables


	;======================
	; restart game
	;======================
	; reset variables, etc
restart_game:


	lda	#$00
	sta	ARROW_SCORE
	sta	WIND_DIR
	sta	METER_LEFT
	sta	METER_RIGHT



	lda	#4
	sta	ARROWS_LEFT		; 0 indexed, so 5


	;===================
	; Load graphics
	;===================
	; both PAGE1 and PAGE2, with background also at $6000

load_graphics:

	; also load to PAGE1 $2000

	lda	#<bg_data
	sta	zx_src_l+1
	lda	#>bg_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; also load to PAGE2 $4000

	lda	#<bg_data
	sta	zx_src_l+1
	lda	#>bg_data
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp


	; also load to $8000
	; (in actual game would be at $6000, but we are being lazy
	;	and are loading from DOS which is at $9400 or similar
	;	so we can't load the code that high)

	; note we could be copying here which might be faster?

	lda	#<bg_data
	sta	zx_src_l+1
	lda	#>bg_data
	sta	zx_src_h+1

	lda	#$80

	jsr	zx02_full_decomp


	;==============================
	; ???
	;==============================

try_again:


	;==============================
	;==============================
	;==============================
	; Setup for another shot
	;==============================
	;==============================
	;==============================

another_shot:

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

	cmp	WIND_DIR		; try again if same as last time
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
	; clear bottom green

	jsr	clear_bottom_green

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


	;===================
	; draw meter

	jsr	draw_meter_bottom
	jsr	draw_pointers


	;=====================
	; increment frame

	inc	FRAME


	;====================
	; flip page

	jsr	hgr_page_flip


	jmp	bow_loop



	;====================================================================
	;===================
	;===================
	; take shot
	;===================
	;===================
	;===================
	; pull back string
	; start the meter count

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
	; move power meter
	;=======================
	; go for 0..128
	; 	if keypress 1st, lock left, if keypress 2nd lock right

	inc	POWER_METER

	lda	POWER_METER
	cmp	#128
	bcs	end_meter

	cmp	#64
	bcs	going_down
going_up:

	jmp	going_common

going_down:
	; want 128-POWER_METER

	lda	#128
	sec
	sbc	POWER_METER

going_common:
	sta	METER_LEFT
	sta	METER_RIGHT


	;=======================
	; check keypress
	;=======================

;	jsr	keyboard_meter
;	bcs	end_meter

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

	;===================
	; draw meter

	jsr	draw_meter_bottom
	jsr	draw_pointers


	;=====================
	; increment frame

	inc	FRAME


	;====================
	; flip page

	jsr	hgr_page_flip


	jmp	meter_loop



	;====================================================================
	;===================
	;===================
	; move arrow
	;===================
	;===================
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
	.include	"hgr_page_flip.s"

bg_data:
	.incbin "target_graphics/target_bg.hgr.zx02"


	.include "target_sprites/bow_sprites.inc"
	.include "target_sprites/flag_sprites.inc"
	.include "target_sprites/arrow_sprites.inc"


	;===========================
	; draw meter bottom
	;===========================
	; it gets erased by the bow
draw_meter_bottom:

	lda	#36			; 252/7 = 36
	sta	CURSOR_X

	lda	#149
	sta	CURSOR_Y

	lda	#<meter_bottom
	sta	INL
	lda	#>meter_bottom

	sta	INH

	jmp	hgr_draw_sprite		; tail call


	;===========================
	; draw pointers
	;===========================

	; original:
	; draw at 116+(14-METER_LEFT)*4
	;	so if 0, should be 172

	; modified:
	;	draw at 108+(64-METER_LEFTT)

draw_pointers:

	lda	#35			; 245/7 = 35
	sta	CURSOR_X

	lda	#64
	sec
	sbc	METER_LEFT
	clc
	adc	#108

;	lda	#14
;	sec
;	sbc	METER_LEFT
;	asl
;	asl
;	clc
;	adc	#116
	sta	CURSOR_Y

	lda	#<l_pointer
	sta	INL
	lda	#>l_pointer

	sta	INH

	jsr	hgr_draw_sprite

	lda	#38			; 266/7 = 38
	sta	CURSOR_X

	lda	#64
	sec
	sbc	METER_RIGHT
	clc
	adc	#108

;	lda	#14
;	sec
;	sbc	METER_RIGHT
;	asl
;	asl
;	clc
;	adc	#116
	sta	CURSOR_Y

	lda	#<r_pointer
	sta	INL
	lda	#>r_pointer

	sta	INH

	jsr	hgr_draw_sprite



	rts



	;===========================
	; clear bottom
	;===========================
	; unrolled would be faster?
	; clear 149-192 to green

	; green will be: $2a/$55

	; initial = 4cc4 cycles
	; 

clear_bottom_green:

	ldx	#149							; 2

cbg_yloop:
	ldy	#39							; 2

	lda	hposn_low,X						; 4
	sta	cbg_smc1+1						; 4
	sta	cbg_smc2+1						; 4

	lda	hposn_high,X						; 4
	clc								; 2
	adc	DRAW_PAGE						; 2
	sta	cbg_smc1+2						; 4
	sta	cbg_smc2+2						; 4

cbg_xloop:
	lda	#$55							; 2

cbg_smc1:
	sta	$2000,Y							; 5
	dey								; 2

	lda	#$2a							; 2

cbg_smc2:
	sta	$2000,Y							; 5

	dey								; 2
	bpl	cbg_xloop						; 2/3

	inx								; 2
	cpx	#192							; 2
	bne	cbg_yloop						; 2/3

	rts



	;=======================
	; draw arrow
	;=======================
	; note: currently we aren't centered because of the weird
	;	Apple II 3.5-pixel tiles
	; 	Is this worth fixing?

draw_arrow:

	lda	BOW_X
	clc
	adc	#15
	sta	CURSOR_X

	lda	#149
	sta	CURSOR_Y

	lda	BOW_X
	lsr
	bcs	draw_arrow_even
draw_arrow_odd:
	lda	#<arrow_odd_sprite
	sta	INL
	lda	#>arrow_odd_sprite
	jmp	draw_arrow_common
draw_arrow_even:
	lda	#<arrow_even_sprite
	sta	INL
	lda	#>arrow_even_sprite
draw_arrow_common:

	sta	INH

	jsr	hgr_draw_sprite

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

