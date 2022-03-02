; dsr Intro

; by deater (Vince Weaver) <vince@deater.net>

; graphics by porta2note

NIBCOUNT = $09

; 2302 bytes when RLE
; 2459 bytes move to lzsa code
; 1060 bytes lzsa the graphics

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

;	lda	#<desire_rle
;	sta	GBASL
;	lda	#>desire_rle
;	sta	GBASH
;	lda	#$c
;	jsr	load_rle_gr

	lda     #<desire_lzsa
        sta     getsrc_smc+1
        lda     #>desire_lzsa
        sta     getsrc_smc+2

        lda     #$c

        jsr     decompress_lzsa2_fast



	jsr	gr_copy_to_current	; copy to page1

	jsr	page_flip

	jsr	wait_until_keypress


	;=============================
	; Load desire 2nd

;	lda	#<desire2_rle
;	sta	GBASL
;	lda	#>desire2_rle
;	sta	GBASH
;	lda	#$c
;	jsr	load_rle_gr


	lda     #<desire2_lzsa
        sta     getsrc_smc+1
        lda     #>desire2_lzsa
        sta     getsrc_smc+2

        lda     #$c

        jsr     decompress_lzsa2_fast


	jsr	gr_copy_to_current	; copy to page1

	jsr	page_flip

	jsr	wait_until_keypress

forever:
	jmp	forever


wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress
	bit	KEYRESET
	rts

	.include "decompress_fast_v2.s"
;	.include "gr_unrle.s"
	.include "gr_offsets.s"
	.include "gr_copy.s"
	.include "gr_pageflip.s"


;	.include "desire.inc"

desire_lzsa:
	.incbin "desire.lzsa"

desire2_lzsa:
	.incbin "desire2.lzsa"

