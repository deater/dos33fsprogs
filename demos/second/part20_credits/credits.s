; Credits

; o/~ It's the credits, yeah, that's the best part
;     When the movie ends and the reading starts o/~

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

	;=====================
	;=====================
	; do thumbnail credits
	;=====================
	;=====================

	jsr	thumbnail_credits

	;=======================
	;=======================
	; scroll job
	;=======================
	;=======================

	ldx	#0
	stx	FRAME

do_scroll:

	lda	FRAME
	and	#$7
	bne	no_update_message

	; clear lines
	ldx	#200
cl_outer_loop:
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	sta	OUTH
	ldy	#39
	lda	#0
cl_inner_loop:
	sta	(OUTL),Y
	dey
	bpl	cl_inner_loop
	dex
	cpx	#191
	bne	cl_outer_loop


	; print message

        lda     #12
        sta     CH
        lda     #192
        sta     CV

        lda     #<apple_message
        ldy     #>apple_message

	jsr	draw_condensed_1x8

no_update_message:

	inc	FRAME

	jsr	hgr_vertical_scroll

	jmp	do_scroll

.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"vertical_scroll.s"

	.include	"font_4am_1x8.s"
	.include	"fonts/font_4am_1x8_data.s"

	.include	"font_4am_1x10.s"
	.include	"fonts/font_4am_1x10_data.s"

	.include	"thumbnail_credits.s"


summary1_data:
	.incbin "graphics/summary1_invert.hgr.zx02"
summary2_data:
	.incbin "graphics/summary2_invert.hgr.zx02"


apple_message:
	.byte "Apple ][ Forever",0
