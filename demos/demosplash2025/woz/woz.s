.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=============================
	; draw monsters
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


	;=======================
	; load graphic to page1

	lda	#$0
	sta	DRAW_PAGE

	lda	#<monster1_bin
	sta	zx_src_l+1
	lda	#>monster1_bin
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	lda	#<monster1_aux
	sta	zx_src_l+1
	lda	#>monster1_aux
	sta	zx_src_h+1
	jsr	zx02_full_decomp_aux

	; wait a bit

	lda	#5
	jsr	wait_seconds



	rts




monster1_bin:
	.incbin "graphics/monster_pumpkin.bin.zx02"

monster1_aux:
	.incbin "graphics/monster_pumpkin.aux.zx02"
