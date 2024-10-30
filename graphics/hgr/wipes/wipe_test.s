; test some of the 4cade wipes

.include "zp.inc"
.include "hardware.inc"

wipe_test:
	lda	#0

	bit     SET_GR
        bit     HIRES
        bit     FULLGR
        bit     PAGE1

	;=================================
	; intro
	;=================================

	lda	#<test_graphic
	sta	zx_src_l+1
	lda	#>test_graphic
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	;=================================
	; test wipe...
	;=================================
test_loop:

	jsr	Start

	jsr	wait_until_keypress
	jmp	test_loop



test_graphic:
	.incbin "graphics/a2_dating.hgr.zx02"

.include "wait_keypress.s"
.include "zx02_optim.s"

.include "fx.hgr.bubbles.s"
