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

	;=======================================
	; clear screen and print opening message
	;=======================================
	jsr	HOME

	bit	KEYRESET

	jsr	set_normal

	lda	#<opening_string
	sta	OUTL
	lda	#>opening_string
	sta	OUTH

	jsr	move_and_print_list

	jsr	wait_until_keypress

	;===================
	; set graphics mode
	;===================

	bit	HIRES
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
	bit	FULLGR

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

	;=======================
	; clear flag both pages

	lda	DRAW_PAGE
	pha

	lda	#0
	sta	DRAW_PAGE
	jsr	clear_flag

	lda	#$20
	sta	DRAW_PAGE
	jsr	clear_flag

	pla
	sta	DRAW_PAGE

	;=========================
	; clear keyboard strobe
	;	in case pressed any button while arrow flying

	bit	KEYRESET


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

	;=====================
	; reset meter

	lda	#0
	sta	METER_LEFT
	sta	METER_RIGHT



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
	sta	METER_PRESSES

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

	ldx	METER_PRESSES
	cpx	#2
	bcs	presses_two
	cpx	#1
	bcs	presses_one

presses_none:
	sta	METER_LEFT
presses_one:
	sta	METER_RIGHT
presses_two:

	;=======================
	; check keypress
	;=======================

	jsr	keyboard_meter
	bcc	no_presses

	inc	METER_PRESSES
	lda	METER_PRESSES
	cmp	#2
	bcs	end_meter


no_presses:

	;===================
	; clear bottom green

	jsr	clear_bottom_green


	;===================
	; draw bow

	jsr	draw_bow

	;===================
	; draw string

	jsr	draw_drawn_string

	;===================
	; draw arrow

	jsr	draw_arrow_nostring

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
end_meter:


	;====================================================================
	;===================
	;===================
	; move arrow
	;===================
	;===================
	;===================

actually_shoot_arrow_arrow:

	lda	#0
	sta	FRAME

	;======================
	; erase arrow

	; it's erased just before it's shot
	; we have to erase it from both pages

	lda	DRAW_PAGE
	pha

	lda	#0
	sta	DRAW_PAGE
	jsr	erase_arrow_from_pile
	lda	#$20
	sta	DRAW_PAGE
	jsr	erase_arrow_from_pile
	pla
	sta	DRAW_PAGE


	lda	#0
	sta	backup1_valid
	sta	backup2_valid
	sta	HIT_OFFSET

	;===================
	;===================
	; arrow loop
	;===================
	;===================

arrow_loop:

	;===================
	; clear bottom green

	jsr	clear_bottom_green

	;===================
	; draw bow

	jsr	draw_bow

	;===================
	; draw string

	jsr	draw_string

	;====================
	; erase old arrow

	jsr	restore_arrow_bg

	;=====================
	; move arrow

	jsr	move_arrows

	;=====================
	; save arrow bg

	jsr	backup_arrow_bg

	;===================
	; draw moving arrow

	jsr	draw_arrow_move
	bcs	end_arrow

	;===================
	; draw windsock

	jsr	draw_flag

	;===================
	; draw meter

	jsr	draw_meter_bottom
	jsr	draw_pointers

	;===================
	; increment frame

	inc	FRAME

	lda	FRAME
	cmp	#21			; 21 frames of shooting animation
	beq	end_arrow

	;====================
	; flip page

	jsr	hgr_page_flip

	jmp	arrow_loop


end_arrow:

	;===========================
	; check if bullseye
	;===========================

	jsr	check_bullseye
	bcc	no_bullseye

yes_bullseye:

	; draw circle, both pages

	lda	DRAW_PAGE
	pha

	lda	#0
	sta	DRAW_PAGE

	jsr	draw_circle

	lda	#$20
	sta	DRAW_PAGE

	jsr	draw_circle

	pla
	sta	DRAW_PAGE


	; increment hits
	inc	ARROW_SCORE

	; play sound effect?



no_bullseye:


	;=======================================================
	;=====================
	; next turn
	;=====================
	;=====================

	;=====================
	; decrement tries

	dec	ARROWS_LEFT
	bmi	game_over


	jmp	try_again

	;======================
	; print game over message

game_over:
	; clear any lingering keypresses
	bit	KEYRESET

	; flip to page1 and allow text on bottom 4 lines
	bit	TEXTGR
	bit	PAGE1
	lda	#$0
	sta	DRAW_PAGE

	lda	ARROW_SCORE
	clc
	adc	#'0'
	sta	score_string+9

	lda	#<score_string
	sta	OUTL
	lda	#>score_string
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print


	bit	KEYRESET

wait_until_keypress2:
	lda	KEYPRESS                                ; 4
	bpl	wait_until_keypress2                    ; 3

	cmp	#'N'|$80
	beq	exit_game

	cmp	#'n'|$80
	beq	exit_game

	bit	KEYRESET		; clear the keyboard buffer

	jmp	restart_game

exit_game:
	lda	#0
	sta	WHICH_LOAD

	rts	; will this work?

opening_string:
	.byte 0,0,"ARCHERY GAME",0
	.byte 0,2,"HALDO! TRY TO HIT THE BULLSEYE",0
	.byte 0,4,"THE ARROW KEYS AIM LEFT",0
	.byte 0,5,"AND RIGHT AND THE SPACE BAR",0
	.byte 0,6,"OPERATES THE BOW.",0
	.byte 0,7,"DON'T IGNORE THE WIND!",0
	.byte 0,9,"PRESS ANY KEY TO START",0
	.byte $FF

score_string:
	.byte 0,20,"SCORE: 0",0
	.byte 0,22,"PLAY AGAIN? (Y/N)",0

	.include	"zx02_optim.s"
	.include	"hgr_sprite.s"
	.include	"hgr_tables.s"
	.include	"keyboard_target.s"

	.include	"draw_bow.s"
	.include	"draw_flag.s"

	.include	"move_arrows.s"
	.include	"gr_offsets.s"
	.include	"text_print.s"

	.include	"random8.s"
	.include	"wait_keypress.s"
	.include	"hgr_page_flip.s"
	.include	"hgr_sprite_mask.s"

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


	;======================
	; erase arrow from pile

	; it's erased just before it's shot

erase_arrow_from_pile:

	lda	ARROWS_LEFT
	asl
	sta	CURSOR_X

	lda	#48
	sta	CURSOR_Y

	lda	#<arrow_delete_sprite
	sta	INL
	lda	#>arrow_delete_sprite
	sta	INH

	jmp	hgr_draw_sprite		; tail call



	;===========================
	; clear bottom
	;===========================
	; unrolled would be faster?
	; clear 149-192 to green

	; green will be: $2a/$55

	; initial = 4cc4 cycles


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




wind_dir_lookup:
	.byte 0,0,0,1, 1,1,2,2
	.byte 2,3,3,3, 4,4,4,0

	; 108...176 currently, is 68 high
	;	70/5 = 14 steps

	; 172 ... 108 = 64, 16 steps?  so 4 each?
meter_y_lookup:
	.byte	172,168,164,160, 156,152,148,144
	.byte	140,136,132,128, 124,120,116,112

