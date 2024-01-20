	;=============================================================
	; hgr copy from page in A to current DRAW_PAGE but magnify 2x
	;=========================================================

	; would be faster if we unroll it, but much bigger

	; At first from left side of image, eventually arbitrary?

	; destination in A?

hgr_copy_magnify:

	; for (y=0;y<192;y++) {
	;	for(x=0;x<40;x+=2) {
	;		A=src[x];
	;		dest[x]=lookup1[A];
	;		dest[x+1]=lookup2[A];
	;		y++;
	;		dest[x]=lookup1[A];
	;		dest[x+1]=lookup2[A];
	;	}
	; }


	ldx	#0
magnify_outer_loop:
	lda	hposn_low,X
	sta	OUTL

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	OUTH


	lda	hposn_low,X
	sta	INL

	lda	hposn_high,X
	clc
	adc	#$40
	sta	INH

	ldy	#0
magnify_inner_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	cpy	#40
	bne	magnify_inner_loop

	inx
	cpx	#192
	bne	magnify_outer_loop

	rts
