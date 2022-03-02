; Vertical scroll lo-res

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

NIBCOUNT = $09

; 5529 original
; 3283 using LZSA instead

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
	; Load spaceman top

;	lda	#<spaceman_rle
;	sta	GBASL
;	lda	#>spaceman_rle
;	sta	GBASH
;	lda	#$90
;	jsr	load_rle_large

	lda     #<spaceman_lzsa
        sta     getsrc_smc+1
        lda     #>spaceman_lzsa
        sta     getsrc_smc+2

        lda     #$90

        jsr     decompress_lzsa2_fast


	; Load spaceman bottom

;	lda	#<spaceman2_rle
;	sta	GBASL
;	lda	#>spaceman2_rle
;	sta	GBASH
;	lda	#$A0
;	jsr	load_rle_large


	lda     #<spaceman2_lzsa
        sta     getsrc_smc+1
        lda     #>spaceman2_lzsa
        sta     getsrc_smc+2

        lda     #$a0

        jsr     decompress_lzsa2_fast



rescroll:

	lda	#0
	sta	SCROLL_COUNT

	lda	#<$9000
	sta	TINL
	lda	#>$9000
	sta	TINH

	lda	#<$A000
	sta	BINL
	lda	#>$A000
	sta	BINH

	; delay
	lda	#200
	jsr	WAIT

scroll_loop:
	lda	TINL
	sta	OUTL
	lda	TINH
	sta	OUTH

	jsr	gr_copy_to_current_large	; copy to page1
	jsr	page_flip

	lda	#100
	jsr	WAIT

	lda	BINL
	sta	OUTL
	lda	BINH
	sta	OUTH

	jsr	gr_copy_to_current_large	; copy to page1
	jsr	page_flip

	lda	#100
	jsr	WAIT

	lda	TINL			; inc to next line
	clc
	adc	#$28
	sta	TINL
	lda	TINH
	adc	#$0
	sta	TINH

	lda	BINL			; inc to next line
	clc
	adc	#$28
	sta	BINL
	lda	BINH
	adc	#$0
	sta	BINH

	inc	SCROLL_COUNT
	lda	SCROLL_COUNT

	cmp	#73
	bne	scroll_loop

	jsr	wait_until_keypress

	jmp	rescroll

forever:
	jmp	forever


wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress
	bit	KEYRESET
	rts

;	.include "gr_unrle.s"
;	.include "gr_unrle_large.s"
	.include "decompress_fast_v2.s"
	.include "gr_offsets.s"
;	.include "gr_copy.s"
	.include "gr_copy_large.s"
	.include "gr_pageflip.s"

;	.include "spaceman.inc"
;	.include "spaceman2.inc"

spaceman_lzsa:
	.incbin "spaceman.lzsa"

spaceman2_lzsa:
	.incbin "spaceman2.lzsa"
