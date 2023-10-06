; Intro

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

hposn_low       = $1713 ; 0xC0 bytes (lifetime, used by DrawLargeCharacter)
hposn_high      = $1800 ; 0xC0 bytes (lifetime, used by DrawLargeCharacter)

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

	lda	#0
	jsr	hgr_page1_clearscreen

	jsr	build_tables


; for pan
; code at $6000
;	left page for $2000 at top, we can overwrite
;	right page at $a000
; uncompress to $2000 at first
;	then algorithm alternating pages


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
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"

intro_left_data:
	.incbin "graphics/igl.hgr.zx02"
intro_right_data:
	.incbin "graphics/igr.hgr.zx02"
fc_sr_logo_data:
	.incbin "graphics/fc_sr_logo.hgr.zx02"

