	;=========================================================
	; gr_copy_at_offset, 40x48 version
	;=========================================================
	; copy $1000 + line offset to $c00
	; offset is in Y
	; FIXME: smaller code if put offset in A instead?

gr_copy_to_offset:

	lda	#0
	sta	TEMPY

gr_copy_offset_outer_loop:

	; calculate source

	lda	gr_offsets_h,Y
	clc
	adc	#$c
	sta	gr_copy_offset_smc_src+2
	lda	gr_offsets_l,Y
	sta	gr_copy_offset_smc_src+1
	tya
	pha

	; calculate destination

	lda	TEMPY
	tay
	lda	gr_offsets_h,Y
	clc
	adc	#$8
	sta	gr_copy_offset_smc_dst+2
	lda	gr_offsets_l,Y
	sta	gr_copy_offset_smc_dst+1

	ldx	#0
gr_copy_offset_line_loop:

gr_copy_offset_smc_src:
	lda	$1000,X
gr_copy_offset_smc_dst:
	sta	$c00,X

	inx
	cpx	#40
	bne	gr_copy_offset_line_loop

	inc	TEMPY
	pla
	tay
	iny

	cpy	#24
	bne	gr_copy_offset_outer_loop

	rts								; 6



