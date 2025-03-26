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
	; load graphic to $A000

	lda	#$80
	sta	DRAW_PAGE

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

	lda	#$20
	sta	DRAW_PAGE

	;=================================
	; clear screens

	jsr	clear_dhgr_screens

	;=================================
	; copy graphic to off-screen page1

	ldx	#0
	ldy	#128
	lda	#64
	jsr	slow_copy_main

	ldx	#0
	ldy	#128
	lda	#64
	jsr	slow_copy_aux

	jsr	wait_vblank
	jsr	hgr_page_flip

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


	jsr	clear_dhgr_screens

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

	jsr	clear_dhgr_screens

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

headphone_bin:
	.incbin "headphones.bin.zx02"

hip1_bin:
	.incbin "hip1.bin.zx02"
hip2_bin:
	.incbin "hip2.bin.zx02"
hip3_bin:
	.incbin "hip3.bin.zx02"


headphone_aux:
	.incbin "headphones.aux.zx02"
hip1_aux:
	.incbin "hip1.aux.zx02"
hip2_aux:
	.incbin "hip2.aux.zx02"
hip3_aux:
	.incbin "hip3.aux.zx02"

