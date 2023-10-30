; Intro

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

mod7_table      = $1c00
div7_table      = $1d00
hposn_low       = $1e00
hposn_high      = $1f00

intro_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen


	; demosplash

	lda	#<demosplash_data
	sta	zx_src_l+1

	lda	#>demosplash_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress


	; mockingboard

	lda	#<mockingboard_data
	sta	zx_src_l+1

	lda	#>mockingboard_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress


	;======================================
	;======================================
	; Pan
	;======================================
	;======================================
	; do we have room to do page flipping?


	;===========================================
	; load left logo to $2000 and right to $4000

	; left logo

	lda	#<intro_left_data
	sta	zx_src_l+1

	lda	#>intro_left_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; right logo

	lda	#<intro_right_data
	sta	zx_src_l+1

	lda	#>intro_right_data
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	;============================
	; do the pan

pan_loop:

	lda	#0
	sta	COUNT

pan_outer_outer_loop:

	ldx	#191
pan_outer_loop:

	lda	hposn_high,X
	sta	pil_smc1+2
	sta	pil_smc2+2
	sta	pil_smc4+2
	eor	#$60
	sta	pil_smc3+2

	lda	hposn_low,X
	sta	pil_smc2+1
	sta	pil_smc4+1

	sta	pil_smc1+1
	inc	pil_smc1+1
	clc
	adc	COUNT
	sta	pil_smc3+1


	ldy	#0
pan_inner_loop:

pil_smc1:
	lda	$2000+1,Y
pil_smc2:
	sta	$2000,Y

	iny
	cpy	#39
	bne	pan_inner_loop

pil_smc3:
	lda	$4000
pil_smc4:
	sta	$2000,Y

	dex
	cpx	#$ff
	bne	pan_outer_loop

;	jsr	wait_until_keypress

	inc	COUNT
	lda	COUNT
	cmp	#39

	bne	pan_outer_outer_loop

	jsr	wait_until_keypress

	;============================
	; draw sprites
	;============================

	; TODO

	;============================
	; draw explosion
	;============================

	; TODO


	;============================
	; draw fc logo
	;============================

	lda	#<fc_sr_logo_data
	sta	zx_src_l+1

	lda	#>fc_sr_logo_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress

done_intro:
	rts

.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"

demosplash_data:
	.incbin "graphics/demosplash.hgr.zx02"
mockingboard_data:
	.incbin "graphics/mockingboard.hgr.zx02"

intro_left_data:
	.incbin "graphics/igl.hgr.zx02"
intro_right_data:
	.incbin "graphics/igr.hgr.zx02"
fc_sr_logo_data:
	.incbin "graphics/fc_sr_logo.hgr.zx02"

