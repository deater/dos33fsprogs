; Polar Bear

; do the animated bounce if possible

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

polar_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================
load_loop:

	; already in hires when we come in?

	bit	KEYRESET

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
;	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	bit	PAGE2			; look at page2


	; load image offscreen $6000

	lda	#<polar_data
	sta	zx_src_l+1
	lda	#>polar_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	;===============================
	;===============================
	;===============================
	; TODO
	;	scroll in and bounce
	;===============================
	;===============================



	lda	#0
	sta	DRAW_PAGE		; draw to PAGE1

	lda	#188
	sta	SCROLL_START

polar_outer_loop:

	lda	SCROLL_START
	sta	COUNT

	lda	#0
	sta	YDEST

polar_scroll_loop:

	; setup source
	ldx	COUNT
	lda	hposn_low,X
	sta	polar_load_smc+1
	lda	hposn_high,X
	clc
	adc	#$40			; load from $6000
	sta	polar_load_smc+2

	; setup destination
	ldx	YDEST
	lda	hposn_low,X
	sta	polar_store_smc+1
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE		; store to $2000/$4000
	sta	polar_store_smc+2

	ldy	#39
polar_scroll_inner:

polar_load_smc:
	lda	$6000,Y
polar_store_smc:
	sta	$2000,Y
	dey
	bne	polar_scroll_inner

	inc	YDEST
	inc	COUNT
	lda	COUNT
	cmp	#192
	bne	polar_scroll_loop

	; flip pages

	jsr	hgr_page_flip

	lda	SCROLL_START
	beq	done_polar_scroll

	sec
	sbc	#4
	sta	SCROLL_START
	jmp	polar_outer_loop

done_polar_scroll:


polar_loop:
	lda	#5
	jsr	wait_seconds

;	lda	#76
;	jsr	wait_for_pattern
;	bcc	polar_loop

polar_done:
	rts


	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
	.include	"../hgr_clear_screen.s"
	.include	"../hgr_copy_fast.s"
	.include	"../irq_wait.s"
	.include	"../hgr_page_flip.s"


polar_data:
	.incbin "graphics/polar2.hgr.zx02"

