.include "zp.inc"

square1_lo	EQU	$1000
square1_hi	EQU	$1200
square2_lo	EQU	$1400
square2_hi	EQU	$1600

scroll_row1	EQU	$1800
scroll_row2	EQU	$1900
scroll_row3	EQU	$1a00
scroll_row4	EQU	$1b00

; matches scroll_row1 - row3
star_x		EQU	$1800
star_y		EQU	$1900
star_z		EQU	$1a00


start:
	;================================
	; include VMW logo line 0
	;================================

	;.byte $AA,$AD,$D5,$AC,$95
	tax		; $aa
	lda	$ACD5	; $ad,$d5,$ac
	sta	$0,X	; $95,$00

	;================================
	; Mockingboard detect
	;================================

	jsr	mockingboard_detect_slot4       ; call detection routine
	stx	MB_DETECTED

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
	jsr	star_credits

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
	jsr	decompress_scroll	; load sky background

	lda	#0			; no draw blue sky
	sta	DRAW_BLUE_SKY


	lda	#$20				; setup self-modifying code
	sta	nomatch				; to use checkerboard map
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

	lda	#<checkerboard_flying_directions
	sta	direction_smc_1+1
	sta	direction_smc_2+1
	lda	#>checkerboard_flying_directions
	sta	direction_smc_1+2
	sta	direction_smc_2+2


	jsr	mode7_flying		; call generic mode7 code

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

	lda	#<island_flying_directions
	sta	direction_smc_1+1
	sta	direction_smc_2+1
	lda	#>island_flying_directions
	sta	direction_smc_1+2
	sta	direction_smc_2+2

	jsr	mode7_flying

	rts


	;===========================
	; Star Demo
	;===========================
star_demo:
	; initialize

	lda	#48
	sta	y_limit_smc+1

	jsr	starfield_demo

	rts


	;===========================
	; Star Credits
	;===========================
star_credits:
	; initialize

	lda	#40
	sta	y_limit_smc+1

	jsr	starfield_credits

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
.include "../asm_routines/gr_fast_clear.s"
.include "../asm_routines/gr_hlin.s"
.include "../asm_routines/gr_setpage.s"
.include "../asm_routines/pageflip.s"
.include "../asm_routines/gr_fade.s"
.include "../asm_routines/gr_copy.s"
.include "../asm_routines/gr_scroll.s"
.include "../asm_routines/gr_offsets.s"
.include "../asm_routines/gr_plot.s"
.include "../asm_routines/text_print.s"
.include "../asm_routines/mockingboard_a.s"

.include "mode7.s"

.include "mode7_demo_backgrounds.inc"


;===============================================
; More routines
;===============================================

.include "deater.scrolltext"
.include "a2.scrolltext"
.include "starfield_demo.s"
.include "rasterbars.s"
.include "credits.s"
