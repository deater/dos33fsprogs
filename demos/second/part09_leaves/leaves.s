; Leaves / New Way to Scroll

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

leaves_start:
	;=====================
	; initializations
	;=====================

; debug
	; force right location in music

	lda	#30
	sta	current_pattern_smc+1
	jsr	pt3_set_pattern



	;===================
	; Load graphics
	;===================

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	bit	PAGE2

	; load image offscreen $6000

	lda	#<leaves_data
	sta	zx_src_l+1
	lda	#>leaves_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp


	lda	#0
	sta	COUNT
	sta	DRAW_PAGE

ship_sprite_loop:

	lda	#$60
	jsr	hgr_copy

	bit	PAGE1

;	jsr	wait_until_keypress

leaves_loop:
	lda	#34
        jsr     wait_for_pattern
        bcc     leaves_loop




leaves_done:
	rts


.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"../hgr_copy_fast.s"

leaves_data:
	.incbin "graphics/final3.hgr.zx02"

	.include "../irq_wait.s"
