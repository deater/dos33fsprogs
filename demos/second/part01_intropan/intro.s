; Intro

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

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

	jsr	wait_until_keypress

	;==============================
	; do the pan
	;==============================

	jsr	horiz_pan



	jsr	wait_until_keypress

	;============================
	; draw sprites
	;============================

	; TODO

	;============================
	; draw explosion
	;============================

	; TODO


	;============================
	; draw fc logo
	;============================

	lda	#<fc_sr_logo_data
	sta	zx_src_l+1

	lda	#>fc_sr_logo_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress

done_intro:
	rts

;.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"horiz_scroll.s"

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
