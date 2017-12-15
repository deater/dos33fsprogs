.include "zp.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	clear_screens		 ; clear top/bottom of page 0/1
	jsr     set_gr_page0

	lda	#<demo_rle
	sta	GBASL
	lda	#>demo_rle
	sta	GBASH

	lda	#<$400
	sta	BASL
	lda	#>$400
	sta	BASH

	jsr	load_rle_gr

loop_forever:
	jmp	loop_forever


;===============================================
; External modules
;===============================================

.include "utils.s"

.include "mode7_demo_backgrounds.inc"
