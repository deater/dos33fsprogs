.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=============================
	; draw some graphics
	;=============================

dancing:
	bit	KEYRESET	; just to be safe

	lda	#0

	;=================================
	; Dancing
	;=================================
	; FIXME: make this properly animate

	bit	SET_GR
	bit	LORES
	sta	SET80COL	; 80 store
	bit	FULLGR
	sta	CLRAN3		; set double lores
	sta	EIGHTYSTOREON	; PAGE2 remaps MAIN:page2 writes to AUX:page1

        bit	PAGE1   ; start in page1

	lda	#<aha1_main
        sta	zx_src_l+1
        lda	#>aha1_main
        sta	zx_src_h+1
        lda	#$20
        jsr	zx02_full_decomp
	jsr	copy_to_400


        ; auxiliary part
        bit	PAGE2
	lda	#<aha1_aux
	sta	zx_src_l+1
	lda	#>aha1_aux
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp
	jsr	copy_to_400

	; wait a bit

	lda	#3
	jsr	wait_seconds

;	jsr	wait_until_keypress


	rts


aha1_aux:
	.incbin "aha1.aux.zx02"

aha1_main:
	.incbin "aha1.main.zx02"

.include "copy_400.s"
