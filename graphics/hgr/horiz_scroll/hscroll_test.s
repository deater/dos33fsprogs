; Test horizontal scroll

;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

mod7_table      = $1c00
div7_table      = $1d00
hposn_low       = $1e00
hposn_high      = $1f00

hscroll_test:
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

	jsr	hgr_make_tables

	lda	#0
	jsr	hgr_page1_clearscreen

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

	jsr	do_horiz_scroll

	; wait a bit

	jsr	wait_until_keypress



done_intro:
	jmp	done_intro


	.include	"wait_keypress.s"
	.include	"zx02_optim.s"
	.include	"hgr_table.s"
	.include	"hgr_clear_screen.s"
	.include	"horiz_scroll.s"
	.include	"hgr_partial.s"
;	.include	"../hgr_page_flip.s"


intro_left_data:
	.incbin "graphics/pq2_bgl.hgr.zx02"
intro_right_data:
	.incbin "graphics/pq2_bgr.hgr.zx02"

