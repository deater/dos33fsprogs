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

	; left logo

	lda	#<intro_left_data
	sta	zx_src_l+1

	lda	#>intro_left_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress


	; right logo

	lda	#<intro_right_data
	sta	zx_src_l+1

	lda	#>intro_right_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress




	; fc logo

	lda	#<fc_sr_logo_data
	sta	zx_src_l+1

	lda	#>fc_sr_logo_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress

blah:
	jmp	blah

.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"

intro_left_data:
	.incbin "graphics/igl.hgr.zx02"
intro_right_data:
	.incbin "graphics/igr.hgr.zx02"
fc_sr_logo_data:
	.incbin "graphics/fc_sr_logo.hgr.zx02"

