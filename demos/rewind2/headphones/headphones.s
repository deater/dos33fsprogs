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

	lda	#0

	;=================================
	; Scrolling Headphones
	;=================================
	; TODO: scroll them in?

	bit	SET_GR
        bit	HIRES
        bit	FULLGR
        sta	AN3             ; set double hires
        sta	EIGHTYCOLON     ; 80 column
;        sta	SET80COL        ; 80 store

        bit	PAGE1   ; start in page1

	lda	#<headphone_bin
        sta	zx_src_l+1
        lda	#>headphone_bin
        sta	zx_src_h+1
        lda	#$20
        jsr	zx02_full_decomp

        ; auxiliary part
;        bit	PAGE2
;	lda	#<headphone_aux
;	sta	zx_src_l+1
;	lda	#>headphone_aux
;	sta	zx_src_h+1
;	lda	#$20
;	jsr	zx02_full_decomp

	; wait a bit

	lda	#3
	jsr	wait_seconds

;	jsr	wait_until_keypress


hip1:
	bit	KEYRESET	; just to be safe

	lda	#0

	bit	PAGE1
	lda	#<hip1_bin
        sta	zx_src_l+1
        lda	#>hip1_bin
        sta	zx_src_h+1
        lda	#$20
        jsr	zx02_full_decomp

        ; auxiliary part
;       bit	PAGE2
;	lda	#<hip1_aux
;	sta	zx_src_l+1
;	lda	#>hip1_aux
;	sta	zx_src_h+1
;	lda	#$20
;	jsr	zx02_full_decomp

	; wait a bit

	lda	#1
	jsr	wait_seconds

hip2:
	bit	KEYRESET	; just to be safe

	lda	#0

	bit	PAGE1
	lda	#<hip2_bin
        sta	zx_src_l+1
        lda	#>hip2_bin
        sta	zx_src_h+1
        lda	#$20
        jsr	zx02_full_decomp

        ; auxiliary part
;        bit	PAGE2
;	lda	#<hip2_aux
;	sta	zx_src_l+1
;	lda	#>hip2_aux
;	sta	zx_src_h+1
;	lda	#$20
;	jsr	zx02_full_decomp

	; wait a bit

	lda	#1
	jsr	wait_seconds


hip3:
	bit	KEYRESET	; just to be safe

	lda	#0

	bit	PAGE1
	lda	#<hip3_bin
        sta	zx_src_l+1
        lda	#>hip3_bin
        sta	zx_src_h+1
        lda	#$20
        jsr	zx02_full_decomp

        ; auxiliary part
 ;       bit	PAGE2
;	lda	#<hip3_aux
;	sta	zx_src_l+1
;	lda	#>hip3_aux
;	sta	zx_src_h+1
;	lda	#$20
;	jsr	zx02_full_decomp

	; wait a bit

	lda	#1
	jsr	wait_seconds


	rts

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

