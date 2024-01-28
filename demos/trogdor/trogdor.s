; TROGDOR 2024

.include "hardware.inc"
.include "zp.inc"
.include "qload.inc"
.include "music.inc"
.include "flames.inc"

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

	lda	#$60
	jsr	hgr_copy_magnify

	jsr	horiz_pan_skip

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	horiz_pan_skip

	jsr	hgr_page_flip

.if 0
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

	lda	#10
	jsr	wait_ticks


	;======================================
	; draw SCENE 4
	;======================================
	; countrside scrolls in
	;	roughly 45 frames?  1.5s?
	; only 9 bytes wide

	; decompress countryside to $2000

	lda	#<trog01_graphics
	sta	zx_src_l+1
	lda	#>trog01_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	; decompress second part to $4000

	lda	#<$FA00
	sta	zx_src_l+1
	lda	#>$FA00
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	; pan 9 times
	; FIXME: update timing

	lda	#9
	jsr	horiz_pan

	;======================================
	; draw SCENE 5
	;======================================
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

	lda	#42
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

	lda	#30
	jsr	wait_ticks


	;======================================
	; dragon man

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	hgr_page_flip

	lda	#160
	jsr	wait_ticks



	;======================================
	; draw SCENE 6
	;======================================
	; 634
	;	dragon:		150 frames (roughly 5s)
	;	dragon zoom:	5 frames
	;
	;	dragon:		5 frames \
	;	dragon zoom:	5 frames / repeat 6 times
	; 	dragon zoom scroll off screen: 30 frames
	;	white screen:	20 frames

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

	lda	#50		; should be 250?
	jsr	wait_ticks

	;==========================
	; dragon zoom

	lda	#$60
	jsr	hgr_copy_magnify

	;===========================
	; rapidly switch


	lda	#12
	sta	ANIMATE_COUNT
rapid_switch:
	jsr	hgr_page_flip

	lda	#5
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

	lda	#20
	jsr	wait_ticks
.endif

	;======================================
	; draw SCENE 7
	;======================================
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


	;=========================
	; load dragonman graphics

	lda	#<trog03_graphics
	sta	zx_src_l+1
	lda	#>trog03_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	;===============================
	; dragonman with twin low flames

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	draw_twin_flames_low

	jsr	hgr_page_flip

	lda	#5
	jsr	wait_ticks

	;===============================
	; dragonman 1122 10 times

	lda	#10
	sta	ANIMATE_COUNT
long_tall:

	jsr	dman_flames

;	ldy	#$7f
;	jsr	hgr_clear_screen

;	jsr	hgr_copy_right

;	jsr	draw_twin_flames_tall_1

;	jsr	hgr_page_flip

;	lda	#2
;	jsr	wait_ticks

;	ldy	#$7f
;	jsr	hgr_clear_screen

;	jsr	hgr_copy_right

;	jsr	draw_twin_flames_tall_2

;	jsr	hgr_page_flip

;	lda	#2
;	jsr	wait_ticks

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
	jsr	dman_flames
	jsr	man_flames
	jsr	dman_flames
	jsr	man_flames

	;===============================
	; dragonman low, 2 frames

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	draw_twin_flames_low

	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks

	;================================
	; dragonman off, 4 frames

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks


	;======================================
	; draw SCENE 8
	;======================================
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

	lda	#20
	jsr	wait_ticks

; 12 and 20?


	lda	#16
	sta	ANIMATE_COUNT
country_flames:

	lda	#$60
	jsr	hgr_copy_fast

	ldx	#11
	jsr	draw_flame_tall_1
	ldx	#21
	jsr	draw_flame_tall_2

	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks

	lda	#$60
	jsr	hgr_copy_fast


	ldx	#11
	jsr	draw_flame_tall_2
	ldx	#21
	jsr	draw_flame_tall_1

	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	country_flames



	;======================================
	; draw SCENE 9
	;======================================
	; 1171
	; big peasant head scrolling in right to left (also going down?)
	;	roughly 60 frames

; TODO: big peasant head

	;======================================
	; draw SCENE 10
	;======================================
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

; TODO: fix copy

	lda	#$60
	jsr	hgr_copy_magnify

	jsr	hgr_page_flip

	lda	#$60
	jsr	hgr_copy_magnify

	lda	#12
	sta	ANIMATE_COUNT
up_down_animate:
	jsr	hgr_page_flip
	lda	#10
	jsr	wait_ticks
	dec	ANIMATE_COUNT
	bne	up_down_animate

	;======================================
	; draw SCENE 11
	;======================================
	; Uncover peasants, 5 frames each
	;    R2    R4      L5
	;      L3        L1
	; then wait 25 frames

; TODO: peasant drawing

	;======================================
	; draw SCENE 12
	;======================================
	; white screen
	; scroll up cottage, takes roughly 90 frames (3s)

	; must be at PAGE1 here

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_page_flip

	ldy	#$7f
	jsr	hgr_clear_screen
	jsr	hgr_page_flip

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

	lda	#10
	jsr	wait_ticks


	;======================================
	; draw SCENE 13
	;======================================
	; trog down, 5 frames
	; cottage , 5 frames
	; trog up, 5 frames
	; cottage, 5 frames
	; overall: DCUC DCUC DC

; TODO

	;======================================
	; draw SCENE 14
	;======================================
	; low flames, tall flames at edges
	;	60 frames as cottage comes in upside down from top
	; 6 frames of that

; TODO

	;======================================
	; draw SCENE 15
	;======================================
	; zoom down 5
	; man 7
	; peasant 5
	; countryside 5
	; cottage 5
	; trogdor really zoom
	; trogdor normal zoom
	; trogdor intermediate zoom
	; trogdor regular
	;   low flames
	;   high flames 1/2
; TODO
	;======================================
	; draw SCENE 16
	;======================================
	; strongbad at computer


finished:
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
.include "irq_wait.s"


hposn_low       = $1e00
hposn_high      = $1f00

;.include "hgr_sprite_big_mask.s"
;.include "horiz_scroll_simple.s"
;.include "horiz_scroll_skip.s"
;.include "hgr_copy_magnify.s"
;.include "vertical_scroll.s"
;.include "hgr_copy_part.s"

	.include "vertical_scroll_down.s"
	.include "do_flames.s"

	;=========================================
	; hgr_copy_right
	;=========================================
	; copy right side of $6000 to current page
hgr_copy_right:
	lda	#0
	sta	COPY_Y1
	sta	SPRITE_Y
	lda	#10
	sta	SPRITE_X
	lda	#20
	sta	COPY_X1
	lda	#20
	sta	COPY_WIDTH
	lda	#191
	sta	COPY_Y2

	jmp	hgr_copy_part		; tail call


	;=========================================
	; hgr_copy_left
	;=========================================
	; copy left side of $6000 to current page
hgr_copy_left:
	lda	#0
	sta	COPY_X1
	sta	COPY_Y1
	sta	SPRITE_Y
	lda	#10
	sta	SPRITE_X
	lda	#20
	sta	COPY_WIDTH
	lda	#191
	sta	COPY_Y2

	jmp	hgr_copy_part		; tail call


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

	lda	#2
	jsr	wait_ticks

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_copy_right

	jsr	draw_twin_flames_tall_2

	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks

	rts
