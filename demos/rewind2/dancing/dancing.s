.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=================================
	; Dancing
	;=================================

dancing:
	bit	KEYRESET	; just to be safe

	lda	#0
	sta	DANCE_COUNT
	sta	DRAW_PAGE	; DRAW PAGE1

	;==========================
	; TODO: clear both screens

	;=============================
	; Init Double lo-res graphics
	;=============================

	bit	SET_GR
	bit	LORES
	sta	EIGHTYCOLON	; 80 column mode
	bit	FULLGR
	sta	CLRAN3		; set double lores
	sta	EIGHTYSTOREOFF	; normal PAGE1/PAGE2 behavior
        bit	PAGE2		; DISPLAY PAGE2

	;==============================
	; decompress graphics (main)
	;==============================

	lda	#<aha_main
        sta	zx_src_l+1
        lda	#>aha_main
        sta	zx_src_h+1
        lda	#$40
        jsr	zx02_full_decomp

	;==============================
	; decompress graphics (aux)
	;==============================

	lda	#<aha_aux
	sta	zx_src_l+1
	lda	#>aha_aux
	sta	zx_src_h+1
	lda	#$70
	jsr	zx02_full_decomp

	;==============================
	; animate loop
	;==============================

animate_loop:

	;================================
	; start 5-tick (10Hz) countdown

	lda	#5
	sta	IRQ_COUNTDOWN

	;================================
	; copy in MAIN graphics

	sta	WRMAIN
	ldy	DANCE_COUNT
	ldx	animation_main,Y
	jsr	copy_to_400

	;================================
	; copy in AUX graphics


	sta	WRAUX
	ldy	DANCE_COUNT
	ldx	animation_aux,Y
	jsr	copy_to_400
	sta	WRMAIN

	;============================
	; wait until 5 frames are up

wait_10hz:
	jsr	check_timeout
	bcc	wait_10hz

	jsr	wait_vblank

	;============================
	; page flip

	jsr	gr_flip_page

	;==============================
	; move to next animation frame


	inc	DANCE_COUNT
	lda	DANCE_COUNT
	cmp	#12
	bne	animate_loop
	lda	#0
	sta	DANCE_COUNT
	beq	animate_loop

	rts

animation_aux:
	.byte $70,$74,$78,$7c
	.byte $80,$84,$88,$8c
	.byte $90,$94,$98,$9c

animation_main:
	.byte $40,$44,$48,$4c
	.byte $50,$54,$58,$5c
	.byte $60,$64,$68,$6c

aha_aux:
	.incbin "aha.aux.zx02"

aha_main:
	.incbin "aha.main.zx02"


