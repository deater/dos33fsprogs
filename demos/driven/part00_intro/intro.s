; Round Desire Logo

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

desire_start:
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
	bit	PAGE1

;	lda	#0
;	jsr	hgr_page1_clearscreen
;	jsr	hgr_page2_clearscreen

;	bit	PAGE2			; look at page2


	; load image $2000

	lda	#<polar_data
	sta	zx_src_l+1
	lda	#>polar_data
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp


polar_loop:
	lda	#8
	jsr	wait_seconds


polar_done:
	rts


;	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
;	.include	"../hgr_clear_screen.s"
;	.include	"../hgr_copy_fast.s"
	.include	"../irq_wait.s"
;	.include	"../hgr_page_flip.s"


polar_data:
	.incbin "graphics/desire.hgr.zx02"

