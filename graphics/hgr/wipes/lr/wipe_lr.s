; test 4-cade diamond wipe

.include "../zp.inc"
.include "../hardware.inc"

wipe_diamond:

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

	jsr	do_wipe_lr

	jsr	wait_until_keypress
	jmp	test_loop

.include "../wait_keypress.s"

.include "../fx.lib.s"
.include "../main_macros.s"
.include "../macros.hgr.s"

.include "fx.hgr.2pass.lr.s"

test_graphic:
	.incbin "../graphics/a2_dating.hgr.zx02"

.include "../zx02_optim.s"

;.include "../vblank.s"

;.include "../wait_for_key.s"
