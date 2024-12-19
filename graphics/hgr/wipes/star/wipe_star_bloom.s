; test some of the 4cade wipes

; Star Bloom

.include "../zp.inc"
.include "../hardware.inc"

Coordinates2Bit=$8100
EndCoordinates2Bit = Coordinates2Bit + (origEndCoordinates2Bit-origCoordinates2Bit)

wipe_star_bloom:

	; from code.hgr.precomputed.2bit

	jsr	BuildHGRTables
	jsr	BuildHGRMirrorCols
	jsr	BuildHGRSparseBitmasks2Bit


	bit     SET_GR
        bit     HIRES
        bit     FULLGR
        bit     PAGE1

	;=================================
	; intro
	;=================================


	; copy data table to $8100

	ldx	#((>origEndCoordinates2Bit)-(>origCoordinates2Bit))

outer_copy_coords_loop:
	ldy	#0
copy_coords_loop:

col_smc1:
	lda	origCoordinates2Bit,Y
col_smc2:
	sta	Coordinates2Bit,Y
	iny
	bne	copy_coords_loop

	inc	col_smc1+2
	inc	col_smc2+2

	dex
	bpl	outer_copy_coords_loop

	jsr	HGR2
	jsr	HGR
	bit	FULLGR

do_it_again:



oog:
	lda	#$FF
	jsr	BKGND0

	jsr	wait_until_keypress

	;=================================
	; test wipe...
	;=================================
test_loop:

	jsr	InitOnce

	jsr	wait_until_keypress

	dec	oog+1

	jmp	do_it_again

.include "../wait_keypress.s"

.include "../fx.lib.s"

.include "fx.hgr.star.s"

; possibly some bytes before get chewed on with some effects?

.align $100
origCoordinates2Bit:
	.incbin "fx.hgr.star_bloom.data"
origEndCoordinates2Bit:
