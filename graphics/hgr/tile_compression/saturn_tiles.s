; tiles compression test

.include "zp.inc"
.include "hardware.inc"


hposn_high     = $1000
hposn_low      = $1100

XPOS = $E0
YPOS = $E1
ROW  = $E2

saturn_tiles_start:


	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#0
	sta	XPOS
	sta	YPOS

	jsr	hgr_make_tables

	; for(t=0;t<40*24;t++)
tilemap_loop:

tilemap_smc:
	lda	tilemap
	cmp	#$ff
	beq	tilemap_done

	tax
	lda	tile_lookup_l,X
	sta	tile_smc+1
	lda	tile_lookup_h,X
	sta	tile_smc+2


	lda	#0
	sta	ROW
inner_loop:

	clc
	lda	YPOS
	adc	ROW
	tax

	lda	hposn_low,X
	sta	output_smc+1
	lda	hposn_high,X
	sta	output_smc+2

	ldx	ROW
	ldy	XPOS
tile_smc:
	lda	tile0,X
output_smc:
	sta	$2000,Y

	inc	ROW
	lda	ROW
	cmp	#8
	bne	inner_loop

	;
	;
	;

	inc	XPOS
	lda	XPOS
	cmp	#40
	bne	no_xpos_oflo

	lda	#0
	sta	XPOS

	lda	YPOS
	clc
	adc	#8
	sta	YPOS

no_xpos_oflo:

	inc	tilemap_smc+1
	bne	tilemap_noflo

	inc	tilemap_smc+2
tilemap_noflo:
	jmp	tilemap_loop

tilemap_done:


forever:
	jmp	forever

	.include "hgr_table.s"

	.include "graphics/saturn_tiles.inc"
