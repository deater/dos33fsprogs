.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=============================
	; draw easter picture
	;=============================

easter:

	jmp	skip

bucket_bottom_bin:
	.incbin "bucket_bottom.bin.zx02"

bucket_top_bin:
	.incbin "bucket_top.bin.zx02"

skip:

	bit	KEYRESET	; just to be safe

	;=================================
	; Scrolling Bucket
	;=================================

	;=================================
	; init graphics
	;=================================



	bit	SET_GR
        bit	HIRES
        bit	FULLGR
        sta	AN3		; set double hires
        sta	EIGHTYCOLON	; 80 column
	sta	CLR80COL
;	sta	SET80COL	; 80 store

        bit	PAGE1		; display page1
	lda	#$20
	sta	DRAW_PAGE	; draw to page2


	;===================================
	; copy bucket_top_aux to $4000:AUX

	lda	#$40			; AUX page start (dest)
	ldy	#>bucket_top_aux	; MAIN page start (src)
	ldx	#32			; NUM PAGES
	jsr	copy_main_aux

	;===========================================
	; decompress bucket_top_aux to AUX:$A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<bucket_top_aux
	sta	zx_src_l+1
	lda	#$40
	sta	zx_src_h+1
	jsr	zx02_full_decomp_aux

	;===================================
	; copy bucket_bottom_aux to $4000:AUX

	lda	#$40			; AUX page start (dest)
	ldy	#>bucket_bottom_aux	; MAIN page start (src)
	ldx	#32			; NUM PAGES
	jsr	copy_main_aux

	;===========================================
	; decompress bucket_bottom_aux to AUX:$8000

	lda	#$60
	sta	DRAW_PAGE

	lda	#<bucket_bottom_aux
	sta	zx_src_l+1
	lda	#$40
	sta	zx_src_h+1
	jsr	zx02_full_decomp_aux


	;===========================================
	; decompress bucket_top_bin to MAIN:$A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<bucket_top_bin
	sta	zx_src_l+1
	lda	#>bucket_top_bin
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	;===========================================
	; decompress bucket_bottom_bin to MAIN:$8000

	lda	#$60
	sta	DRAW_PAGE

	lda	#<bucket_bottom_bin
	sta	zx_src_l+1
	lda	#>bucket_bottom_bin
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	;=================================
	; clear screens

	jsr	clear_dhgr_screens


	;================================
	; set up initial graphics
	;================================
prep_for_scroll:

	;=================================
	; copy full bottom graphic to off-screen page1

	; from $8000 - $2000/$4000
	; X = start Y = len  A=offset

	ldx	#0			; $A000
	ldy	#192			; 128 lines?
	lda	#0			; start 64 lines in
	jsr	slow_copy_main

	ldx	#0
	ldy	#192
	lda	#0
	jsr	slow_copy_aux

	jsr	wait_vblank
	jsr	hgr_page_flip

oog:
	jmp oog

	;========================
	; copy graphic to page 2

	ldx	#0			; line in PAGE1/PAGE2 to output to
	ldy	#128			; lines to copy
	lda	#63			; line to start in $A000
	jsr	slow_copy_main

	ldx	#0
	ldy	#128
	lda	#63
	jsr	slow_copy_aux

	jsr	wait_vblank
	jsr	hgr_page_flip


	;==================
	; scroll a bit

	lda	#62
	sta	SCROLL_COUNT

scroll_loop:

	; scroll
	jsr	hgr_vertical_scroll_main

	ldx	#0
	ldy	#2
	lda	SCROLL_COUNT
	jsr	slow_copy_main

	jsr	hgr_vertical_scroll_aux

	ldx	#0
	ldy	#2
	lda	SCROLL_COUNT
	jsr	slow_copy_aux

	jsr	wait_vblank
	jsr	hgr_page_flip

	dec	SCROLL_COUNT
	bne	scroll_loop



	; wait a bit

	lda	#1
	jsr	wait_seconds


;	jsr	clear_dhgr_screens

	rts


	;===================================
	; clear dhgr screens
	;===================================
clear_dhgr_screens:
	jsr	hgr_clear_screen
	sta	WRAUX
	jsr	hgr_clear_screen
	sta	WRMAIN
	jsr	hgr_page_flip

	jsr	hgr_clear_screen
	sta	WRAUX
	jsr	hgr_clear_screen
	sta	WRMAIN
	jsr	hgr_page_flip

	rts

bucket_bottom_aux:
	.incbin "bucket_bottom.aux.zx02"

bucket_top_aux:
	.incbin "bucket_top.aux.zx02"

