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


	;============================
	;============================
	; run the woz/hat part
	;============================
	;============================

	jsr	woz_nine


	;==============================
	;==============================
	; run fake hgr8
	;==============================
	;==============================

	lda	#$0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen


	; drop back to hi-res mode

	; disable DHGR mode
	sta	SETAN3
	sta	CLR80COL
	sta	EIGHTYCOLOFF
	bit	PAGE1

	; run the effect

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
