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
	sta	DANCE_COUNT

	;=================================
	; Dancing
	;=================================

	bit	SET_GR
	bit	LORES
	sta	SET80COL	; 80 store
	bit	FULLGR
	sta	CLRAN3		; set double lores
	sta	EIGHTYSTOREON	; PAGE2 remaps MAIN:page2 writes to AUX:page1

        bit	PAGE1   ; start in page1

	lda	#<aha_main
        sta	zx_src_l+1
        lda	#>aha_main
        sta	zx_src_h+1
        lda	#$40
        jsr	zx02_full_decomp


        ; auxiliary part

	lda	#<aha_aux
	sta	zx_src_l+1
	lda	#>aha_aux
	sta	zx_src_h+1
	lda	#$70
	jsr	zx02_full_decomp

	; wait a bit
animate_loop:
	bit	PAGE1

	ldy	DANCE_COUNT
	ldx	animation_main,Y

;	ldx	#$40
	jsr	copy_to_400

	bit	PAGE2

	ldy	DANCE_COUNT
	ldx	animation_aux,Y
;	ldx	#$70
	jsr	copy_to_400

	jsr	wait_until_keypress

	inc	DANCE_COUNT
	lda	DANCE_COUNT
	cmp	#4
	bne	animate_loop
	lda	#0
	sta	DANCE_COUNT
	beq	animate_loop

	rts

animation_aux:
	.byte $70,$74,$78,$7c

animation_main:
	.byte $40,$44,$48,$4c

aha_aux:
	.incbin "aha.aux.zx02"

aha_main:
	.incbin "aha.main.zx02"

.include "copy_400.s"
