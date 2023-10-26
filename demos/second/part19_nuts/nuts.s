; Nuts

; also end sprites to 3d

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

mod7_table	= $1c00
div7_table	= $1d00
hposn_low	= $1e00
hposn_high	= $1f00

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

	jsr	hgr_make_tables


	; fc logo

	lda	#<fc_iipix_data
	sta	zx_src_l+1
	lda	#>fc_iipix_data
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp
	jsr	wait_until_keypress


	; nuts4 logo

	lda	#<nuts4_data
	sta	zx_src_l+1
	lda	#>nuts4_data
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp
	jsr	wait_until_keypress

nuts_done:
	jmp	nuts_done


.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"


fc_iipix_data:
	.incbin "graphics/fc_iipix.hgr.zx02"

nuts4_data:
	.incbin "graphics/nuts4.hgr.zx02"
