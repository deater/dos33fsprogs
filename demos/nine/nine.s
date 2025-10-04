; VMW Productions DHIRES/ZX02 image viewer
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


nine_start:


	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	sta	AN3		; set double hires
	sta	EIGHTYCOLON	; 80 column
	sta	SET80COL	; 80 store

	bit	PAGE1	; start in page1


	;===================
	; Load graphics
	;===================
load_loop:

	jsr	load_image

wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

which_ok:
	jmp	load_loop


	;==========================
	; Load Image
	;===========================

load_image:
	bit	PAGE1

	lda	#<woz_bin
	sta	zx_src_l+1

	lda	#>woz_bin
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; auxiliary part

	bit	PAGE2

	lda	#<woz_aux
	sta	zx_src_l+1

	lda	#>woz_aux
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	rts

	.include	"zx02_optim.s"

woz_aux:
	.incbin "graphics/a2_nine_woz.aux.zx02"
woz_bin:
	.incbin "graphics/a2_nine_woz.bin.zx02"
