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

	;======================================
	; draw SCENE 2
	;======================================

	; draw flames
	;	left flame short 2 frames
	;	left tall 1212 roughly 10 frames (1/2 s)
	;	both short 2 frames
	;	right tall 1212 roughly 10 frames
	;	right short 2 frames
	; 	left frame short 2 frames
	;	left tall 1212 roughly 10 frames (1/2 s)
	;	left short 2 frames

	;======================================
	;	left flame short 2 frames

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#8
	jsr	draw_flame_small_1
	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks


	;=================================================
	;	left tall 1212 roughly 10 frames (1/2 s)

	lda	#2
	sta	ANIMATE_COUNT
left_flame_animate1:
	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#8
	jsr	draw_flame_tall_1
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks

	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#8
	jsr	draw_flame_tall_2
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	left_flame_animate1

	;==============================
	;	both short 2 frames

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#8
	jsr	draw_flame_small_1

	ldx	#24
	jsr	draw_flame_small_1

	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks


	;===========================================
	;	right tall 1212 roughly 10 frames

	lda	#2
	sta	ANIMATE_COUNT

right_flame_animate1:
	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#24
	jsr	draw_flame_tall_2
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks

	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#24
	jsr	draw_flame_tall_1
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	right_flame_animate1

	;=============================
	;	right short 2 frames

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#24
	jsr	draw_flame_small_2
	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks

	;=============================
	;	left short 2 frames

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#8
	jsr	draw_flame_small_1
	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks

	;================================================
	;	left tall 1212 roughly 10 frames (1/2 s)

	lda	#2
	sta	ANIMATE_COUNT
left_flame_animate2:
	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#8
	jsr	draw_flame_tall_1
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks

	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#8
	jsr	draw_flame_tall_2
	jsr	hgr_page_flip
	lda	#2
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	left_flame_animate2


	;=============================
	;	left short 2 frames

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

	ldx	#8
	jsr	draw_flame_small_1
	jsr	hgr_page_flip

	lda	#2
	jsr	wait_ticks

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

;	lda	#24			; 192/8
;	sta	ANIMATE_COUNT

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
	; 	trogdor man:	42 frames
	;	flames: left: llll1122
	;	flames: bb
	;	flames: right 22112211ss
	;	flames: left  ss11221122ss
	;	flames gone:	30 frames (roughly 1s)
	;	dragon man:	160 frames (roughly 5s)


	;======================================
	; man

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

	lda	#$60
	jsr	hgr_copy_magnify

	lda	#12
	sta	ANIMATE_COUNT
rapid_switch:
	jsr	hgr_page_flip

	lda	#5
	jsr	wait_ticks

	dec	ANIMATE_COUNT
	bne	rapid_switch

	; clear to white screen

	ldy	#$7f
	jsr	hgr_clear_screen

	jsr	hgr_page_flip

	lda	#20
	jsr	wait_ticks


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

	lda	#<trog03_graphics
	sta	zx_src_l+1
	lda	#>trog03_graphics
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	jsr	hgr_copy_right

	jsr	hgr_page_flip

	lda	#20
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

	;======================================
	; draw SCENE 9
	;======================================
	; 1171
	; big peasant head scrolling in right to left (also going down?)
	;	roughly 60 frames


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

	;======================================
	; draw SCENE 12
	;======================================
	; white screen
	; scroll up cottage, takes roughly 90 frames (3s)

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

	;======================================
	; draw SCENE 14
	;======================================
	; low flames, tall flames at edges
	;	60 frames as cottage comes in upside down from top
	; 6 frames of that

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


;hposn_low       = $1e00
;hposn_high      = $1f00

;.include "hgr_sprite_big_mask.s"
;.include "horiz_scroll_simple.s"
;.include "horiz_scroll_skip.s"
;.include "hgr_copy_magnify.s"
;.include "vertical_scroll.s"
;.include "hgr_copy_part.s"

	;===============================
	; draw_flame_small
	;===============================
	; x location in X

draw_flame_small_1:
	lda	#<left_flame_small
	sta	INL
	lda	#>left_flame_small
	sta	INH
	lda	#<left_flame_small_mask
	sta	MASKL
	lda	#>left_flame_small_mask
	bne	draw_flame_small_common		; bra

draw_flame_small_2:
	lda	#<left_flame_small
	sta	INL
	lda	#>left_flame_small
	sta	INH
	lda	#<left_flame_small_mask
	sta	MASKL
	lda	#>left_flame_small_mask

draw_flame_small_common:
	sta	MASKH

	txa
;	lda	#8
	sta	SPRITE_X

	lda	#152
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_big_mask

	rts

	;===============================
	; draw_flame_tall
	;===============================
	; X location in X

draw_flame_tall_1:

	lda	#<left_flame_big
	sta	INL
	lda	#>left_flame_big
	sta	INH
	lda	#<left_flame_big_mask
	sta	MASKL
	lda	#>left_flame_big_mask
	sta	MASKH

	bne	draw_left_flame_common	; bra

draw_flame_tall_2:

	; draw right flame

	lda	#<right_flame_big
	sta	INL
	lda	#>right_flame_big
	sta	INH
	lda	#<right_flame_big_mask
	sta	MASKL
	lda	#>right_flame_big_mask
	sta	MASKH

draw_left_flame_common:

;	lda	#8
	txa
	sta	SPRITE_X

	lda	#54
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_big_mask

	rts


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

