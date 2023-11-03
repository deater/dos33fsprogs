; Intro

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

mod7_table      = $1c00
div7_table      = $1d00
hposn_low       = $1e00
hposn_high      = $1f00

intro_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen

	;=========================
	; wait 15s doing nothing
	;=========================

	lda	#15
	jsr	wait_seconds

	; pre-load vmw message

	lda	#<vmw_data
	sta	zx_src_l+1
	lda	#>vmw_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	;========================
	; vmw message for 5s
	;========================

	bit	PAGE2
	lda	#5
	jsr	wait_seconds

	; switch back, wait 2 seconds

	bit	PAGE1
	lda	#2
	jsr	wait_seconds

	; preload demosplash message

	lda	#<demosplash_data
	sta	zx_src_l+1
	lda	#>demosplash_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	;===================
	; demosplash for 5s
	;===================

	bit	PAGE2
	lda	#5
	jsr	wait_seconds

	; switch back, wait 2 seconds

	bit	PAGE1
	lda	#2
	jsr	wait_seconds

	; pre-load mockingboard

	lda	#<mockingboard_data
	sta	zx_src_l+1
	lda	#>mockingboard_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	;=======================
	; mockingboard for 5s
	;=======================

	bit	PAGE2
	lda	#5
	jsr	wait_seconds

	bit	PAGE1

	;======================================
	;======================================
	; Pan
	;======================================
	;======================================
	; do we have room to do page flipping?


	;===========================================
	; load left logo to $2000 and right to $4000

	; left logo

	lda	#<intro_left_data
	sta	zx_src_l+1

	lda	#>intro_left_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; right logo

	lda	#<intro_right_data
	sta	zx_src_l+1
	lda	#>intro_right_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	;==============================
	; do the pan
	;==============================

	jsr	horiz_pan

	; wait a bit

	lda	#5
	jsr	wait_seconds


	;============================
	; load sprites at $6000
	;============================

	lda	#<sprite_data
	sta	zx_src_l+1
	lda	#>sprite_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp


	;============================
	; draw sprites
	;============================

	; currently we're viewing PAGE1
	lda	#$20
	sta	DRAW_PAGE	; draw PAGE2


	ldx     #0
        stx     BOARD_COUNT

draw_sprites_loop:

	; right logo

	lda	#<intro_right_data
	sta	zx_src_l+1
	lda	#>intro_right_data
	sta	zx_src_h+1
	lda	#$20
	clc
	adc	DRAW_PAGE
	jsr	zx02_full_decomp

        ldx     BOARD_COUNT
        lda     board_desty,X
        sta     HGR_DEST

        lda     board_y_start,X
        sta     HGR_Y1

        lda     #0
        sta     HGR_X1
        lda     #40
        sta     HGR_X2
        lda     board_y_end,X
        sta     HGR_Y2

        jsr     hgr_partial

	bit	PAGE2

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	lda	#10
	jsr	wait_ticks

	inc	BOARD_COUNT
	lda	BOARD_COUNT
	cmp	#4
	bne	draw_sprites_loop


	; wait a bit

	lda	#5
	jsr	wait_seconds


	;============================
	; draw explosion
	;============================

	; TODO

	lda	#1
	jsr	wait_seconds

	lda	#$FF
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	lda	#1
	jsr	wait_seconds

	;============================
	; draw fc logo
	;============================

	lda	#<fc_sr_logo_data
	sta	zx_src_l+1
	lda	#>fc_sr_logo_data
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	; return, handle waiting on other side

done_intro:
	rts

;.align $100
	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"horiz_scroll.s"
	.include	"hgr_partial.s"
	.include	"../hgr_page_flip.s"

	.include	"../irq_wait.s"

demosplash_data:
	.incbin "graphics/demosplash.hgr.zx02"
mockingboard_data:
	.incbin "graphics/mockingboard.hgr.zx02"

intro_left_data:
	.incbin "graphics/igl.hgr.zx02"
intro_right_data:
	.incbin "graphics/igr.hgr.zx02"
fc_sr_logo_data:
	.incbin "graphics/fc_sr_logo.hgr.zx02"
vmw_data:
	.incbin "graphics/vmw.hgr.zx02"
sprite_data:
	.incbin "graphics/ship_sprites.hgr.zx02"

board_desty:
	.byte	17,17,71,33
board_y_start:
	.byte	0,38,93,110
board_y_end:
	.byte	36,92,108,176
