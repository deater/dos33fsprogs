.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=============================
	; Do Woz Nine Animation
	;=============================

monsters:
	bit	KEYRESET	; just to be safe

	;=================================
	; Scrolling Intro Logo
	;=================================

	;=================================
	; init graphics
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
	lda	#$20
	sta	DRAW_PAGE	; draw to page2

.if 0
	;=============================
	; load top part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<woz_top
	sta	zx_src_l+1
	lda	#>woz_top
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$20			; draw to page 2
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_top

	;=============================
	; load bottom part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<woz_bottom
	sta	zx_src_l+1
	lda	#>woz_bottom
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$20			; draw to page 2
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_bottom

	;=======================
	; make visible

	jsr	hgr_page_flip
.endif


	jsr	woz_nine

	;============================
	; wait a bit

	lda	#5
	jsr	wait_seconds


	;==============================
	;==============================
	; run fake hgr8
	;==============================
	;==============================

	lda	#$0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	jsr	fake_hgr8

	;==============================
	;==============================
	; run martymation
	;==============================
	;==============================

	jsr	asteroid_martymation

	bit	PAGE1

	lda	#0
	jsr	hgr_page2_clearscreen

	jsr	do_wipe_fizzle

	rts


.include "martymation.s"
.include "fx.hgr.fizzle.s"
.include "fake_hgr8.s"
.include "nine.s"
