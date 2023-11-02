; Transmission

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

spheres_start:
	;=====================
	; initializations
	;=====================

	; decompress audio to $6000

	lda	#<transmission_data
	sta	zx_src_l+1
	lda	#>transmission_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	; play audio

	lda	#$00
	sta	BTC_L
	lda	#$60
	sta	BTC_H

	sei			; stop music

	ldx	#11
	jsr	play_audio

	cli

	;===================
	; Load graphics
	;===================

	bit	SET_GR
	bit	FULLGR
	bit	PAGE1
	bit	LORES

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	;===================================
	; Clear top/bottom of page 0 and 1
	;===================================

	jsr	clear_screens

	; load image offscreen $4000

	lda	#<spheres_data
	sta	zx_src_l+1
	lda	#>spheres_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	;=================================
        ; copy to both pages

        jsr     gr_copy_to_current
        jsr     page_flip
        jsr     gr_copy_to_current



;	lda	#0
;	sta	COUNT
;	sta	DRAW_PAGE


spheres_loop:
	lda	#72
	jsr	wait_for_pattern
	bcc	spheres_loop

spheres_done:
	rts


	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
;	.include	"../hgr_clear_screen.s"
;	.include	"../hgr_copy_fast.s"

	.include	"../gr_pageflip.s"
	.include	"../gr_copy.s"

	.include	"../gr_offsets.s"

	.include	"../audio.s"
	.include	"../irq_wait.s"

spheres_data:
;	.incbin "graphics/spheres.hgr.zx02"
	.incbin "graphics/spheres.gr.zx02"

transmission_data:
	.incbin "audio/transmission.btc.zx02"
