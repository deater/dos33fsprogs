.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"


	;=============================
	; draw some graphics
	;=============================

graphics:
	lda	#0

	bit     SET_GR
        bit     HIRES
        bit     FULLGR
        bit     PAGE1

	;=================================
	; floater
	;=================================

	lda	#<floater_graphics
	sta	zx_src_l+1
	lda	#>floater_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress


	;=================================
	; World 233
	;=================================

	bit	SET_GR
        bit	HIRES
        bit	FULLGR
        sta	AN3             ; set double hires
        sta	EIGHTYCOLON     ; 80 column
        sta	SET80COL        ; 80 store

        bit	PAGE1   ; start in page1

	lda	#<riven_233_graphics_bin
        sta	zx_src_l+1
        lda	#>riven_233_graphics_bin
        sta	zx_src_h+1
        lda	#$20
        jsr	zx02_full_decomp

        ; auxiliary part
        bit	PAGE2
	lda	#<riven_233_graphics_aux
	sta	zx_src_l+1
	lda	#>riven_233_graphics_aux
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	; disable 80column mode
	sta	SETAN3
	jsr	CLR80COL
	jsr	EIGHTYCOLOFF

	rts

floater_graphics:
;	.incbin "graphics/floater_wide_steffest.hgr.zx02"
;	.incbin "graphics/a2_atrus.hgr.zx02"
;	.incbin "graphics/atrus_iipix.hgr.zx02"
	.incbin "graphics/atrus_light_iipix.hgr.zx02"

riven_233_graphics_aux:
;	.incbin "graphics/riven_233.aux.zx02"
	.incbin "graphics/atrus.aux.zx02"

riven_233_graphics_bin:
;	.incbin "graphics/riven_233.bin.zx02"
	.incbin "graphics/atrus.bin.zx02"


;.include "../wait_keypress.s"
