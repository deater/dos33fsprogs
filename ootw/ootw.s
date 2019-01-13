	; Ootw

.include "zp.inc"
.include "hardware.inc"



title_screen:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR



	;===========================
	; Clear both bottoms

	lda	#$4
	sta	DRAW_PAGE
	jsr     clear_bottom

	lda	#$0
	sta	DRAW_PAGE
	jsr     clear_bottom

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE


	;=============================
	; Load title_rle

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen 0xc00

	lda     #>(planet_rle)
        sta     GBASH
	lda     #<(planet_rle)
        sta     GBASL
	jsr	load_rle_gr

	;=================================
	; copy to both pages

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	lda	#20
	sta	YPOS
	lda	#20
	sta	XPOS

	;=================================
	; wait for keypress

forever:
	jsr	wait_until_keypress

;	jsr	TEXT

	jsr	page_flip

	jmp	forever

.include "wait_keypress.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "ootw_backgrounds.inc"
