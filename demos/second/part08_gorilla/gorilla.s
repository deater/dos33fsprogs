; Gorilla scroll

; o/~ I'm happy, I'm feeling glad ... o/~

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

gorilla_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================

	lda	#0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	; switch to HIRES (previous screen was lores)

	bit	SET_GR
	bit	HIRES
	bit	FULLGR

	bit	PAGE2

	; load image offscreen $6000

	lda	#<gorilla_data
	sta	zx_src_l+1
	lda	#>gorilla_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp


	lda	#0
	sta	COUNT
	sta	DRAW_PAGE

	;=======================
	; scroll in from right
	;=======================

	bit	PAGE1			; draw on visible page
					; flipping while scrolling is hard

	jsr	horiz_scroll_left

;	lda	#$60
;	jsr	hgr_copy

;	bit	PAGE1


	;==============================
	; todo, possibly flash at end?
	;==============================

gorilla_wait:
	lda	#29
	jsr	wait_for_pattern
	bcc	gorilla_wait

	;======================
	; TV_shutoff effect
	;======================

;	lda	#0
;	jsr	hgr_page1_clearscreen

	jsr	tv_effect


	;============================
	; decompress sound for later
	;============================

	; decompress audio to $D000

	lda	#<transmission_data
	sta	zx_src_l+1
	lda	#>transmission_data
	sta	zx_src_h+1

	sei				; disable interrupts
	jsr	mute_ay_both

	; swap in language card Page1

	lda	$C08B
	lda	$C08B

	lda	#$D0
	jsr	zx02_full_decomp

	; swap back language card Page2

	lda	$C083
	lda	$C083

	jsr	unmute_ay_both
	cli				; re-enable interrupts

gorilla_wait2:
	lda	#30
	jsr	wait_for_pattern
	bcc	gorilla_wait2



gorilla_done:
	rts


;.align $100
	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"../hgr_copy_fast.s"
	.include	"../hgr_page_flip.s"

	.include	"tv_effect.s"
	.include	"../irq_wait.s"
	.include	"horiz_scroll_simple.s"

gorilla_data:
	.incbin "graphics/mntscrl3.hgr.zx02"

transmission_data:
	.incbin "audio/a_pboy.btc.zx02"
