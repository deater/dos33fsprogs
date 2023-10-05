; Intro

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

intro_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================
load_loop:

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#<fc_sr_logo_data
	sta	zx_src_l+1

	lda	#>fc_sr_logo_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress


.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"

fc_sr_logo_data:
	.incbin "graphics/fc_sr_logo.hgr.zx02"

