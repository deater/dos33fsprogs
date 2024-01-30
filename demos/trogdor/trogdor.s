; TROGDOR 2024

.include "hardware.inc"
.include "zp.inc"
.include "qload.inc"
.include "music.inc"
.include "flames.inc"

hposn_low       = $1e00
hposn_high      = $1f00

trogdor_main:

	;======================================
	; init
	;======================================

	; clear screen to white0

	lda	#$0
	sta	DRAW_PAGE

	; clear PAGE1 to white

	ldy	#$7f
	jsr	hgr_clear_screen

	; set to HIRES PAGE1

	bit     SET_GR
        bit     HIRES
        bit     FULLGR
        bit     PAGE1

	lda	#$20
	sta	DRAW_PAGE


	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	trog_no_music

	cli			; start music
trog_no_music:


	;======================================
	; draw SCENE 1
	;======================================
	; o/~ TRODOR! o/~

	; scroll in zoomed in trogdor from right to left
	; for 60 frames (roughly 2s)

	; decompress trogdor to $6000

	lda	#<trog00_graphics
	sta	zx_src_l+1
	lda	#>trog00_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	; copy+magnify to PAGE2

	lda	#20
	sta	SPRITE_Y
	lda	#0
	sta	SPRITE_X

	lda	#$60
	jsr	hgr_copy_magnify

	jsr	horiz_pan_skip

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	horiz_pan_skip

	jsr	hgr_page_flip

	;======================================
	; draw SCENE 2
	;======================================
	; 156
	;
	; draw flames on white background
	;	left flame short 2 frames
	;	left tall 1212 roughly 10 frames (1/2 s)
	;	both short 2 frames
	;	right tall 1212 roughly 10 frames
	;	right short 2 frames
	; 	left frame short 2 frames
	;	left tall 1212 roughly 10 frames (1/2 s)
	;	left short 2 frames

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_page_flip

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_page_flip


	lda	#0			; blank bg
	sta	FLAME_BG

	lda	#8			; x-coords for two flames
	sta	FLAME_L
	lda	#24
	sta	FLAME_R

	jsr	do_flames

	;=============================
	;	blank screen


	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_page_flip



	;======================================
	; draw SCENE 3
	;======================================
	; o/~ TROGDOR! o/~

	; scroll trogdor intro place

	; takes rougly 90 frames (3s) to scroll in
	; 	remains there 10 frames (almost .5s)

	; orignal: 28s, want 9 times faster???
	; can easily do 8 times...

	; now should be on PAGE1??

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_page_flip

	lda	#0
	sta	COUNT

scroll_in_loop:

	jsr	hgr_vertical_scroll_left

	lda	COUNT
	clc
	adc	#8

	cmp	#200
	bne	scroll_in_loop

	; do this in advance
	; decompress countryside to $2000

	lda	#<trog01_graphics
	sta	zx_src_l+1
	lda	#>trog01_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp


	lda	#10
	jsr	wait_ticks


	;======================================
	; draw SCENE 4
	;======================================
	; o/~ Trogdor was a o/~

	; countrside scrolls in
	;	roughly 45 frames?  1.5s?
	; only 9 bytes wide



	; decompress second part to $4000

	lda	#<$FA00
	sta	zx_src_l+1
	lda	#>$FA00
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	; pan 9 times

	lda	#9
	jsr	horiz_pan

	;======================================
	; draw SCENE 5
	;======================================
	; o/~ man ... o/~
	; 359
	; 	trogdor man:	42 frames
	;	flames: left: llll1122
	;	flames: bb
	;	flames: right 22112211ss
	;	flames: left  ss11221122ss
	;	flames gone:	30 frames (roughly 1s)
	;	dragon man:	160 frames (roughly 5s)


	;======================================
	; man for 42 frames

	lda	#<trog03_graphics
	sta	zx_src_l+1
	lda	#>trog03_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_left

	jsr	hgr_page_flip

	lda	#20
	jsr	wait_ticks

	;=====================
	; do flames

	lda	#1
	sta	FLAME_BG
	jsr	do_flames

	;=====================
	; done flames

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_left

	jsr	hgr_page_flip

	lda	#10
	jsr	wait_ticks


	;======================================
	; dragon man
	; o/~ I mean he was a dragon man o/~
	; o/~ Maybe he was just a ... o/~

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	hgr_page_flip

	lda	#160
	jsr	wait_ticks

	lda	#120
	jsr	wait_ticks



	;======================================
	; draw SCENE 6
	;======================================
	; o/~ dragon, eh, but he was still  o/~

	; 634
	;	dragon:		150 frames (roughly 5s)
	;=======================================

	ldy	#$7f
	jsr	hgr_clear_screen

	lda	#<trog00_graphics
	sta	zx_src_l+1
	lda	#>trog00_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	jsr	hgr_copy_left

	jsr	hgr_page_flip

	lda	#160
	jsr	wait_ticks
	lda	#100
	jsr	wait_ticks


	;======================================
	; draw SCENE 6a
	;======================================
	; o/~ Trogdor!  o/~
	;==========================
	;	dragon zoom:	5 frames
	; dragon zoom
	;
	;	dragon:		5 frames \
	;	dragon zoom:	5 frames / repeat 6 times
	; 	dragon zoom scroll off screen: 30 frames
	;	white screen:	20 frames
	; zoomed off screen by end of the Trogdor
	;=======================================


	lda	#0
	sta	SPRITE_X
	lda	#20
	sta	SPRITE_Y

	lda	#$60
	jsr	hgr_copy_magnify

	;===========================
	; rapidly switch


	lda	#12
	sta	ANIMATE_COUNT
rapid_switch:
	jsr	hgr_page_flip

	lda	#7
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	rapid_switch


	;===========================
	; scroll off screen

	; switch to page1
	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_copy_left
	jsr	hgr_page_flip

	lda	#0
	sta	COUNT

scroll_down_in_loop:

	jsr	hgr_vertical_scroll_down_left

	lda	COUNT
	clc
	adc	#8
	sta	COUNT

	cmp	#200
	bne	scroll_down_in_loop

	;=========================
	; clear to white screen

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_page_flip

	;=========================
	; pre-load dragonman graphics

	lda	#<trog03_graphics
	sta	zx_src_l+1
	lda	#>trog03_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

;	lda	#10
;	jsr	wait_ticks


	;======================================
	; draw SCENE 7
	;======================================
	; o/~ Trogdor! o/~

	; 916
	; dragonman, flames both low than high
	;		ll1122
	;	10 times

	; then full man 1122
	; dragonman 1122
	; man		1122
	; dragonman 1122
	; man 		1122
	; dragonmna 1122
	; man 	1122

	; dragonman low, off 4 frames

	; in practice we can't draw this as fast as the original

	;===============================
	; dragonman with twin low flames

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	draw_twin_flames_low

	jsr	hgr_page_flip

	lda	#1
	jsr	wait_ticks

	;===============================
	; dragonman 1122 10 times

	lda	#2
	sta	ANIMATE_COUNT
long_tall:

	jsr	dman_flames

	dec	ANIMATE_COUNT
	bne	long_tall

	;========================
	; then full man 1122
	; dragonman 1122
	; man		1122
	; dragonman 1122
	; man 		1122
	; dragonmna 1122
	; man 	1122

	jsr	man_flames
	jsr	dman_flames
	jsr	man_flames
;	jsr	dman_flames
;	jsr	man_flames
;	jsr	dman_flames
;	jsr	man_flames

	;===============================
	; dragonman low, 2 frames

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	draw_twin_flames_low

	jsr	hgr_page_flip

	lda	#1
	jsr	wait_ticks

	;================================
	; dragonman off, 4 frames

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	hgr_page_flip

;	lda	#2
;	jsr	wait_ticks


	;======================================
	; draw SCENE 8
	;======================================
	; o/~ Burninating the countryside o/~
	; 1009
	; countryside for 75 frames
	; then flames in middle low
	;	flames high 12 * 16

	lda	#<trog01_graphics
	sta	zx_src_l+1
	lda	#>trog01_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	lda	#$60
	jsr	hgr_copy_fast

	jsr	hgr_page_flip

	lda	#100
	jsr	wait_ticks


	;===============================
	; o/~ Burninating the... o/~


	lda	#6
	sta	ANIMATE_COUNT
country_flames:

	lda	#$60
	jsr	hgr_copy_fast

	ldx	#11
	jsr	draw_flame_tall_1
	ldx	#21
	jsr	draw_flame_tall_2

	jsr	hgr_page_flip

;	lda	#2
;	jsr	wait_ticks

	lda	#$60
	jsr	hgr_copy_fast


	ldx	#11
	jsr	draw_flame_tall_2
	ldx	#21
	jsr	draw_flame_tall_1

	jsr	hgr_page_flip

;	lda	#2
;	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	country_flames


	;======================================
	; draw SCENE 9
	;======================================
	; o/~ peasants o/~
	; 1171
	; big peasant head scrolling in right to left (also going down?)
	;	roughly 60 frames

	; decompress trogdor+peasant to $6000

	lda	#<trog00_graphics
	sta	zx_src_l+1
	lda	#>trog00_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	; clear screen

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_page_flip

	ldy	#$7f
	jsr	hgr_clear_screen
;	jsr	hgr_page_flip

	; want to be on PAGE2 here, how to force?


	; copy+magnify to PAGE2

	lda	#20
	sta	SPRITE_X
	lda	#0
	sta	SPRITE_Y

	lda	#$60
	jsr	hgr_copy_magnify

	jsr	horiz_pan_skip


	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

	lda	#20
	jsr	horiz_pan_skip_short

	jsr	hgr_page_flip

	;======================================
	; draw SCENE 10
	;======================================
	; o/~ Burninating all the o/~
	; 1229
	; zoom trogdor down 5 frames
	; zoom trogdor up 5 frames
	; repeat total of 6 times

	lda	#<trog04_graphics
	sta	zx_src_l+1
	lda	#>trog04_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp


	lda	#00
	sta	SPRITE_X
	lda	#0
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify

	jsr	hgr_page_flip

	lda	#0
	sta	SPRITE_X
	lda	#96
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify

; ?h
;	lda	#$60
;	jsr	hgr_copy_magnify

	;======================
	; animate

	lda	#8
	sta	ANIMATE_COUNT
up_down_animate:
	jsr	hgr_page_flip
	lda	#7
	jsr	wait_ticks
	dec	ANIMATE_COUNT
	bne	up_down_animate



	;======================================
	; draw SCENE 11
	;======================================
	; o/~ People in their o/~
	; 1284
	;
	; Uncover peasants, 5 frames each
	;    R2    R4      L5
	;      L3        L1
	; then wait 25 frames

	lda	#<trog00_graphics
	sta	zx_src_l+1
	lda	#>trog00_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp


	lda	#1
	sta	COUNT
peasant_outer_loop:

	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#0
peasant_inner_loop:
	stx	ANIMATE_COUNT

	lda	peasant_data_x1,X
	sta	COPY_X1
	lda	peasant_data_width,X
	sta	COPY_WIDTH
	lda	peasant_data_y1,X
	sta	COPY_Y1
	lda	peasant_data_y2,X
	sta	COPY_Y2
	lda	peasant_data_sprite_x,X
	sta	SPRITE_X
	lda	peasant_data_sprite_y,X
	sta	SPRITE_Y

	jsr	hgr_copy_part

	ldx	ANIMATE_COUNT
	inx

	cpx	COUNT
	bne	peasant_inner_loop

	jsr	hgr_page_flip

	lda	#10
	jsr	wait_ticks

	inc	COUNT
	lda	COUNT
	cmp	#6
	bne	peasant_outer_loop

	lda	#10
	jsr	wait_ticks


	;======================================
	; draw SCENE 12
	;======================================
	; o/~ thatched roof cot... o/~
	; white screen
	; scroll up cottage, takes roughly 90 frames (3s)

	; must be at PAGE1 here

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_page_flip

;	ldy	#$7f
;	jsr	hgr_clear_screen
;	jsr	hgr_page_flip

	lda	#<trog04_graphics
	sta	zx_src_l+1
	lda	#>trog04_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	lda	#0
	sta	COUNT

scroll_in_loop2:

	jsr	hgr_vertical_scroll_right

	lda	COUNT
	clc
	adc	#8

	cmp	#200
	bne	scroll_in_loop2

;	lda	#10
;	jsr	wait_ticks


	;======================================
	; draw SCENE 13
	;======================================
	; o/~ ...tages o/~
	; 1429
	; trog down, 5 frames
	; cottage , 5 frames
	; trog up, 5 frames
	; cottage, 5 frames
	; overall: DCUC DCUC DC

	lda	#<trog04_graphics
	sta	zx_src_l+1
	lda	#>trog04_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	jsr	down_cottage
	jsr	up_cottage
	jsr	down_cottage
;	jsr	up_cottage
;	jsr	down_cottage

	;======================================
	; draw SCENE 14
	;======================================
	; o/~ Thatched roof cottages o/~
	; 1479
	; low flames, tall flames at edges
	;	60 frames as cottage comes in upside down from top
	; 6 frames of that

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	draw_twin_flames_low
	jsr	hgr_page_flip

	lda	#1
	jsr	wait_ticks

	;======================
	; scroll in upside down


	lda	#0
	sta	COUNT
scroll_down_loop:

	ldy	#$7f
	jsr	hgr_clear_screen

	;============================
	; draw COUNT...0 ($6000) to 0...COUNT (DRAW_PAGE)
	;	IN			OUT

	ldx	COUNT			; in ptr
	ldy	#0			; out ptr
scroll_down_cottage_outer:

	lda	hposn_low,Y
	sta	OUTL
	lda	hposn_high,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	hposn_low,X
	clc
	adc	#10			; right side
	sta	INL
	lda	hposn_high,X
	clc
	adc	#$40			; $6000
	sta	INH

	tya
	pha

	ldy	#29
scroll_down_cottage_inner:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	cpy	#9
	bne	scroll_down_cottage_inner

	pla
	tay

	iny
	dex
	cpx	#$FF
	bne	scroll_down_cottage_outer

.if 0
	;============================
	; draw COUNT...192 as white (not needed? keeps frame rate const?)

	ldx	COUNT
scroll_down_white_outer:

	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	#$7f
	ldy	#29
scroll_down_white_inner:
	sta	(OUTL),Y
	dey
	cpy	#9
	bne	scroll_down_white_inner

	inx
	cpx	#192
	bne	scroll_down_white_outer
.endif
	;============================
	; draw flames

	lda	COUNT		; 0x08
	and	#$08
	bne	upside_down_flame_2

upside_down_flame_1:
	jsr	draw_twin_flames_tall_1
	jmp	done_upside_down_flame
upside_down_flame_2:
	jsr	draw_twin_flames_tall_2
done_upside_down_flame:

	jsr	hgr_page_flip
	lda	COUNT
	clc
	adc	#8
	sta	COUNT

	cmp	#176
	bne	scroll_down_loop

	;================================
	; done

;	lda	#10
;	jsr	wait_ticks


	;======================================
	; draw SCENE 15
	;======================================
	; o/~ ... o/~
	; 1561
	; zoom down 5
	; man 7
	; peasant 5g
	; countryside 5
	; cottage 5
	; trogdor really zoom
	; trogdor normal zoom
	; trogdor intermediate zoom
	; trogdor regular
	;   low flames
	;   high flames 1/2

	;==========================
	; trog down

	lda	#0
	sta	SPRITE_X
	lda	#96
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify

	jsr	hgr_page_flip

;	lda	#2
;	jsr	wait_ticks

	;==========================
	; man

	lda	#<trog03_graphics
	sta	zx_src_l+1
	lda	#>trog03_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	lda	#0
	sta	SPRITE_X
	lda	#0
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify

	jsr	hgr_page_flip

;	lda	#2
;	jsr	wait_ticks

	;===========================
	; peasant

	lda	#<trog00_graphics
	sta	zx_src_l+1
	lda	#>trog00_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	; clear screen

;	ldy	#$7f
;	jsr	hgr_clear_screen

	lda	#20
	sta	SPRITE_X
	lda	#0
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify

	jsr	hgr_page_flip

	;===========================
	; countryside

	lda	#<trog01_graphics
	sta	zx_src_l+1
	lda	#>trog01_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	hgr_page_flip

	;===========================
	; cottage

	lda	#<trog04_graphics
	sta	zx_src_l+1
	lda	#>trog04_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	hgr_page_flip

	;======================================
	; trog pan up (supposed to be zoom out)

	lda	#<trog00_graphics
	sta	zx_src_l+1
	lda	#>trog00_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	;==========================
	; pan 1

	lda	#0
	sta	SPRITE_X
	lda	#90
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify
	jsr	hgr_page_flip

	;==========================
	; pan 2

	lda	#0
	sta	SPRITE_X
	lda	#60
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify
	jsr	hgr_page_flip

	;==========================
	; pan 3

	lda	#0
	sta	SPRITE_X
	lda	#30
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify
	jsr	hgr_page_flip


	;==========================
	; full size
	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_left

	jsr	draw_twin_flames_low

	jsr	hgr_page_flip

	lda	#1
	jsr	wait_ticks

	;=======================
	; 1

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_copy_left
	jsr	draw_twin_flames_tall_1
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks

	;=======================
	; 2

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_copy_left
	jsr	draw_twin_flames_tall_2
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks

	;=======================
	; 1

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_copy_left
	jsr	draw_twin_flames_tall_1
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks


	;======================================
	; draw SCENE 16
	;======================================
	; o/~ and the trogdor comes in the night o/~
	; strongbad at computer

	lda	#<$900
	sta	zx_src_l+1
	lda	#>$900
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	hgr_page_flip


finished:
	bit	KEYRESET
	jsr	wait_until_keypress
	jsr	hgr_page_flip

	jmp	finished


trog00_graphics:
.incbin "graphics/actual00_trog_peasant.hgr.zx02"

trog01_graphics:
.incbin "graphics/trog01_countryside.hgr.zx02"

trog03_graphics:
.incbin "graphics/actual01_dragonman.hgr.zx02"

trog04_graphics:
.incbin "graphics/actual02_updown_cottage.hgr.zx02"


.include "wait_keypress.s"



peasant_data_x1:
	.byte	20, 20, 20, 20, 20
peasant_data_width:
	.byte	 9,  8,	 9,  8,  9
peasant_data_y1:
	.byte	 0, 98,  0, 98,	 0
peasant_data_y2:
	.byte	96,176,	96,176, 96
peasant_data_sprite_x:
	.byte	22,  4, 12, 16, 28
peasant_data_sprite_y:
	.byte	92, 30, 91,  2,  8


	;==========================
	; man flames

man_flames:
	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_left

	jmp	dman_flames_common

	;==========================
	; dragonman flames

dman_flames:
	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right


dman_flames_common:
	jsr	draw_twin_flames_tall_1

	jsr	hgr_page_flip

;	lda	#1
;	jsr	wait_ticks

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	draw_twin_flames_tall_2

	jsr	hgr_page_flip

;	lda	#1
;	jsr	wait_ticks

	rts




down_cottage:
	lda	#0
	sta	SPRITE_X
	lda	#96
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify

	jsr	hgr_page_flip

	lda	#5
	jsr	wait_ticks

	jmp	common_cottage

up_cottage:
	lda	#0
	sta	SPRITE_X
	lda	#0
	sta	SPRITE_Y
	lda	#$60
	jsr	hgr_copy_magnify

	jsr	hgr_page_flip

	lda	#5
	jsr	wait_ticks

common_cottage:
	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	hgr_page_flip

	lda	#5
	jsr	wait_ticks

	rts
