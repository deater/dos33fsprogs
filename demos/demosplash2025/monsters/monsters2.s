; Monsters 2!

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=============================
	; draw more monsters
	;=============================

monsters2:
	bit	KEYRESET	; just to be safe

	;=================================
	; init graphics
	;=================================

	; come in HGR mode, so switch back to dhgr

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	sta	AN3		; set double hires
	sta	EIGHTYCOLON	; 80 column
	sta	CLR80COL
;	sta	SET80COL	; (allow page1/2 flip main/aux)

	bit	PAGE1		; display page1
;	lda	#$20
;	sta	DRAW_PAGE	; draw to page2

	;========================
	;========================
	; load monster
	;========================
	;========================

	;=============================
	; load top part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<monster2_top
	sta	zx_src_l+1
	lda	#>monster2_top
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	; depack to page1

	lda	#$00
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_top


	;=============================
	; load bottom part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<monster2_bottom
	sta	zx_src_l+1
	lda	#>monster2_bottom
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	; depack to page1

	lda	#$00
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_bottom

	;============================
	; wait a bit

	lda	#1
	jsr	wait_seconds

	;========================
	;========================
	; load pumpkin
	;========================
	;========================

	;=============================
	; load top part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<monster1_top
	sta	zx_src_l+1
	lda	#>monster1_top
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	; depack to page1

	lda	#$00
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_top


	;=============================
	; load bottom part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<monster1_bottom
	sta	zx_src_l+1
	lda	#>monster1_bottom
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	; depack to page1

	lda	#$00
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_bottom

	;============================
	; wait a bit

	lda	#1
	jsr	wait_seconds


	;========================
	;========================
	; load pq cave
	;========================
	;========================

	;=============================
	; load top part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<pq_cave_top
	sta	zx_src_l+1
	lda	#>pq_cave_top
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	; depack to page1

	lda	#$00
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_top


	;=============================
	; load bottom part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<pq_cave_bottom
	sta	zx_src_l+1
	lda	#>pq_cave_bottom
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	; depack to page1

	lda	#$00
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_bottom


	;============================
	; wait a bit

	lda	#1
	jsr	wait_seconds


	rts

monster1_top:
	.incbin "graphics/monster_hand.raw_top.zx02"

monster1_bottom:
	.incbin "graphics/monster_hand.raw_bottom.zx02"

monster2_top:
	.incbin "graphics/monster-bw7.raw_top.zx02"

monster2_bottom:
	.incbin "graphics/monster-bw7.raw_bottom.zx02"



pq_cave_top:
	.incbin "graphics/pq_cave_dhgr.raw_top.zx02"

pq_cave_bottom:
	.incbin "graphics/pq_cave_dhgr.raw_bottom.zx02"


