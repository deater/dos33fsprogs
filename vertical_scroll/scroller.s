; Vertical scroll lo-res

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	; GR part
	bit	PAGE1
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	lda	#4
	sta	DISP_PAGE

	;=============================
	; Load desire 1st

	lda	#<desire_rle
	sta	GBASL
	lda	#>desire_rle
	sta	GBASH
	lda	#$c
	jsr	load_rle_gr

	jsr	gr_copy_to_current	; copy to page1

	jsr	page_flip

	jsr	wait_until_keypress


	;=============================
	; Load desire 2nd

	lda	#<desire2_rle
	sta	GBASL
	lda	#>desire2_rle
	sta	GBASH
	lda	#$c
	jsr	load_rle_gr

	jsr	gr_copy_to_current	; copy to page1

	jsr	page_flip

	jsr	wait_until_keypress

	;=============================
	; Load spaceman

	lda	#<spaceman_rle
	sta	GBASL
	lda	#>spaceman_rle
	sta	GBASH
	lda	#$a0
	jsr	load_rle_large

	jsr	gr_copy_to_current_large	; copy to page1

	jsr	page_flip

	jsr	wait_until_keypress





forever:
	jmp	forever


wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress
	bit	KEYRESET
	rts






	.include "gr_unrle.s"
	.include "gr_unrle_large.s"
	.include "gr_offsets.s"
	.include "gr_copy.s"
	.include "gr_copy_large.s"
	.include "gr_pageflip.s"

	.include "desire.inc"
	.include "spaceman.inc"
