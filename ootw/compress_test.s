; Test if we can use LZ4 instead of RLE for compression of LORES images
;
;

.include "hardware.inc"
.include "zp.inc"

start:

	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===========================
	; Setup pages

	lda	#4
	sta	DRAW_PAGE
	lda	#0
	sta	DISP_PAGE


	;============================
	; Test RLE version

	jsr	BELL

	lda	#1			; 8
	sta	OFFSET

rle_outer_loop:
	lda	#1			; 100
	sta	GAIT
rle_inner_loop:

	lda	#>(test_rle)
	sta	GBASH
	lda	#<(test_rle)
	sta	GBASL

	lda	#$0c				; load to $c00

	jsr	load_rle_gr

	dec	GAIT
	bne	rle_inner_loop

	dec	OFFSET
	bne	rle_outer_loop


	jsr	BELL

	jsr	gr_copy_to_current
	jsr	page_flip

uz_loop:
	lda	KEYPRESS
	bpl	uz_loop
	bit	KEYRESET


	;======================
	; clear between tests

	lda	DRAW_PAGE
	pha

	lda     #$8		; clear c00
	sta     DRAW_PAGE
        jsr     clear_top
        jsr     clear_bottom

	pla
	sta	DRAW_PAGE

vz_loop:
	lda	KEYPRESS
	bpl	vz_loop
	bit	KEYRESET


	;============================
	; Test LZ4 version

	; point to source
	lda	#<(test_lz4)
	sta	LZ4_SRC
	lda	#>(test_lz4)
	sta	LZ4_SRC+1

	lda     #$C		; page to write to

	jsr	lz4_decode

	jsr	gr_copy_to_current
	jsr	page_flip

forever:
	jmp	forever



.include "gr_unrle.s"
.include "gr_offsets.s"
.include "gr_pageflip.s"
.include "gr_copy.s"
.include "gr_fast_clear.s"
.include "lz4_decode.s"

.include "compress_test.inc"


