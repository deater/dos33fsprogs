.include "zp.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	clear_screens		 ; clear top/bottom of page 0/1
	jsr     set_gr_page0

	lda	#$4
	sta	DRAW_PAGE

	lda	#<demo_rle
	sta	GBASL
	lda	#>demo_rle
	sta	GBASH

	; Load offscreen
	lda	#<$c00
	sta	BASL
	lda	#>$c00
	sta	BASH

	jsr	load_rle_gr

demo_loop:

	jsr	fade_in

	lda	#255
	jsr	WAIT

	jsr	fade_out


	jmp	demo_loop


;===============================================
; External modules
;===============================================

.include "../asm_routines/gr_unrle.s"
.include "../asm_routines/hlin_clearscreen.s"
.include "../asm_routines/gr_setpage.s"
.include "../asm_routines/pageflip.s"
.include "../asm_routines/gr_fade.s"

.include "mode7_demo_backgrounds.inc"
