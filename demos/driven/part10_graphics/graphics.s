.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"



	;=============================
	; draw some graphics
	;=============================

graphics:
	lda	#0

	bit     SET_GR
        bit     HIRES
        bit     FULLGR
        bit     PAGE1

	;=================================
	; intro
	;=================================

	lda	#<floater_graphics
	sta	zx_src_l+1
	lda	#>floater_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	rts

floater_graphics:
	.incbin "graphics/floater_wide_steffest.hgr.zx02"

.include "../wait_keypress.s"
