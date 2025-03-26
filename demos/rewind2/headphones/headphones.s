.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=============================
	; draw headphone graphics
	;=============================

headphones:
	bit	KEYRESET	; just to be safe

	;=================================
	; Scrolling Headphones
	;=================================
	; TODO: scroll them in?

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

	;=======================
	; load graphic to page2

	lda	#<headphone_bin
        sta	zx_src_l+1
        lda	#>headphone_bin
        sta	zx_src_h+1
        jsr	zx02_full_decomp_main

	lda	#<headphone_aux
	sta	zx_src_l+1
	lda	#>headphone_aux
	sta	zx_src_h+1
	jsr	zx02_full_decomp_aux

	jsr	wait_vblank
	jsr	hgr_page_flip

	;========================
	; load graphic to page 1

	lda	#<headphone_bin
        sta	zx_src_l+1
        lda	#>headphone_bin
        sta	zx_src_h+1
        jsr	zx02_full_decomp_main

	lda	#<headphone_aux
	sta	zx_src_l+1
	lda	#>headphone_aux
	sta	zx_src_h+1
	jsr	zx02_full_decomp_aux

	jsr	wait_vblank
	jsr	hgr_page_flip

	;==================
	; scroll a bit

	lda	#64
	sta	SCROLL_COUNT

scroll_loop:

	jsr	hgr_vertical_scroll
	jsr	wait_vblank
	jsr	hgr_page_flip

	dec	SCROLL_COUNT
	bne	scroll_loop



	; wait a bit

	lda	#3
	jsr	wait_seconds

	;=======================
	; hip1

hip1:
	bit	KEYRESET	; just to be safe

	lda	#<hip1_bin
	sta	zx_src_l+1
	lda	#>hip1_bin
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

        ; auxiliary part
	lda	#<hip1_aux
	sta	zx_src_l+1
	lda	#>hip1_aux
	sta	zx_src_h+1
	jsr	zx02_full_decomp_aux

	jsr	wait_vblank
	jsr	hgr_page_flip

	; wait a bit

	lda	#20
	jsr	wait_ticks

hip2:
	bit	PAGE1
	lda	#<hip2_bin
	sta	zx_src_l+1
	lda	#>hip2_bin
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

        ; auxiliary part
	lda	#<hip2_aux
	sta	zx_src_l+1
	lda	#>hip2_aux
	sta	zx_src_h+1
	jsr	zx02_full_decomp_aux

	jsr	wait_vblank
	jsr	hgr_page_flip

	; wait a bit

	lda	#20
	jsr	wait_ticks


hip3:
	bit	KEYRESET	; just to be safe

	lda	#0

	lda	#<hip3_bin
	sta	zx_src_l+1
	lda	#>hip3_bin
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp_main

        ; auxiliary part
	lda	#<hip3_aux
	sta	zx_src_l+1
	lda	#>hip3_aux
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp_aux

	jsr	wait_vblank
	jsr	hgr_page_flip

	; wait a bit

	lda	#20
	jsr	wait_ticks


	rts

	.include "vertical_scroll.s"

headphone_bin:
	.incbin "headphone.bin.zx02"

hip1_bin:
	.incbin "hip1.bin.zx02"
hip2_bin:
	.incbin "hip2.bin.zx02"
hip3_bin:
	.incbin "hip3.bin.zx02"


headphone_aux:
	.incbin "headphone.aux.zx02"
hip1_aux:
	.incbin "hip1.aux.zx02"
hip2_aux:
	.incbin "hip2.aux.zx02"
hip3_aux:
	.incbin "hip3.aux.zx02"

