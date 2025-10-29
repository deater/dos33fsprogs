; Monsters!

; >>Wer mit Ungeheuern kämpft, mag zusehn,
;   dass er nicht dabei zum Ungeheuer wird.
;   Und wenn du lange in einen Abgrund blickst,
;   blickt der Abgrund auch in dich hinein.<<

;      "Whoever battles monsters should see to it that in the process
;       he does not become a monster.   And if you gaze long enough
;       into an abyss, the abyss will gaze back into you."
;					-- Friedrich Nietzsche

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

	jsr	wait_until_keypress

	;========================
	;========================
	; load pumpkin to Page2
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

	; depack to page2

	lda	#$20
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

	lda	#$20
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_bottom

;	ldx	#$CF
;	jsr	save_zp_x

	sei

	jsr	save_zp

	ldx	#0
;	jsr	wipe_48

;	jsr	do_wipe_fizzle

;	ldx	#$CF
;	jsr	restore_zp_x

	jsr	restore_zp

	cli

	jsr	wait_until_keypress


	;========================
	;========================
	; load pq tree
	;========================
	;========================

	;=============================
	; load top part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<pq_tree_top
	sta	zx_src_l+1
	lda	#>pq_tree_top
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

	lda	#<pq_tree_bottom
	sta	zx_src_l+1
	lda	#>pq_tree_bottom
	sta	zx_src_h+1
	jsr	zx02_full_decomp_main

	; depack to page1

	lda	#$00
	sta	DRAW_PAGE

	lda	#$a0
	jsr	dhgr_repack_bottom

	jsr	wait_until_keypress


	rts

monster1_top:
	.incbin "graphics/monster_pumpkin.raw_top.zx02"

monster1_bottom:
	.incbin "graphics/monster_pumpkin.raw_bottom.zx02"

monster2_top:
	.incbin "graphics/monster-bw5.raw_top.zx02"

monster2_bottom:
	.incbin "graphics/monster-bw5.raw_bottom.zx02"



pq_tree_top:
	.incbin "graphics/pq_tree_dhgr.raw_top.zx02"

pq_tree_bottom:
	.incbin "graphics/pq_tree_dhgr.raw_bottom.zx02"



;monster1_bin:
;	.incbin "graphics/monster_pumpkin.bin.zx02"

;monster1_aux:
;	.incbin "graphics/monster_pumpkin.aux.zx02"

;.include "fx.dhgr.fizzle.s"

.include "wipe_48_all.s"
