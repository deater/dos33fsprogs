	;=========================================================
	; gr_make_quake
	;=========================================================
	; Take image in 0xc00
	; 	Copy to 0x1000
	;	Actually copy lines 2..41 to 0..39
gr_make_quake:

	ldx	#0
make_quake_loop:
	lda	gr_offsets,x
	sta	OUTL
	lda	gr_offsets+1,x
	clc
	adc	#$C
	sta	OUTH

	inx
	inx

	lda	gr_offsets,x
	sta	INL
	lda	gr_offsets+1,x
	clc
	adc	#$8
	sta	INH

	ldy	#39
quake_inner:
	lda	(INL),Y
	sta	(OUTL),Y

	dey
	bpl	quake_inner

	cpx	#40
	bne	make_quake_loop

	; write zeros to the rest

quake_clear_bottom:
	lda	gr_offsets,x
	sta	OUTL
	lda	gr_offsets+1,x
	clc
	adc	#$C
	sta	OUTH

	inx
	inx

	ldy	#39
	lda	#0
quake_clear_inner:
	sta	(OUTL),Y
	dey
	bpl	quake_clear_inner

	cpx	#48
	bne	quake_clear_bottom

	; clear the extra two lines from the original
quake_clear_extra:

	ldx	#40
	lda	gr_offsets,x
	sta	OUTL
	lda	gr_offsets+1,x
	clc
	adc	#$8
	sta	OUTH

	ldy	#39
	lda	#0
quake_clear_extra_inner:
	sta	(OUTL),Y
	dey
	bpl	quake_clear_extra_inner

	rts								; 6


