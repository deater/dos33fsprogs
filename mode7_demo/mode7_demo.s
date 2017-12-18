.include "zp.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr     set_gr_page0
	bit	FULLGR
	jsr	clear_screens_notext	 ; clear top/bottom of page 0/1

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

	;==========
	; Fade in
	;==========

	jsr	fade_in

	;==========================================
	; Make sure page0 and page1 show same image
	;==========================================

	jsr	gr_copy_to_current

	;===================
	; Scroll the message
	;===================

;	lda	#255
;	jsr	WAIT


	lda	#>deater_scroll
	sta	INH
	lda	#<deater_scroll
	sta	INL

;	lda	#10
	lda	#40
	sta	CV


	jsr	gr_scroll

	;=============
	; Fade out
	;=============
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
.include "../asm_routines/gr_copy.s"
.include "../asm_routines/gr_scroll.s"

.include "mode7_demo_backgrounds.inc"


;===============================================
; Variables
;===============================================

.include "scrolltext.inc"


