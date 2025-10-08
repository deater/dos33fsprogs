; test 4-cade dhgr redlines wipe

.include "../zp.inc"
.include "../hardware.inc"

wipe_diamond:

	;==================
	; set graphics mode
	;==================

	bit     SET_GR
        bit     HIRES
        bit     FULLGR
	sta	AN3
	sta	EIGHTYCOLON
	sta	SET80COL

        bit     PAGE1

	;=================================
	; intro
	;=================================

	; bin part

	lda	#<test_graphic_bin
	sta	zx_src_l+1
	lda	#>test_graphic_bin
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	; aux part

	bit	PAGE2

	lda	#<test_graphic_aux
	sta	zx_src_l+1
	lda	#>test_graphic_aux
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	;=================================
	; test wipe...
	;=================================
test_loop:

	jsr	BuildHGRTables

	jsr	do_wipe_redlines

	jsr	wait_until_keypress
	jmp	test_loop

.include "../wait_keypress.s"

.include "../fx.lib.s"
.include "../main_macros.s"
.include "../macros.hgr.s"

.include "fx.dhgr.redlines.s"

test_graphic_aux:
	.incbin "../graphics/a2_nine.aux.zx02"
test_graphic_bin:
	.incbin "../graphics/a2_nine.bin.zx02"

.include "../zx02_optim.s"

.include "../vblank.s"

