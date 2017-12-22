.include "zp.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr     set_gr_page0

	lda	#$4
	sta	DRAW_PAGE

	; Initialize the 2kB of multiply lookup tables
	jsr	init_multiply_tables

	;================================
	; Main Loop
	;================================

main_loop:
	jsr	title_routine

	jsr	checkerboard_demo
	jsr	island_demo
	jsr	star_demo

	jmp	main_loop


	;===========================
	; Checkerboard Demo
	;===========================
checkerboard_demo:
	; initialize
	lda	#>sky_background
	sta	INH
	lda	#<sky_background
	sta	INL
	jsr	decompress_scroll

	lda	#0
	sta	DRAW_BLUE_SKY


	lda	#$20
	sta	nomatch
	lda	#<lookup_checkerboard_map
	sta	nomatch+1
	lda	#>lookup_checkerboard_map
	sta	nomatch+2
	lda	#$4c
	sta	nomatch+3
	lda	#<match
	sta	nomatch+4
	lda	#>match
	sta	nomatch+5

	jsr	mode7_flying

	rts


	;===========================
	; Island Demo
	;===========================
island_demo:
	; initialize

	lda	#1
	sta	DRAW_BLUE_SKY

	lda	#$A5			; fix the code that was self-modified
	sta	nomatch			; away in checkerboard code
	lda	#$6A
	sta	nomatch+1
	lda	#$8D
	sta	nomatch+2
	lda	#<(spacex_label+1)
	sta	nomatch+3
	lda	#>(spacex_label+1)
	sta	nomatch+4
	lda	#$29
	sta	nomatch+5

	jsr	mode7_flying

	rts


	;===========================
	; Star Demo
	;===========================
star_demo:
	; initialize


	rts


	;===========================
	; Title routine
	;===========================

title_routine:
	bit	FULLGR
	jsr	clear_screens_notext	 ; clear top/bottom of page 0/1

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

	; Scroll "BY DEATER... A VMW PRODUCTION"

	lda	#>deater_scroll
	sta	INH
	lda	#<deater_scroll
	sta	INL

	lda	#40		; scroll at bottom of screen
	sta	CV

	jsr	gr_scroll

	; Scroll "* APPLE ][ FOREVER *"

	lda	#>a2_scroll
	sta	INH
	lda	#<a2_scroll
	sta	INL

	jsr	gr_scroll

	;=============
	; Fade out
	;=============
	jsr	fade_out

	rts


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

.include "mode7.s"

.include "mode7_demo_backgrounds.inc"


;===============================================
; Variables
;===============================================

.include "deater.scrolltext"
.include "a2.scrolltext"


