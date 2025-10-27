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

;	bit	SET_GR
;	bit	HIRES
;	bit	FULLGR
;	sta	AN3		; set double hires
;	sta	EIGHTYCOLON	; 80 column
;	sta	CLR80COL
;	sta	SET80COL	; (allow page1/2 flip main/aux)

	bit	PAGE1		; display page1
	lda	#$20
	sta	DRAW_PAGE	; draw to page2


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
	; wait a bit

	jsr	wait_until_keypress


	rts




woz_top:
	.incbin "graphics/nine_woz.raw_top.zx02"

woz_bottom:
	.incbin "graphics/nine_woz.raw_bottom.zx02"
