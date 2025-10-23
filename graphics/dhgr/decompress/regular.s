.include "zp.inc"
.include "hardware.inc"

	;=============================
	; Regular DHGR image load
	;=============================

regular_dhgr:

	bit	KEYRESET	; just to be safe

	;=================================
	; init graphics
	;=================================

	; We are first to run, so init double-hires

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	sta	AN3		; set double hires
	sta	EIGHTYCOLON	; 80 column
	sta	CLR80COL
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

	lda	#$20			; load to MAIN DHGR PAGE0

	jsr	zx02_full_decomp

	lda	#<monster1_aux
	sta	zx_src_l+1
	lda	#>monster1_aux
	sta	zx_src_h+1

	lda	#$A0			; load to MAIN $A0 (temporary)

	jsr	zx02_full_decomp

	; copy to AUX DHGR PAGE0

	lda	#$20            ; AUX page start (dest)
	ldy	#$A0            ; MAIN page start (src)
	ldx	#$20            ; num pages

        jsr	copy_main_aux


	bit	PAGE1		; be sure on PAGE1

stay_forever:
	jmp	stay_forever

.include "zx02_optim.s"
.include "aux_memcopy.s"

monster1_bin:
	.incbin "graphics/monster_pumpkin.bin.zx02"

monster1_aux:
	.incbin "graphics/monster_pumpkin.aux.zx02"
