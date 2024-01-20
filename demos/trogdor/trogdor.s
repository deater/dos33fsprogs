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

	jsr	horiz_pan

	; clear to white
	ldy	#$7f
	jsr	hgr_clear_screen

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

	jsr	wait_until_keypress

	; second

	lda	#<trog03_graphics
	sta	zx_src_l+1
	lda	#>trog03_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp



finished:
	jmp	finished



	; start music

;	lda	SOUND_STATUS
;	and	#SOUND_MOCKINGBOARD
;	beq	no_music
;	cli	; enable sound
;no_music:


               ;0123456789012345678901234567890123456789
;merry_text:
;	.byte   "      MERRY CHRISTMAS!!! MERRY CHRISTMAS!!! ME"







trog00_graphics:
.incbin "graphics/actual00_trog_cottage.hgr.zx02"

trog03_graphics:
.incbin "graphics/trog03_man.hgr.zx02"

.include "wait_keypress.s"
.include "irq_wait.s"


hposn_low       = $1e00
hposn_high      = $1f00

.include "hgr_sprite_big_mask.s"
.include "horiz_scroll_simple.s"
.include "hgr_copy_magnify.s"

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

