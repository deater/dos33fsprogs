; XMAS 2024

.include "hardware.inc"
.include "zp.inc"
.include "qload.inc"
.include "music.inc"


xmas_main:

	; clear extraneous keypresses

	bit KEYRESET

	;======================================
	; init
	;======================================


	;======================================
	; clear screen to black, HGR PAGE1
	;======================================

	lda	#$00
	jsr	hgr_page1_clearscreen

	bit	SET_GR
	bit	HIRES
	bit	PAGE1

	;======================================
	; star-wipe to Merry Christmas
	;======================================

	jsr	wipe_star

	;======================================
	; Load guinea pig from disk
	;======================================

	lda     #4		; load Guinea Pig from disk
	sta     WHICH_LOAD

	jsr     load_file

	;======================================
	; star ripple wipe this time
	;======================================

	jsr	save_zp

	jsr     RippleCoordinates2Bit

	jsr	wipe_star

	jsr	restore_zp

	;======================================
	; start music
	;======================================

	cli

repeat:

	jsr	do_scroll



finished:
	jmp	repeat


save_zp:
	ldx	#0
save_zp_loop:
	lda	$0,X
	sta	$6100,X
	inx
	bne	save_zp_loop
	rts

restore_zp:
	ldx	#0
restore_zp_loop:
	lda	$6100,X
	sta	$0,X
	inx
	bne	restore_zp_loop
	rts




.include "wait_keypress.s"
.include "irq_wait.s"

.include "wipe_star.s"

.include "horiz_scroll.s"
.include "font/large_font.inc"
.include "hgr_page_flip.s"
.include "vblank.s"

;gp_hat_graphics:
;.incbin "graphics/gp_hgr.zx02"
