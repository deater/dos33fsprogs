.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=============================
	; draw some graphics
	;=============================

headphones:
	bit	KEYRESET	; just to be safe

	lda	#0

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

	lda	#<headphone_bin
        sta	zx_src_l+1
        lda	#>headphone_bin
        sta	zx_src_h+1
        lda	#$20
        jsr	zx02_full_decomp

        ; auxiliary part
        bit	PAGE2
	lda	#<headphone_aux
	sta	zx_src_l+1
	lda	#>headphone_aux
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	; wait a bit

	lda	#1
	jsr	wait_seconds

	jsr	wait_until_keypress

	; disable 80column mode
;	sta	SETAN3
;	sta	CLR80COL
;	sta	EIGHTYCOLOFF
;	bit	PAGE1

	rts

headphone_aux:
	.incbin "headphone.aux.zx02"

headphone_bin:
	.incbin "headphone.bin.zx02"
