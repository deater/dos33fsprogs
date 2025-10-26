; Intro
;	+ Comes in with letters fallen on PAGE1(?)
;	+ Title graphic + logo1 MAIN at $A000
;	+ Show title for a bit
;	+ hires-fade to black, clear both DHGR screens
;	+ Decompress logo1 AUX to $A000, then copy
;	+ wait a bit
;	+ decompress logo2 top/bottom through $A000
;	+ call redline wipe
;	+ clear dhgr page2
;	- fade out? fizzle out? redline wipe again?

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"
.include "extra.inc"

	;=============================
	; draw intro
	;=============================

intro:
	bit	KEYRESET	; just to be safe

	;=======================================
	; Comes in with letters fallen in Page1
	;=======================================


	;=======================================
	; Load title to Page1
	;=======================================

	bit	PAGE1

	lda	#$00			; load to $2000
	sta	DRAW_PAGE

	lda	#<title_hgr
	sta	zx_src_l+1
	lda	#>title_hgr
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	jsr	wait_until_keypress

	;=================================
	; clear screen

	jsr	clear_dhgr_screens

	;=================================
	; We are first to run, so init double-hires

	bit	SET_GR
        bit	HIRES
        bit	FULLGR
        sta	AN3		; set double hires
        sta	EIGHTYCOLON	; 80 column
	sta	CLR80COL
;	sta	SET80COL	; (allow page1/2 flip main/aux)

        bit	PAGE1		; display page1


	;=============================
	; load top part to MAIN $A000

	lda	#$80			; load to $a000
	sta	DRAW_PAGE

	lda	#<logo1_top
	sta	zx_src_l+1
	lda	#>logo1_top
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$00			; repack to $2000
	sta	DRAW_PAGE
	lda	#$A0			; repack from $a000

	jsr	dhgr_repack_top


	;=============================
	; load bottom part to MAIN $A000

	lda	#$80			; load to $a000
	sta	DRAW_PAGE

	lda	#<logo1_bottom
	sta	zx_src_l+1
	lda	#>logo1_bottom
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main


	lda	#$00			; repack to $2000
	sta	DRAW_PAGE
	lda	#$A0
	jsr	dhgr_repack_bottom

	;=======================
	; wait a bit

bbtf2:
	lda	KEYPRESS
	bpl	bbtf2
	bit	KEYRESET


;	lda	#1
;	jsr	wait_seconds


	;=============================
	; load top part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<logo2_top
	sta	zx_src_l+1
	lda	#>logo2_top
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$20			; draw to page2
	sta	DRAW_PAGE

	lda	#$A0

	jsr	dhgr_repack_top


	;=============================
	; load bottom part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<logo2_bottom
	sta	zx_src_l+1
	lda	#>logo2_bottom
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$20			; draw to page2
	sta	DRAW_PAGE

	lda	#$A0

	jsr	dhgr_repack_bottom

; TODO: wait a bit?

	;================================
	; do wipe


	jsr	save_zp
	jsr	do_wipe_redlines
	jsr	restore_zp

;	jsr	wait_vblank
;	jsr	hgr_page_flip


	;=======================
	; wait a bit

;	lda	#1
;	jsr	wait_seconds

;	jsr	clear_dhgr_screens



bbtf:
	lda	KEYPRESS
	bpl	bbtf
	bit	KEYRESET


	bit	PAGE1

	rts

	.include "../dhgr_clear.s"
	.include "../dhgr_repack.s"

	.include "fx.dhgr.redlines.s"
	.include "save_zp.s"

logo1_top:
	.incbin "graphics/logo_grafA.raw_top.zx02"
logo1_bottom:
	.incbin "graphics/logo_grafA.raw_bottom.zx02"

logo2_top:
	.incbin "graphics/logo_dSr_D2.raw_top.zx02"
logo2_bottom:
	.incbin "graphics/logo_dSr_D2.raw_bottom.zx02"

;title_hgr:
;	.incbin "graphics/ms_title.hgr.zx02"
