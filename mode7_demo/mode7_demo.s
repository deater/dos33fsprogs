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
	; Need to have lines at
	;	$4000	AA,AD,D5,AC,95
	;	$4400	A8,55,95,35,85
	;	$4800	A0,55,26,55,81
	;	$4C00	00,00,00,00,00


	;.byte $AA,$AD,$D5,$AC,$95
	tax		; $aa
	lda	$ACD5	; $ad,$d5,$ac
	sta	$0,X	; $95,$00

	;================================
	; one-time setup
	;================================
	; Initialize the 2kB of multiply lookup tables
	jsr	init_multiply_tables

	;================================
	; Mockingboard detect
	;================================

	jsr	mockingboard_detect_slot4       ; call detection routine
	stx	MB_DETECTED

	;================================
	; Mockingboard start
	;================================

mockingboard_setup:
	sei			; disable interrupts just in case

	jsr	mockingboard_init
	jsr	reset_ay_both
	jsr	clear_ay_both

	;=========================
	; Setup Interrupt Handler
	;=========================
	; Vector address goes to 0x3fe/0x3ff
	; FIXME: should chain any existing handler

	lda	#<interrupt_handler
	sta	$03fe
	lda	#>interrupt_handler
	sta	$03ff

	;============================
	; Enable 50Hz clock on 6522
	;============================

	lda	#$40		; Continuous interrupts, don't touch PB7
	sta	$C40B		; ACR register
	lda	#$7F		; clear all interrupt flags
	sta	$C40E		; IER register (interrupt enable)

	lda	#$C0
	sta	$C40D		; IFR: 1100, enable interrupt on timer one oflow
	sta	$C40E		; IER: 1100, enable timer one interrupt

	lda	#$40
	sta	$C404		; write into low-order latch
	lda	#$9c
	sta	$C405		; write into high-order latch,
				; load both values into counter
				; clear interrupt and start counting

	; 4fe7 / 1e6 = .020s, 50Hz
	; 9c40 / 1e6 = .040s, 25Hz

	;============================
	; Start Playing
	;============================
main_loop:
	lda	MB_DETECTED
	beq	mockingboard_setup_done

	lda	#0
	sta	DONE_PLAYING
	sta	WHICH_CHUNK
	sta	MB_CHUNK_OFFSET
	sta	MB_ADDRL		; we are aligned, so should be 0

	lda	#>music_start
	sta	MB_ADDRH

	;=====================================
	; clear register area
	;=====================================
	ldx	#13							; 2
	lda	#0							; 2
mb_setup_clear_reg:
	sta	REGISTER_DUMP,X	; clear register value			; 4
	sta	REGISTER_OLD,X	; clear old values			; 4
	dex								; 2
	bpl	mb_setup_clear_reg					; 2nt/3

	cli			; start interrupts

mockingboard_setup_done:

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	set_gr_page0

	lda	#$4
	sta	DRAW_PAGE

	;================================
	; Main Loop
	;================================

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


	jmp	mode7_flying		; call generic mode7 code

;	rts				; tail call


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

	jmp	mode7_flying

;	rts				; tail call


	;===========================
	; Star Demo
	;===========================
star_demo:
	; initialize

	lda	#48
	sta	y_limit_smc+1

	jsr	starfield_demo		; tail call

	rts


	;===========================
	; Star Credits
	;===========================
star_credits:
	; initialize

	lda	#40
	sta	y_limit_smc+1

	jsr	starfield_credits	; tail call

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

;============================
; These are placed so the VMW logo can be fit
;============================
.include "deater.scrolltext"
.include "a2.scrolltext"
.byte 0,0,0,0,0,0,0,0
.byte 0,0,0,0,0,0,0,0
.byte $A8,$55,$95,$35,$85		; at $4400

.include "mockingboard.s"
.include "credits.s"
.include "interrupt_handler.s"
.byte 0,0,0,0,0,0,0,0
.byte 0,0,0,0,0,0,0,0
.byte 0,0,0,0,0,0,0,0
.byte 0,0,0,0
.byte $A0,$55,$26,$55,$81		; at $4800

.include "pageflip.s"
.include "rasterbars.s"
.include "starfield_demo.s"
.include "gr_unrle.s"
.include "gr_offsets.s"
.include "gr_setpage.s"
.byte 0,0,0,0,0,0,0,0
.byte 0,0,0,0,0,0,0,0
.byte 0,0,0,0,0,0,0,0			; at $4c00

;===============================================
; External modules
;===============================================


.include "gr_fast_clear.s"
.include "gr_hlin_double.s"
.include "text_print.s"
.include "gr_fade.s"
.include "gr_plot.s"
.include "gr_copy.s"
.include "gr_scroll.s"


.include "mode7.s"

.include "mode7_demo_backgrounds.inc"

;===============================================
; More routines
;===============================================

.align 256

music_start:
.incbin "wave.krg"
