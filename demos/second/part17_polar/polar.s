; Polar Bear

; do the animated bounce if possible

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

mod7_table	= $1c00
div7_table	= $1d00
hposn_low	= $1e00
hposn_high	= $1f00

polar_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================
load_loop:

	; already in hires when we come in?

	bit	KEYRESET

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
;	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	bit	PAGE2			; look at page2


	; load image offscreen $6000

	lda	#<polar_data
	sta	zx_src_l+1
	lda	#>polar_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp


	; TODO
	;	scroll in and bounce

polar_scroll_loop:


	lda	#0
	sta	COUNT
	sta	DRAW_PAGE		; draw to PAGE1

	lda	#$60
	jsr	hgr_copy

	bit	PAGE1			; look at PAGE1



polar_loop:
	lda	#5
	jsr	wait_seconds

;	lda	#76
;	jsr	wait_for_pattern
;	bcc	polar_loop

polar_done:
	rts


	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../hgr_clear_screen.s"
	.include	"../hgr_copy_fast.s"
	.include	"../irq_wait.s"



polar_data:
	.incbin "graphics/polar2.hgr.zx02"

