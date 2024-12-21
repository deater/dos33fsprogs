; XMAS 2024

.include "hardware.inc"
.include "zp.inc"
.include "qload.inc"
.include "music.inc"


xmas_main:

	; clear extraneous keypresses

	bit KEYRESET

	;======================================
	; init
	;======================================

	lda	#$00
	jsr	hgr_page1_clearscreen

	bit	SET_GR
	bit	HIRES
	bit	PAGE1

	;======================================
	; draw opening scene
	;======================================

	; start music

	cli

	jsr	wipe_star

	jsr	do_scroll

repeat:

finished:
	jmp	repeat


.include "wait_keypress.s"
.include "irq_wait.s"

.include "wipe_star.s"

.include "horiz_scroll.s"
.include "font/large_font.inc"
.include "hgr_page_flip.s"
.include "vblank.s"

;gp_hat_graphics:
;.incbin "graphics/gp_hgr.zx02"
