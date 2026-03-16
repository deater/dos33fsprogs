.include "zp.inc"
.include "../hardware.inc"
.include "qload.inc"
.include "common_defines.inc"

	;=======================================
	; load backgrounds from animation
	;=======================================

load_bg:

	bit	KEYRESET	; just to be safe

	;=================================
	; init vars
	;=================================


	;===================================
	; decompress first graphic to page1

	lda	#$0
	sta	DRAW_PAGE

	lda	#<bg1_graphic
	sta	zx_src_l+1
	lda	#>bg1_graphic
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp


	;====================================
	; decompress second graphics to page2

	lda	#<bg2_graphic
	sta	zx_src_l+1
	lda	#>bg2_graphic
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

	rts

bg1_graphic:
	.incbin "graphics/a2_doodle001.hgr.zx02"

bg2_graphic:
	.incbin "graphics/a2_doodle008.hgr.zx02"
