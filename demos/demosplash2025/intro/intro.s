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
	; Comes in with letters fallen in PAGE1
	;=======================================


	;=======================================
	;=======================================
	; Load TITLE SCREEN to PAGE1
	;=======================================
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


	;======================================
	; load LOGO1 MAIN part to MAIN $2000

	lda	#$00			; load to $2000
	sta	DRAW_PAGE

	lda	#<logo1_main
	sta	zx_src_l+1
	lda	#>logo1_main
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	;===========================================================
	; load LOGO1 AUX part to  MAIN $A000 then copy to AUX $2000

	lda	#$80			; load to $a000
	sta	DRAW_PAGE

	lda	#<logo1_aux
	sta	zx_src_l+1
	lda	#>logo1_aux
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$20			; A = AUX page start (dest)
	ldy	#$A0			; Y = MAIN page start (src)
	ldx	#$20			; X = num pages

	jsr	copy_main_aux

	;=======================
	;=======================
	; wait a bit
	;=======================
	;=======================

	jsr	wait_until_keypress


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

	jsr	wait_until_keypress

	;=======================================
	;=======================================
	; Load HOUSE to PAGE1
	;=======================================
	;=======================================

	; disable DHGR mode
	sta	SETAN3
	sta	CLR80COL
	sta	EIGHTYCOLOFF
	bit	PAGE1

	lda	#$00			; load to $2000
	sta	DRAW_PAGE

	lda	#<house_hgr
	sta	zx_src_l+1
	lda	#>house_hgr
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	bit	PAGE1

	jsr	wait_until_keypress

	rts

	.include "../dhgr_clear.s"
	.include "../dhgr_repack.s"

	.include "fx.dhgr.redlines.s"
	.include "save_zp.s"

;logo1_top:
;	.incbin "graphics/logo_grafA.raw_top.zx02"
;logo1_bottom:
;	.incbin "graphics/logo_grafA.raw_bottom.zx02"

; logo1_main is in EXTRA
;	this isn't as compact but we save some room still
;	because half of it is up in $a000

logo1_aux:
	.incbin "graphics/logo_grafA.aux.zx02"


logo2_top:
	.incbin "graphics/logo_dSr_D2.raw_top.zx02"
logo2_bottom:
	.incbin "graphics/logo_dSr_D2.raw_bottom.zx02"

;title_hgr:
;	.incbin "graphics/ms_title.hgr.zx02"

house_hgr:
	.incbin "graphics/pa_house_bottom.hgr.zx02"
