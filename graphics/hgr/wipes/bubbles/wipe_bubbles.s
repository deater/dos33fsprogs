; test some of the 4cade wipes

.include "../zp.inc"
.include "../hardware.inc"

wipe_test:
	jmp	after
test_graphic:
	.incbin "../graphics/a2_dating.hgr.zx02"

.include "../zx02_optim.s"

.include "../fx.lib.s"

after:

       jsr     BuildHGRTables
       jsr     BuildHGRMirrorTables
       jsr     BuildHGRMirrorCols
       jsr     BuildHGRSparseBitmasks1Bit

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

;	ldy	#0
;fake_hgr2:
;	lda	#$0
;	sta	$4000,Y
;	dey
;	bne	fake_hgr2
;
;	inc	fake_hgr2+2
;	lda	fake_hgr2+2
;	cmp	#$60
;	bne	fake_hgr2


	jsr	HGR2
	bit	PAGE1

	jsr	wait_until_keypress

	;=================================
	; test wipe...
	;=================================
test_loop:

	jsr	InitOnce

	jsr	wait_until_keypress
	jmp	test_loop

.include "../wait_keypress.s"


.include "fx.hgr.bubbles.s"

; possibly some bytes before get chewed on with some effects?

.align $100
Coordinates1Bit:
	.incbin "fx.hgr.bubbles.data"
EndCoordinates1Bit:
