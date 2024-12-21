; XMAS 2024

.include "hardware.inc"
.include "zp.inc"
.include "qload.inc"
.include "music.inc"


xmas_main:

	;======================================
	; init
	;======================================

	lda	#$00
	sta	DRAW_PAGE
	sta	clear_all_color+1

	lda	#$04
	sta	DRAW_PAGE
	jsr	clear_all

	;======================================
	; draw opening scene
	;======================================

	bit	SET_GR
	bit	HIRES
	bit	PAGE1

	lda	#<gp_hat_graphics
	sta	zx_src_l+1
	lda	#>gp_hat_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	cli

	jsr	wipe_star

repeat:

finished:
	jmp	repeat


.include "wait_keypress.s"
.include "irq_wait.s"

.include "wipe_star.s"

gp_hat_graphics:
.incbin "graphics/gp_hgr.zx02"
